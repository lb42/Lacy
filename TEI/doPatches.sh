# apply patches.xsl to all files, output in Plus
for f in L*.xml; do echo $f; saxon $f Scripts/patches.xsl > Plus/$f; \
done
