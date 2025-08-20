# this uses new version of catalogue
for f in L*.xml; do echo $f; saxon $f ../Scripts/enrichHdrNew.xsl > Dracor/$f; done
