<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
 version="3.0">
 
<!-- adds biblScope for texts from UM volumes -->
 
 <xsl:variable name="today">
  <xsl:value-of select="format-date(current-date(),
   '[Y0001]-[M01]-[D01]')"
  />
 </xsl:variable>
 
 
 <xsl:template match="*:extent">
  <extent xmlns="http://www.tei-c.org/ns/1.0"><!--<xsl:value-of select="substring-before(.,'(UM')"/>-->
  <xsl:apply-templates select="*:measure"/>
   <measure type="spCount" quantity="{count(//*:sp)}"/>
   <measure type="spvCount" quantity="{count(//*:sp[*:l])}"/>
  </extent>
  <xsl:if test="contains(.,'(UM')">
  <biblScope unit="volume" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="substring-before(ancestor::*:bibl/@n, '.')"/></biblScope>
  <biblScope unit="pages" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="substring-before(substring-after(.,'copy:'),')')"/></biblScope></xsl:if>
 </xsl:template> 
 
 <xsl:template match="*:revisionDesc">
  <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
   <change when="{$today}">Added biblScope info for UM vols</change>
   <xsl:apply-templates/>
  </revisionDesc>
 </xsl:template>
 
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>