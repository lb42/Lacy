<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <!-- sort by lic date -->
 <xsl:template match="/">
  <doc>
  <xsl:for-each select="*:doc/*:entry">
   <xsl:sort select="*:lic[1]/@when"/>
   <xsl:copy><xsl:apply-templates select="@*"/> <xsl:apply-templates/></xsl:copy>
  </xsl:for-each>
  </doc>
 </xsl:template>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>