<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">

 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

<xsl:template match="date[not(@when)]">
<xsl:variable name="yr"> 
 <xsl:analyze-string select="." regex='(1[78]\d\d)'>
  <xsl:matching-substring>
   <xsl:value-of select="regex-group(1)"/>
  </xsl:matching-substring>
<!--<xsl:non-matching-substring>"99"</xsl:non-matching-substring>-->
 </xsl:analyze-string></xsl:variable>
 <date when="{$yr}"><xsl:value-of select="normalize-space(.)"/></date>
 <xsl:message><xsl:value-of select="normalize-space(.)"/> -> <xsl:value-of select="$yr"/></xsl:message>
</xsl:template>
</xsl:stylesheet>
