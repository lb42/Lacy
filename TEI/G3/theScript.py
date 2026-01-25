import time
import re
from google import genai
from google.genai import types

# 1. Setup
MY_KEY = "AIzaSyBzJhGcHTMbr3ny2j83qg0ToyuRwZXo0BA"
client = genai.Client(api_key=MY_KEY)

def discover_metadata(text_sample):
    """Retrieves Title and Author/Adapter directly from the manuscript text."""
    prompt = "Analyze this title page. Return ONLY: Title | Author. Example: A Christmas Carol | C. Z. Barnett"
    response = client.models.generate_content(
        model='gemini-2.5-flash',
        contents=f"{prompt}\n\n{text_sample[:2000]}"
    )
    parts = response.text.strip().split('|')
    title = parts[0].strip() if len(parts) > 0 else "Unknown Title"
    author = parts[1].strip() if len(parts) > 1 else "Unknown Author"
    return title, author

def encode_front_matter(text_chunk):
    """Encodes preamble: titlePage, castList (with <actor>), and <set>."""
    system_instruction = (
        "You are a TEI P5 expert. Convert this preamble into a <front> element.\n"
        "1. Wrap title/author in <titlePage>.\n"
        "2. For 'Dramatis Personae', use <castList>.\n"
        "3. Each entry must be a <castItem> containing <role>, <roleDesc>, and <actor>.\n"
        "4. Use <set> for time/place descriptions.\n"
        "5. Output ONLY the XML <front> fragment."
    )
    response = client.models.generate_content(
        model='gemini-2.5-flash',
        contents=text_chunk,
        config=types.GenerateContentConfig(system_instruction=system_instruction, temperature=0.1)
    )
    return response.text.strip().replace('```xml', '').replace('```', ''), response.usage_metadata

def encode_act(chunk_text):
    """Encodes an individual Act into a <div>."""
    system_instruction = (
        "You are a TEI P5 expert. Convert this Act into a <div type='act'>.\n"
        "1. Use <sp>, <speaker>, <p>, <stage>, and <div type='scene'>.\n"
        "2. Convert ALL CAPS names in stage directions to Title Case.\n"
        "3. Keep speaker labels literal.\n"
        "4. Output ONLY the XML <div> fragment."
    )
    response = client.models.generate_content(
        model='gemini-2.5-flash',
        contents=chunk_text,
        config=types.GenerateContentConfig(system_instruction=system_instruction, temperature=0.1)
    )
    return response.text.strip().replace('```xml', '').replace('```', ''), response.usage_metadata

def main():
    with open("L0326.txt", "r", encoding="utf-8") as f:
        full_text = f.read()

    # Split logic (Case-sensitive ACT)
    split_pattern = r'(?=ACT\s+(?:THE\s+)?(?:FIRST|SECOND|THIRD|FOURTH|FIFTH|[IVXLCDM]+))'
    parts = re.split(split_pattern, full_text)
    front_text = parts[0].strip()
    acts_text = parts[1:]

    # Step 1: Discover Metadata for the Header
    print("Discovering manuscript metadata...")
    title, author = discover_metadata(full_text)
    
    # Step 2: Build the XML Skeleton using discovered data
    header = f"""<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="L0326">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>{title}</title>
        <author>{author}</author>
      </titleStmt>
      <publicationStmt><p>Digital transcription via Gemini 2.5</p></publicationStmt>
      <sourceDesc><p>Manuscript L1410</p></sourceDesc>
    </fileDesc>
  </teiHeader>
    
  <text>
"""
    final_xml = [header]
    total_in = 0
    total_out = 0

    # Step 3: Encode Front Matter
    if front_text:
        print(f"Encoding Front Matter for '{title}'...")
        xml, usage = encode_front_matter(front_text)
        final_xml.append(xml)
        total_in += usage.prompt_token_count
        total_out += usage.candidates_token_count

    final_xml.append("\n    <body>\n")

    # Step 4: Encode Acts
    for i, act_text in enumerate(acts_text):
        print(f"Encoding Act {i+1} of {len(acts_text)}...")
        xml, usage = encode_act(act_text)
        final_xml.append(xml)
        total_in += usage.prompt_token_count
        total_out += usage.candidates_token_count
        time.sleep(1)

    final_xml.append("\n    </body>\n  </text>\n</TEI>")

    # Write and Report
    with open("L0326-final.xml", "w", encoding="utf-8") as f:
        f.writelines(final_xml)

    cost = (total_in/1_000_000 * 0.075) + (total_out/1_000_000 * 0.30)
    print(f"\nDone. Processed {len(acts_text)} acts.")
    print(f"Estimated Cost: ${cost:.4f}")

if __name__ == "__main__":
    main()
