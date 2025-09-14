## active scripts

addWho.xsl  : add @who value if there is none
changeWho.xsl : same, but over-rides any existing value

doCounts.sh : produces counts.csv containing counts determined by selection in getMeta.xsl

enrichHdr : copies metadata  into teiHeader from catalogue.xml and Partix/Lxxxx.xml

getMeta.xsl : used by doCounts.sh qv

makePartix.xsl : creates draft (invalid) particDesc in Partix/Lxxx.xml by processing <castList>; must be hand edited before running enrichHdr

refreshRepo : creates report.html  fileNames.xml, and driver.tei by checking contents of TEI directory; runs script reporter.xsl (from Lacy/Scripts)



