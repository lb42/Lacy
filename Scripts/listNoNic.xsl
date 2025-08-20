<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:for-each select="//t:bibl[not(@corresp)]">
   <xsl:sort select="t:title[1]"/>
   <xsl:value-of select="normalize-space(concat(t:title[1], ' ', t:title[@type='sub']))"/>
   <xsl:value-of select="normalize-space(concat(' (', t:author[1], ', ', t:note[@type='firstPerf'], ') : ', @xml:id))"/><xsl:text>
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>