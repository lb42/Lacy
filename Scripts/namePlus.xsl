<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:lb ="http://lb42.github.io"
 exclude-result-prefixes="xs"
 version="3.0">

<xsl:template match="*:person">
<xsl:copy>
 <xsl:apply-templates select="@*"/>
 <xsl:attribute name="n">
  <xsl:value-of select="lb:tidy(*:persName[@type='main'])"/>
 </xsl:attribute>
 <xsl:apply-templates/>
</xsl:copy>
 </xsl:template>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 

 <xsl:function name="lb:tidy">
  <xsl:param name="str"/>  
  <xsl:variable name="tidyN" select='normalize-space(replace($str, "[\[\]]",""))'/>
  <xsl:value-of select="concat(substring-before($tidyN,', '),substring(substring-after($tidyN,', '),1,1))"/>
 </xsl:function>
</xsl:stylesheet>