<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:for-each select="distinct-values(//t:bibl/t:note[@type='firstPerf'])">
    <xsl:sort/>
   <xsl:variable name="a" select="."/>   
   <xsl:value-of select="normalize-space(.)"/><xsl:text> (</xsl:text>
   <xsl:value-of select="count($context//t:note[starts-with(.,$a)])"/> <xsl:text>)
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
