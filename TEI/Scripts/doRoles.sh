# run this within TEI folder
# sh Scripts/doRoles.sh

echo "id,title,pp,txWords,spCount,roles,rolesM,rolesF,genre,class" > roles.csv
for f in L*.xml; do echo $f; saxon $f Scripts/getMeta.xsl >> roles.csv; done
