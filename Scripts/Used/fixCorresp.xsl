<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs h"
 xmlns:h="http://www.w3.org/1999/xhtml" 
 xmlns="http://www.tei-c.org/ns/1.0" version="2.0">

 <!-- add vpp identifier to bibl/@corresp in catalogue-->
 

 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
 
 <!--<xsl:template match="text()">
  <xsl:value-of select="normalize-space(.)"/>
 </xsl:template>
-->
<!-- <xsl:template match="/">
  <xsl:apply-templates />
 </xsl:template>-->
 <xsl:template match="*:bibl">
  <xsl:text>
  </xsl:text>
 <xsl:copy> <xsl:apply-templates select="@*"/><xsl:apply-templates/></xsl:copy>
 </xsl:template>
 

 <xsl:template match="*:bibl/@corresp">
   <xsl:variable name="vppId" select="substring-before(substring-after(ancestor::*:bibl/*:note/*:ident[contains(.,'/Vol')],'/Vol'),'.pdf')"/>
 <!--  <xsl:message><xsl:value-of select="ancestor::*:bibl/*:note/*:ident[contains(.,'/Vol')]"/></xsl:message>  
-->   
   <xsl:attribute name="corresp">
   <xsl:choose>
    <xsl:when test="string-length($vppId) gt 1"><xsl:value-of select="concat(., ' vpp:Vol', $vppId)"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
   </xsl:choose> 
  </xsl:attribute>
  </xsl:template>
 
 
 
</xsl:stylesheet>
