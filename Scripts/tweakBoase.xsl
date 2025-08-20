<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
 version="3.0">
 
<!-- adds biblScope for texts from UM volumes -->
 
 
 <xsl:template match="*:body">
  <body xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:for-each select="*:div">
   <xsl:sort select="*:head"/>
 <xsl:copy> <xsl:attribute name="xml:id"><xsl:value-of select="concat('Bo',position())"/></xsl:attribute>
  <xsl:apply-templates select="@*"/> 
  <xsl:apply-templates/>
</xsl:copy>  </xsl:for-each>
   </body>
 </xsl:template> 
 
 
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>