<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs h"
 xmlns:h="http://www.w3.org/1999/xhtml" 
 xmlns="http://www.tei-c.org/ns/1.0" version="2.0">

 <!-- script to juggle components of catalogue -->
 

 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text()">
  <xsl:value-of select="normalize-space(.)"/>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="*:bibl">
  
  <entry xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates select="*:author"/>
   <xsl:apply-templates select="*:title"/>
   <xsl:apply-templates select="*:extent"/>
   <xsl:apply-templates select="*:note[contains(@type,'erf')]"/>
   <xsl:apply-templates select="*:listRef[not(@type)]"/>
   <xsl:apply-templates select="*:note[@type='authorInfo']"/>  
   <xsl:apply-templates select="*:note[not(@type)]"/>
   
  </entry><xsl:text>
  </xsl:text>
 </xsl:template>
 
 <xsl:template match="*:ref">
  <ref xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="target">
   <xsl:variable name="str" select="substring-after(@target,':')"/>
   <xsl:choose>
    <xsl:when test="starts-with(.,'http')"><xsl:value-of select="."/></xsl:when>
    <xsl:when test="starts-with(@target,'vpp:')">
     <xsl:value-of select="concat('http://victorian.nuigalway.ie/modx/assets/docs/pdf/',$str)"/>
    </xsl:when>
    <xsl:when test="starts-with(@target,'gut:')">
     <xsl:value-of select="concat('https://www.gutenberg.org/files/',$str,'/',$str,'-h','/',$str,'-h.htm')"/>
    </xsl:when>
    <xsl:when test="starts-with(@target,'ia:')">   
     <xsl:value-of select="concat('https://archive.org/details/',$str)"/> </xsl:when>
    <xsl:when test="starts-with(@target,'gb:')">   
     <xsl:value-of select="concat('https://www.google.com/books/edition/',$str)"/> </xsl:when>
<xsl:otherwise>
 <xsl:value-of select="@target"/>
</xsl:otherwise>    
   </xsl:choose>
  </xsl:attribute>
  <xsl:value-of select="."/></ref>
 </xsl:template> 
 
 
</xsl:stylesheet>
