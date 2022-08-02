# Lacy
Exploring Thomas Hailes Lacy's acting edition of Victorian Plays (1848-1873)

The catalogue of Lacy's Acting editions originally prepared as part of
the Victorian Plays Project at Worcester, is still online and easily
scrapable. The online version takes the form of nearly 100 HTML tables, each corresponding with a single volume. I ran a simple minded script to do the following :

 - grabs the web page for each volume summary, available as an URL in the form "http://victorian.nuigalway.ie/modx/index.php?id=$i" where $i runs from 76 to 173
 - runs a perl script `munge.prl` to do some minimal tidying of the HTML, chiefly to replace entity references with Unicode characters
 - runs the XSLT  script `makeCat.xsl`  to turn the table/td/tr  tagging into something more meaningful. Thus the part of page 72 which reads (in HTML) like this:
~~~~
<tr><td>1 Sept. 1852</td>
<td><strong>Phillips, Mrs. Alfred</strong></td>
<td><strong><a href="assets/docs/pdf/Vol07xvMaster.pdf">The Master Passion</a></strong></td>
<td>A Comedy in 2 Acts</td>
<td>Royal Olympic Theatre</td>
</tr>
~~~~
becomes
~~~~
<!-- 72 -->
<bibl n="7.15">
<date when="1852">1 Sept. 1852</date><author>Phillips, Mrs. Alfred</author>
<title>The Master Passion</title>
<ref target="vpp:Vol07xvMaster.pdf">PDF</ref>
<title type="sub">A Comedy in 2 Acts</title>
<note type="firstPerf">Royal Olympic Theatre</note></bibl>
~~~~
ready for further enrichment and correction. I plan to add links to other online editions as I find them. 

Scripts processing this catalogue include

 - `countAuthors.xsl` : lists authors with frequency counts
 - `countVenues.xsl` : lists venues cited for first performance with frequency counts
 
