<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
  <xsl:variable name="context" select="//t:body"/>
  <xsl:for-each select="distinct-values(//t:div[@type='volume']/t:bibl/normalize-space(t:author))">
    <xsl:sort/>
   <xsl:variable name="a" select="."/>   
   <xsl:value-of select="$a"/><xsl:text> (</xsl:text>
   <xsl:value-of select="count($context//t:div[@type='volume']/t:bibl/t:author[starts-with(normalize-space(.),$a)])"/> <xsl:text>)
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>