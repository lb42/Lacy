#import git
import glob
import subprocess
import os
import sys

def gitPull(repoDir):
    cmd = ['git', 'pull']
    p = subprocess.Popen(cmd, cwd=repoDir)
    p.wait()

repoName='/home/lou/Public/Lacy/TEI/'
webRepoName='/home/lou/Public/lb42.github.io/Lacy/'
folderRoot='https://raw.githubusercontent.com/lb42/Lacy/main/TEI/'
reporter='/home/lou/Public/Lacy/Scripts/reporter.xsl'
#exposer='/home/lou/Public/ELTeC/Scripts/expose.xsl'
reportBalance='/home/lou/Public/ELTeC/Scripts/mosaic.R'
outputFile='index.html'
string1='''<!DOCTYPE html>
<html><head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
  <link rel="stylesheet" href="css/lacy.css" media="all" />
  <script src="js/CETEI.js"></script>
  <script>
   let c = new CETEI(); 
   let behaviors = {
    "namespaces": {
     "el": "http://distantreading.net/eltec/ns"
    },
    "tei": {
     "teiHeader": null,
     "distributor":[[ "[ref]",[ "<a href='$rw@ref' target='_blank'>", "</a>"]]],
     "author":[[ "[ref]",[ "<a href='$rw@ref' target='_blank'>", "</a>"]]],
     "pb":[ "<p class='break'>[page $@n]</p>"],
     "ref": ["<a href='$rw@target'> ↠ </a>"],
    },
  };
  c.addBehaviors(behaviors);
  c.getHTML5("'''

string2='''",function(data) {
  document.getElementsByTagName("body")[0].appendChild(data);});
  </script>
     <title>Lacy's Acting Edition : '''
     
string3=''' </title>
     </head>
    <body>
        <a href="https://lb42.github.io/Lacy/">
            <img src="media/lacyIcon.png" alt="Digital Lacy"/>
        </a>
    </body>
</html>'''

from datetime import date
today = str(date.today())

print("Refreshing repos "+repoName+" and "+webRepoName)
gitPull(repoName)
gitPull(webRepoName)
os.chdir(repoName)
f=open("driver.tei","w")
f2=open("fileNames.xml","w")
FILES=sorted(glob.glob('L*.xml'))
print(str(len(FILES))+' files found in repo')
print("Rewriting driver files")
f.write('<TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude" xml:id="LAE"><teiHeader><fileDesc> <titleStmt> <title>Lacy\'s Acting Edition - TEI version</title></titleStmt>\n<extent><measure unit="files">'+str(len(FILES))+'</measure></extent> <publicationStmt><p>Unpublished test file</p></publicationStmt><sourceDesc><p>Automatically generated source driver file</p> </sourceDesc> </fileDesc>  <xi:include href="encodingDesc.xml"/> <revisionDesc><change when="'+today+'">refreshRepo script run</change></revisionDesc></teiHeader>')
   
f2.write('<fileNames>')
for FILE in FILES:
   f.write("<xi:include href='"+FILE+"'/>")
   f2.write("<file>"+FILE+"</file>")
f.write("</TEI>")
f2.write("</fileNames>")
f.close()
f2.close()
print("Exposing repo "+repoName)
for FILE in FILES: 
   bName=os.path.splitext(FILE)[0] 
   webFileName=webRepoName+"/"+bName+".html"
   gitURL=folderRoot+FILE
   webFile=open(webFileName,'w')
   webFile.write(string1+gitURL+string2+bName+string3)
   webFile.close
print("Reporting on repo "+repoName)
command="saxon -xi -s:" + repoName + "driver.tei -xsl:" + reporter + ' >'+webRepoName+outputFile
#print(command)
subprocess.check_output(command,shell=True)

#command="Rscript "+reportBalance+" --args "+webRoot+LANG
#subprocess.check_output(command,shell=True)
# could run summarize.py here
