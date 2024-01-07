<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:variable name="pop" select="count(//t:div/t:bibl[not(@status='nf') and not(@status='replaced')])"/>
  <xsl:variable name="samp" select="count(//t:div/t:bibl[@status='TEI-0'])"/>

  <xsl:message><xsl:value-of select="concat('pop is ',$pop,' samp is ',$samp)"/></xsl:message>
 
  <xsl:for-each select="distinct-values(document('authors.xml')//person/@lacyTitles)">
   <xsl:sort/>
   <xsl:variable name="val" select="."/>
   <xsl:variable name="count" select="count(document('authors.xml')//person[@lacyTitles eq $val])"/>
   
   <xsl:variable name="percPop" select="number($count div $pop *100)"/>
   <xsl:message><xsl:value-of select="concat($val,' occurs ',$count,' times, i.e. ',$percPop,' in LAE
')"/></xsl:message>
   <xsl:variable name="count" select="count($context//t:bibl[@status='TEI-0'][starts-with(@type, $val)])"/>
   <xsl:variable name="percSamp" select="$count div $samp *100"/>
   <xsl:message><xsl:value-of select="concat($val,' occurs ',$count,' times i.e. ',$percSamp,' in TEI subset
    ')"/></xsl:message>
   
  </xsl:for-each>
 
 </xsl:template>
</xsl:stylesheet>