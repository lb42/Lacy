<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 version="2.0">

  <!-- reports on current state of catalogue; regenerates file digitizations.xml -->
  
 <xsl:template match="/">
  <xsl:variable name="root" select="."/>
  <xsl:variable name="totLAE" select="count($root//div/bibl)"/> 
  <xsl:message>Today there are <xsl:value-of select="count($root//div/bibl)"/> items in the catalogue, of which ....</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='nf'])"/> items have not (apparently) been digitized.</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='TEI-0'])"/> items are marked as available in TEI format: 
   <xsl:value-of select="count(document('/home/lou/Public/Lacy/TEI/driver.xml')//*:include)"/> are in the TEI/driver</xsl:message>
  <xsl:for-each select="document('/home/lou/Public/Lacy/TEI/driver.xml')//*:include/@href">
   <xsl:variable name="idToCheck"><xsl:value-of select="substring-before(.,'.')"/></xsl:variable>
   <xsl:if test="count($root//*:div/*:bibl[@xml:id = $idToCheck][starts-with(@status,'TEI')]) eq 0">
    <xsl:message><xsl:value-of select="$idToCheck"/> is not marked TEI</xsl:message></xsl:if>
  </xsl:for-each> 
  
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='nopi'])"/> items are marked as lacking performance date information.</xsl:message>
  <xsl:message><xsl:value-of select="count(//div/bibl[@status='replaced'])"/> items are marked as replaced.</xsl:message> 
  <xsl:message><xsl:value-of select="count(//div/bibl[not(note[contains(@type,'extent')])])"/> items lack extent data.</xsl:message>
 
  
    <xsl:message>VPP:  <xsl:value-of select="count(//div/bibl[listRef/ref[starts-with(@target,'vpp')]])"/> links;  <xsl:value-of 
   select="count(//div/bibl[listRef/ref[contains(@target,'-vpp')]])"/> local copies.</xsl:message>

  <xsl:message>Digitizations from...</xsl:message>
  <xsl:for-each select="distinct-values(//*:ref/@target[starts-with(.,'local:')]/substring-before(substring-after(.,'-'),'.pdf'))">
   <xsl:sort/>
   <xsl:variable name="f" select="concat('-', ., '.pdf')"/>
   <xsl:message><xsl:value-of select="."/><xsl:text> </xsl:text> <xsl:value-of select="count($root//*:ref[ends-with(@target, $f)])"/></xsl:message>
  </xsl:for-each>
  
  <xsl:variable name="totVPP" select="count(//div/bibl[listRef/ref[contains(.,'VPP_PDF')]])"/>
  
  
<!-- balance criterion : length -->
  
  
  <xsl:message>Length distribution for VPP titles</xsl:message>
  
<xsl:value-of select="$totVPP"/><xsl:text>, </xsl:text>
 <xsl:message> <xsl:value-of select="count(//bibl[starts-with(@type,'1')])"/><xsl:text>, </xsl:text>
<xsl:value-of select="count(//bibl[starts-with(@type,'1') and listRef/ref[starts-with(.,'VPP')]] )"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'2')])"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'2') and listRef/ref[starts-with(.,'VPP')]] )"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'3')])"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'3') and listRef/ref[starts-with(.,'VPP')]] )"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'4')])"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'4') and listRef/ref[starts-with(.,'VPP')]] )"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'5')])"/><xsl:text>, </xsl:text>
  <xsl:value-of select="count(//bibl[starts-with(@type,'5') and listRef/ref[starts-with(.,'VPP')]] )"/><xsl:text> </xsl:text>
  </xsl:message>
  
  <xsl:result-document href="digitizations.xml">
  <xsl:for-each select="TEI/text/body/div/bibl">  
   <xsl:value-of select="@xml:id"/><xsl:text>, </xsl:text>
   <xsl:for-each select="listRef/ref">
    <xsl:value-of select="normalize-space(.)"/><xsl:text>, </xsl:text>
    <xsl:if test="starts-with(@target,'local:')">
     <xsl:value-of select="substring-before(substring-after(@target,'-'),'.pdf')"/><xsl:text>, </xsl:text></xsl:if>
   </xsl:for-each>
  <xsl:text>
</xsl:text></xsl:for-each>
  </xsl:result-document>
  
 </xsl:template>
</xsl:stylesheet>
