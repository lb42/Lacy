for f in L*.xml; do saxon $f Scripts/enrichHdr.xsl > Plus/$f; jing /home/lou/Public/Lacy/TEI/ODD/out/lacy.rng Plus/$f; done
