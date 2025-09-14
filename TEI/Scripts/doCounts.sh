# run this within TEI folder
# sh Scripts/doCounts.sh
#   produces counts.csv file with selected metadata counts
#   one row per title indicated
#   fields selected by getMeta.xsl script

echo "id,title,pp,txWords,spCount,spFcount,spMcount,roles,rolesM,rolesF,genre,class" > counts.csv
for f in L*.xml; do echo $f; saxon $f Scripts/getMeta.xsl >> counts.csv; done
