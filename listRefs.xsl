<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
<xsl:for-each select="//t:bibl[count(t:ref) gt 0]">
 
 <xsl:value-of select="@n"/>
 <xsl:for-each select="t:ref/@target"><xsl:text>: </xsl:text>
 <xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
