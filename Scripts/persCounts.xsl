<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 version="3.0">
 
 
 <xsl:output method="text"/>
 
 
 <xsl:template match="/">
  <xsl:text>Person,Name,Titles,TEI-Titles,VIAF,Wikidata,ODNB,DNB,Wikipedia
  </xsl:text>
  <xsl:apply-templates select="//*:person"/>
 </xsl:template>
 
 <xsl:template match="*:person">
  <xsl:value-of select="@xml:id"/><xsl:text>, "</xsl:text>
  <xsl:value-of select="*:persName[@type='main']"/><xsl:text>", </xsl:text>
  <xsl:value-of select="count(listBibl[@type='lacyTitles']/bibl)"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='lacyTitles']/bibl[ref])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='seeAlso']/bibl/idno[@type='VIAF'])"/> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='seeAlso']/bibl/idno[@type='wikidata'])"/> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='seeAlso']/bibl/ref[contains(@target,'odnb')])"/> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='seeAlso']/bibl/ref[contains(@target,'National')])"/> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(listBibl[@type='seeAlso']/bibl/ref[contains(@target,'wikip')])"/> <xsl:text>
 </xsl:text>
 </xsl:template>
</xsl:stylesheet>