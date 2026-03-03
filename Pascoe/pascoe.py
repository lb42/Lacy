#!/usr/bin/env python3
"""
tei_tagger.py
=============
Splits Pascoe's "Dramatic List" into chunks of up to N entries, sends each
chunk to the Claude API for TEI tagging, and saves the results as numbered
XML files. A progress file tracks completed chunks so the script can be
safely interrupted and restarted.

Usage
-----
    python tei_tagger.py [options]

Options
-------
    --input   PATH   Path to the plain-text source file
                     (default: PascoeDramaticLists.txt)
    --outdir  DIR    Directory for output XML files (default: tei_output)
    --chunk   N      Max entries per chunk (default: 10)
    --model   MODEL  Claude model string
                     (default: claude-sonnet-4-20250514)
    --resume         Skip chunks whose output file already exists
    --dry-run        Show the chunk breakdown without calling the API

Requirements
------------
    pip install anthropic
    Set the environment variable ANTHROPIC_API_KEY before running:
        export ANTHROPIC_API_KEY=sk-ant-...
"""

import anthropic
import argparse
import json
import os
import re
import sys
import time
from pathlib import Path


# ---------------------------------------------------------------------------
# Entry detection
# ---------------------------------------------------------------------------

# Biographical entries start with an ALL-CAPS surname, e.g.:
#   ADDISON. CARLOTTA (Mrs. Charles A. La Trobe),
#   ANDERSON, JAMES R,
#   AMALIA, MISS,
ENTRY_HEADER_RE = re.compile(
    r"""
    ^                    # start of line
    [A-Z][A-Z\s\-'\.]+  # all-caps word(s) for surname
    [,\.]                # separator
    \s+
    [A-Z]                # first letter of given name / title
    """,
    re.VERBOSE,
)

# Stand-alone section markers treated as single entries
SECTION_MARKER_RE = re.compile(
    r"^(THE DRAMATIC LIST\.?|INDEX|APPENDIX)\s*$"
)


def is_entry_start(line: str) -> bool:
    stripped = line.strip()
    if not stripped:
        return False
    if SECTION_MARKER_RE.match(stripped):
        return True
    return bool(ENTRY_HEADER_RE.match(stripped))


def split_into_entries(text: str) -> list:
    """
    Split the raw text into individual entries.
    Boilerplate before the first real entry (title page etc.) is discarded.
    """
    lines = text.splitlines(keepends=True)
    entries = []
    current = []
    in_entries = False

    for line in lines:
        if is_entry_start(line):
            if current and in_entries:
                entries.append("".join(current).strip())
            current = [line]
            in_entries = True
        elif in_entries:
            current.append(line)

    if current and in_entries:
        entries.append("".join(current).strip())

    return entries


def make_chunks(entries: list, chunk_size: int) -> list:
    return [entries[i : i + chunk_size] for i in range(0, len(entries), chunk_size)]


# ---------------------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------------------

SYSTEM_PROMPT = """\
You are a specialist in TEI XML encoding of historical theatrical texts.
Your task is to add TEI P5 markup to excerpts from Charles Pascoe's
"The Dramatic List" (1880).

Rules
-----
1. Wrap every **personal name** in <persName>. Subdivide into <forename>,
   <surname>, and <roleName> (for titles like Mr., Mrs., Miss) where the
   components are clear. On the *first* occurrence of a person give them a
   meaningful xml:id (e.g. xml:id="HenryIrving"). On *subsequent* occurrences
   within the same chunk use ref="#HenryIrving" instead.

2. Wrap every **play, opera, pantomime, burlesque, or dramatic work title**
   in <title type="play">. Use the same xml:id / ref pattern for repeated
   titles.

3. Wrap every **theatre name** in <placeName type="theatre">. Use the same
   xml:id / ref pattern.

4. Do NOT add any other TEI elements (no <p>, <div>, <head>, etc.).
   Return the text with ONLY the three tag types above inserted.

5. Preserve the original spelling, punctuation, line-breaks, and wording
   exactly -- do not correct OCR errors or paraphrase.

6. Return valid, well-formed XML fragment(s). Do not wrap the output in a
   root element or TEI header -- the caller will handle that.

7. Output only the tagged text; no explanations or commentary.
"""


def build_user_message(chunk_text: str, chunk_index: int, total_chunks: int) -> str:
    return (
        f"Chunk {chunk_index + 1} of {total_chunks}.\n\n"
        "Please add TEI tagging to the following excerpt:\n\n"
        f"{chunk_text}"
    )


# ---------------------------------------------------------------------------
# TEI wrapper
# ---------------------------------------------------------------------------

TEI_HEADER_TEMPLATE = """\
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>The Dramatic List -- chunk {chunk_num:04d} of {total_chunks:04d}</title>
        <editor><persName><forename>Charles</forename> <forename>E.</forename>
          <surname>Pascoe</surname></persName></editor>
      </titleStmt>
      <publicationStmt>
        <p>TEI encoding generated automatically. Review and correct before use.</p>
      </publicationStmt>
      <sourceDesc>
        <bibl>Charles E. Pascoe, <title>The Dramatic List</title>,
          London: The Temple Publishing Company, 1880.</bibl>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <div type="chunk" n="{chunk_num}">
"""

TEI_FOOTER = """\
      </div>
    </body>
  </text>
</TEI>
"""


def wrap_in_tei(tagged_fragment: str, chunk_num: int, total_chunks: int) -> str:
    return TEI_HEADER_TEMPLATE.format(
        chunk_num=chunk_num, total_chunks=total_chunks
    ) + tagged_fragment + "\n" + TEI_FOOTER


# ---------------------------------------------------------------------------
# API call with retry
# ---------------------------------------------------------------------------

def tag_chunk(
    client,
    chunk_entries: list,
    chunk_index: int,
    total_chunks: int,
    model: str,
    retries: int = 3,
    retry_delay: float = 10.0,
) -> str:
    chunk_text = "\n\n---\n\n".join(chunk_entries)
    user_msg = build_user_message(chunk_text, chunk_index, total_chunks)

    for attempt in range(1, retries + 1):
        try:
            response = client.messages.create(
                model=model,
                max_tokens=8192,
                system=SYSTEM_PROMPT,
                messages=[{"role": "user", "content": user_msg}],
            )
            return response.content[0].text
        except anthropic.RateLimitError as exc:
            print(f"  Rate limit (attempt {attempt}/{retries}): {exc}")
            if attempt < retries:
                time.sleep(retry_delay * attempt)
            else:
                raise
        except anthropic.APIStatusError as exc:
            print(f"  API error (attempt {attempt}/{retries}): {exc}")
            if attempt < retries:
                time.sleep(retry_delay)
            else:
                raise

    raise RuntimeError("Exceeded retry limit")


# ---------------------------------------------------------------------------
# Progress tracking
# ---------------------------------------------------------------------------

def load_progress(path: Path) -> set:
    if path.exists():
        with path.open() as f:
            return set(json.load(f).get("completed", []))
    return set()


def save_progress(path: Path, completed: set) -> None:
    with path.open("w") as f:
        json.dump({"completed": sorted(completed)}, f)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Split Pascoe's Dramatic List into TEI-tagged XML chunks."
    )
    parser.add_argument("--input",   default="PascoeDramaticLists.txt")
    parser.add_argument("--outdir",  default="tei_output")
    parser.add_argument("--chunk",   type=int, default=10)
    parser.add_argument("--model",   default="claude-sonnet-4-20250514")
    parser.add_argument("--resume",  action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    # Read source
    src = Path(args.input)
    if not src.exists():
        sys.exit(f"Error: source file not found: {src}")
    print(f"Reading {src} ...")
    text = src.read_text(encoding="utf-8", errors="replace")

    # Split
    print("Splitting into entries ...")
    entries = split_into_entries(text)
    print(f"  Found {len(entries)} entries.")
    chunks = make_chunks(entries, args.chunk)
    total_chunks = len(chunks)
    print(f"  Created {total_chunks} chunks of up to {args.chunk} entries each.")

    # Dry run: just show the plan
    if args.dry_run:
        print("\nDry-run -- no API calls.\n")
        for i, chunk in enumerate(chunks):
            labels = [e.splitlines()[0][:60].strip() for e in chunk]
            print(f"  Chunk {i+1:04d}: {len(chunk)} entries")
            for label in labels:
                print(f"    * {label}")
        return

    # Output directory + progress
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    progress_file = outdir / "_progress.json"
    completed = load_progress(progress_file) if args.resume else set()

    # API client
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        sys.exit(
            "Error: ANTHROPIC_API_KEY is not set.\n"
            "Run:  export ANTHROPIC_API_KEY=sk-ant-..."
        )
    client = anthropic.Anthropic(api_key=api_key)

    # Process chunks
    for i, chunk_entries in enumerate(chunks):
        chunk_num = i + 1
        out_file = outdir / f"chunk_{chunk_num:04d}.xml"

        if args.resume and (i in completed or out_file.exists()):
            print(f"[{chunk_num}/{total_chunks}] Skipping: {out_file.name}")
            completed.add(i)
            save_progress(progress_file, completed)
            continue

        first_line = chunk_entries[0].splitlines()[0][:60].strip()
        print(f"[{chunk_num}/{total_chunks}] Tagging: {first_line} ...", end=" ", flush=True)

        try:
            tagged = tag_chunk(client, chunk_entries, i, total_chunks, args.model)
        except Exception as exc:
            print(f"\n  ERROR on chunk {chunk_num}: {exc}")
            print("  Re-run with --resume to continue from this point.")
            save_progress(progress_file, completed)
            sys.exit(1)

        out_file.write_text(wrap_in_tei(tagged, chunk_num, total_chunks), encoding="utf-8")
        completed.add(i)
        save_progress(progress_file, completed)
        print(f"-> {out_file.name}")

        if chunk_num < total_chunks:
            time.sleep(1.0)   # gentle pause between requests

    print(f"\nDone. {len(completed)} chunk(s) written to '{outdir}/'.")
    print('Tip: merge the <div type="chunk"> elements into one TEI document when ready.')


if __name__ == "__main__":
    main()
