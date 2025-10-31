# run this script in Lacy/Scripts folder
# to produce new list of pages
ls -1 /home/lou/Data/Lacy/Vol*/L*/* | perl listPages.pl > listPages.xml
# then check that list against pb occurrences in TEI
saxon -xi ../driver.tei checkPages.xsl
