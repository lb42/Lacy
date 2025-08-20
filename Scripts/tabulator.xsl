<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs "
 version="3.0">
 
 <xsl:output method="text" omit-xml-declaration="yes" xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 <xsl:template match="/">
  <xsl:text>id,name,titles,refs,viaf,wikid,odnb,dnb,wikip,boase,ledger,atcl,DLB,das
</xsl:text>
  <xsl:apply-templates select="//t:person"/>
  
 </xsl:template>
 
 <xsl:template match="t:person">
  <xsl:value-of select="@xml:id"/><xsl:text>,"</xsl:text>
  <xsl:value-of select="t:persName[@type = 'main']"/><xsl:text>",</xsl:text>
 <!-- <xsl:value-of select="t:birth/@when"/><xsl:text>,</xsl:text>
-->  <xsl:value-of select="count(t:listBibl[@type='lacyTitles']/t:bibl)"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl)"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:idno[@type='VIAF'])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:idno[@type='wikidata'])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl[t:ref eq 'ODNB'])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl[t:ref eq 'DNB'])"/><xsl:text>,</xsl:text>
  
  <!--<xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'ODNB')])"/><xsl:text>,</xsl:text>
-->  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'Wikipedia')])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'Boase')])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'Ledger')])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'ATCL')])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'DLB')])"/><xsl:text>,</xsl:text>
  <xsl:value-of select="count(t:listBibl[@type='seeAlso']/t:bibl/t:ref[contains(.,'DAS')])"/><xsl:text>,</xsl:text>
  <xsl:text>
</xsl:text>
 
 </xsl:template>
 
 
</xsl:stylesheet>