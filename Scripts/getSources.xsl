<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">
<xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 <xsl:template match="/">
 
  <listBibl><xsl:for-each select="//*:bibl[@type='origin'  and *:title[@type eq 'source']]">
   <bibl type='source'>
   <xsl:attribute name="n"> <xsl:value-of select="@n"/></xsl:attribute>
    <xsl:attribute name="xml:id">
   <xsl:value-of select="ancestor::*:div[@type='work']/@xml:id"/></xsl:attribute>
   <title><xsl:value-of select="normalize-space(*:title[@type='main'])"/></title>
   <title type='source'><xsl:value-of select="normalize-space(*:title[@type='source'])"/></title>
    <xsl:if test="*:relatedItem"><xsl:copy-of select="*:relatedItem"/></xsl:if> 
   </bibl>
  </xsl:for-each></listBibl></xsl:template>
</xsl:stylesheet>