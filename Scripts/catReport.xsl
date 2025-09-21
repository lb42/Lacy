<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="http://expath.org/ns/file"
exclude-result-prefixes="xs"
xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

<!-- reports on current state of catalogue; regenerates file digitizations.txt -->
<!-- this must be run from within Oxygen, because it uses the xpath "exists" function which is not available from saxon HE -->



<xsl:template match="/">
<xsl:variable name="dataDir">/home/lou/Data/Lacy/</xsl:variable>
<xsl:variable name="root" select="."/>

<xsl:variable name="totLAE" select="count($root//div[@type = 'work'])"/>
<xsl:variable name="totTEI"
select="count($root//div/bibl[contains(@subtype, 'TEI')])"/>
<xsl:message>Data directory is <xsl:value-of select="$dataDir"/>
</xsl:message>
<xsl:message>Today there are <xsl:value-of select="$totLAE"/> items in the
catalogue, of which ....</xsl:message>
<xsl:message>
<xsl:value-of select="count(//div[@type = 'work' and contains(@subtype, 'nf')])"
/> items have not (apparently) been digitized.</xsl:message>
<xsl:message><xsl:value-of
select="count(//div[@type = 'work']/bibl[@subtype eq 'TEI'])"/> items are marked
as available in TEI format: <xsl:value-of
select="count(document('/home/lou/Public/Lacy/TEI/driver.tei')//TEI/TEI)"/> are
included by driver.tei</xsl:message>
<xsl:for-each
select="document('/home/lou/Public/Lacy/TEI/driver.tei')//TEI/@xml:id">
<xsl:variable name="myId" select="."/>

<xsl:if
test="count($root//div[@type = 'work' and @xml:id eq $myId and contains(@subtype, 'TEI')]) eq 0">
<xsl:message>Update <xsl:value-of select="."/>!</xsl:message>
</xsl:if>
</xsl:for-each>


<xsl:message><xsl:value-of
select="count(//div[@type = 'work']/listEvent/event[@type = 'firstPerf'])"/>
first perf notes</xsl:message>
<xsl:message><xsl:value-of
select="count(//div[@type = 'work' and ends-with(@xml:id, 'R')])"/> items are
marked as replacements.</xsl:message>
<xsl:message>
<xsl:value-of
select="count(//bibl[@type = 'printSource' and not(idno[@type = 'nic'])])"/> are
not listed by Nicoll </xsl:message>

<xsl:message><xsl:value-of
select="count(//bibl[@type = 'printSource' and not(extent)])"/> items lack
extent data.</xsl:message>


<xsl:message>VPP: <xsl:value-of
select="count(//bibl[@type = 'printSource' and idno[@type = 'vpp']])"/> idnos;
<xsl:value-of select="count(//ref[contains(@target, '-vpp') 
and starts-with(@target,'https')])"/> vpp source pdfs from tiffs online ; 
<xsl:value-of select="count(//ref[contains(@target, '-vpp') 
and starts-with(@target,'local')])"/> local copies  ; 

<xsl:value-of
select="count(//div[@type='work'] 
[ bibl/ref[contains(@target, '-vpp')] and bibl[@subtype eq 'TEI'] ])"
/> in TEI</xsl:message>

<xsl:message>UM: <xsl:value-of select="count(//ref[contains(@target, '-um.')])"
/> UM sourced </xsl:message>

<xsl:variable name="totVPP"
select="count(//bibl[@type = 'printSource' and idno[@type = 'vpp']])"/>
<xsl:variable name="totLarge" select="count(//div[starts-with(@ana, 'L')])"/>
<xsl:variable name="totMed" select="count(//div[starts-with(@ana, 'M')])"/>
<xsl:variable name="totSmall" select="count(//div[starts-with(@ana, 'S')])"/>


<!-- balance criterion : size -->

<xsl:message>Size distribution... pop, total, Large, Medium, Small all,
<xsl:value-of select="$totLAE"/><xsl:text>, </xsl:text>
<xsl:value-of select="$totLarge"/><xsl:text>, </xsl:text>
<xsl:value-of select="$totMed"/><xsl:text>, </xsl:text>
<xsl:value-of select="$totSmall"/><xsl:text>
  vpp, </xsl:text>
<xsl:value-of select="$totVPP"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'L') and bibl/idno[@type = 'vpp']])"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'M') and bibl/idno[@type = 'vpp']])"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'S') and bibl/idno[@type = 'vpp']])"/><xsl:text>
  tei,</xsl:text>
<xsl:value-of select="$totTEI"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'L') and contains(@subtype ,'TEI')])"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'M') and contains(@subtype , 'TEI')])"/><xsl:text>, </xsl:text>
<xsl:value-of
select="count(//div[starts-with(@ana, 'S') and contains(@subtype , 'TEI')])"/>
</xsl:message>

<xsl:result-document href="digitizations.txt">
<xsl:for-each select="TEI/text/body/div/bibl">
<xsl:variable name="theId" select="@xml:id"/>

<!-- -->
<!-- links to lb42.github.io or to ECCO are not counted -->
<xsl:if test="
count(listRef/ref[not(contains(., 'ECCO')) and not(contains(@target, 'gutenberg'))
and not(contains(., 'copy'))])
lt count(note[@type = 'localCopies']/ident[matches(., 'L\d\d\d\dR?\-') and not(contains(., 'vpp'))])">
<xsl:message>Refcount lt identcount <xsl:value-of select="$theId"
/></xsl:message>

</xsl:if>

<xsl:for-each select="listRef/ref">
<xsl:value-of select="$theId"/>
<xsl:text> </xsl:text>
<xsl:value-of select="normalize-space(@target)"/>
<xsl:text> 
</xsl:text>
</xsl:for-each>

<xsl:for-each select="note[@type = 'localCopies']/ident">
<xsl:value-of select="$theId"/>
<xsl:text> </xsl:text>
<xsl:value-of select="."/>
<xsl:text> 
</xsl:text>

<xsl:variable name="file" select="concat($dataDir, .)"/>
<xsl:if test="not(f:exists($file))">
<xsl:message>File <xsl:value-of select="$file"/> not found</xsl:message>
</xsl:if>


</xsl:for-each>
<xsl:text>
</xsl:text>
</xsl:for-each>
</xsl:result-document>

</xsl:template>
</xsl:stylesheet>
