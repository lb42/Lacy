
# Workflow (sept 2025)
1. First make a basic TEI file. Gemini3 may help here.
1. (If starting from a VPP file, 
    - `cd ~/pCloudDrive/Lacywork/Abbyy`
    - `sh Scripts/convert.sh Lxxxx.xml)`
1.  Check well-formedness, and validity with Lacy schema.
2. Now make a Partix file for it, by running the `makePartix` transformation scenario (This will throw up lots of errors which you can fix in oXygen)
3. Edit the partix file. Square brackets are used for speaking roles not listed in the castList.
4. Within the Public/Lacy/TEI directory,  run `sh enrich.sh Lxxxx.xml` to create two new versions, one in Plus, one in Dracor. 
5. Validate the one in Dracor using the Dracor schema (There will probably be a pile of schematron complaints about invalid @who="#" to fix)
6. When valid, you can move it from Dracor (overwriting the one used at step 4). Then update the driver.tei, either manually or by running `python3 refreshRepo.py` (caution: this will overwrite  local copies of existing files in lb42.github.io; you should check them before pushing the new versions)

## active scripts
   
- addWho.xsl  : add @who value if there is none
- changeWho.xsl : same, but over-rides any existing value
- doCounts.sh : produces `counts.csv` containing counts determined by selection in `getMeta.xsl`
- enrichHdr : copies metadata  into teiHeader from catalogue.xml and Partix/Lxxxx.xml
- getMeta.xsl : used by doCounts.sh qv
- makePartix.xsl : creates draft (invalid) particDesc in Partix/Lxxx.xml by processing `<castList>`; must be hand edited before running enrichHdr
- refreshRepo : creates `report.html`  `fileNames.xml`, and `driver.tei` by checking contents of TEI directory; runs script `reporter.xsl` (from Lacy/Scripts)




