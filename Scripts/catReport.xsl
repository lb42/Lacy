<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 version="2.0">

  <!-- reports on current state of catalogue; regenerates file digitizations.txt -->
  
 <xsl:template match="/">
  <xsl:variable name="root" select="."/>
  <xsl:variable name="totLAE" select="count($root//div/bibl)"/> 
   <xsl:variable name="totTEI" select="count($root//div/bibl[contains(@status,'TEI')])"/> 
  <xsl:message>Today there are <xsl:value-of select="count($root//div/bibl)"/> items in the catalogue, of which ....</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='nf'])"/> items have not (apparently) been digitized.</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[starts-with(@status,'TEI')])"/> items are marked as available in TEI format: 
   <xsl:value-of select="count(document('/home/lou/Public/Lacy/TEI/driver.xml')//*:include)"/> are in the TEI/driver</xsl:message>
  <xsl:for-each select="document('/home/lou/Public/Lacy/TEI/driver.tei')//*:include/@href">
   <xsl:variable name="idToCheck"><xsl:value-of select="substring-before(.,'.')"/></xsl:variable>
   <xsl:if test="count($root//*:div/*:bibl[@xml:id = $idToCheck][starts-with(@status,'TEI')]) eq 0">
    <xsl:message><xsl:value-of select="$idToCheck"/> is not marked TEI</xsl:message></xsl:if>
  </xsl:for-each> 
  
  <xsl:message><xsl:value-of select="count(//div/bibl[contains(@status,'nopi')])"/> items are marked as lacking performance date information.</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='replaced'])"/> items are marked as replaced.
    <xsl:value-of select="count(//div/bibl[not(idno[@type='nic']) ])"/> are not listed by Nicoll
  </xsl:message> 
 
   
   <xsl:message><xsl:value-of select="count(//div/bibl[not(//extent)])"/> items lack extent data.</xsl:message>
 
  
    <xsl:message>VPP:  <xsl:value-of select="count(//div/bibl/idno[@type='vpp'])"/> idnos;  <xsl:value-of 
      select="count(//div/bibl//ident[contains(.,'-vpp')])"/> local copies; <xsl:value-of 
        select="count(//div/bibl[note/ident[contains(.,'-vpp')] and contains(@status,'TEI')])"/> in TEI</xsl:message>

  <!--<xsl:message>Digitizations from...</xsl:message>
  <xsl:for-each select="distinct-values(//note[@type='localCopies']/ident/substring-before(substring-after(.,'-'),'.pdf'))">
   <xsl:sort/>
   <xsl:variable name="f" select="concat('-', ., '.pdf')"/>
   <xsl:message><xsl:value-of select="."/><xsl:text> </xsl:text> 
    <xsl:value-of select="count($root//*:ident[ends-with(. , $f)])"/></xsl:message>
  </xsl:for-each>
    -->
  <xsl:variable name="totVPP" select="count(//div/bibl[idno[@type='vpp']])"/>
  <xsl:variable name="totLarge" select="count(//div/bibl[starts-with(@type,'L')])"/>
  <xsl:variable name="totMed" select="count(//div/bibl[starts-with(@type,'M')])"/>
  <xsl:variable name="totSmall" select="count(//div/bibl[starts-with(@type,'S')])"/>

  
<!-- balance criterion : size -->
  
  <xsl:message>Size distribution...
  pop, total, Large, Medium, Small
  all, <xsl:value-of select="$totLAE"/><xsl:text>, </xsl:text>
  <xsl:value-of select="$totLarge"/><xsl:text>, </xsl:text>
  <xsl:value-of select="$totMed"/><xsl:text>, </xsl:text>
  <xsl:value-of select="$totSmall"/><xsl:text>
  vpp, </xsl:text>
<xsl:value-of select="$totVPP"/><xsl:text>, </xsl:text>
<xsl:value-of select="count(//bibl[starts-with(@type,'L') and idno[@type='vpp'] ])"/><xsl:text>, </xsl:text>
   <xsl:value-of select="count(//bibl[starts-with(@type,'M') and idno[@type='vpp']] )"/><xsl:text>, </xsl:text>
   <xsl:value-of select="count(//bibl[starts-with(@type,'S') and idno[@type='vpp']] )"/><xsl:text>
  tei,</xsl:text>
    <xsl:value-of select="$totTEI"/><xsl:text>, </xsl:text>
    <xsl:value-of select="count(//bibl[starts-with(@type,'L') and contains(@status,'TEI') ])"/><xsl:text>, </xsl:text>
    <xsl:value-of select="count(//bibl[starts-with(@type,'M') and contains(@status,'TEI') ])"/><xsl:text>, </xsl:text>
    <xsl:value-of select="count(//bibl[starts-with(@type,'S') and contains(@status,'TEI') ])"/>
  
  
  </xsl:message>
  
  <xsl:result-document href="digitizations.txt">
  <xsl:for-each select="TEI/text/body/div/bibl">  
   <xsl:value-of select="@xml:id"/><xsl:text>, </xsl:text>
   <xsl:for-each select="listRef/ref">
    <xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
    </xsl:for-each>
  <xsl:text>,</xsl:text>
    <xsl:for-each select="note[@type='localCopies']/ident">
      <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:for-each>
    <xsl:text>
</xsl:text></xsl:for-each>
  </xsl:result-document>
  
 </xsl:template>
</xsl:stylesheet>
