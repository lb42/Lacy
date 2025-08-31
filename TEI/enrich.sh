echo Enriching $1; saxon $1 Scripts/enrichHdr.xsl > Plus/$1; \
  saxon Plus/$1 Scripts/addWho.xsl > Dracor/$1
