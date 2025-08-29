# this uses new version of catalogue
for f in L*.xml; do echo $f; saxon $f Scripts/enrichHdr.xsl > Plus/$f; \
  saxon Plus/$f Scripts/addWho.xsl > Dracor/$f; done
