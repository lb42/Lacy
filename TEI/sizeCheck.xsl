<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:apply-templates select="//body"/>
 </xsl:template>

 <!-- run against catalogue.xml to check balance for lacy, vpp, and tei  -->

 <xsl:template match="body">
  <xsl:variable name="lacyTot" select="count(//div[@type = 'work'])"/>
  <xsl:variable name="vppTot"
   select="count(//div[@type = 'work' and bibl[@type = 'originalSource']/idno[@type = 'vpp']])"/>
  <xsl:variable name="teiTot" select="count(//div[@type = 'work' and @subtype eq 'TEI'])"/>

<xsl:message>Totals :  of  <xsl:value-of select="$lacyTot"/> Lacy titles, <xsl:value-of select="$vppTot"/> are in VPP; and <xsl:value-of select="$teiTot"/> in TEI</xsl:message>

<xsl:variable name="count" select="count(//div[@type='work' and starts-with(@ana,'S')])"/>
 <xsl:variable name="tCount" select="count(//div[@type='work' and starts-with(@ana,'S') and @subtype='TEI'] )"/>

 <xsl:message>Of <xsl:value-of select="$count"/> short plays ( <xsl:value-of select="round(($count div $lacyTot) * 100)"/>% )  <xsl:value-of select="$tCount"/> are in TEI ( <xsl:value-of select="round(($tCount div $teiTot) * 100)"/>% )
 </xsl:message>
  
  
 <xsl:variable name="smallCount" select="count(//div[@type='work' and starts-with(@ana,'M')])"/>
 <xsl:variable name="smallCountT" select="count(//div[@type='work' and starts-with(@ana,'M') and @subtype='TEI'] )"/>
 
 <xsl:message>Of <xsl:value-of select="$smallCount"/> medium plays ( <xsl:value-of select="round(($smallCount div $lacyTot) * 100)"/>% )  <xsl:value-of select="$smallCountT"/> are in TEI ( <xsl:value-of select="round(($smallCountT div $teiTot) * 100)"/>% )
 </xsl:message>
 
 <xsl:variable name="count" select="count(//div[@type='work' and starts-with(@ana,'L')])"/>
 <xsl:variable name="tCount" select="count(//div[@type='work' and starts-with(@ana,'L') and @subtype='TEI'] )"/>
 
 <xsl:message>Of <xsl:value-of select="$count"/> long plays ( <xsl:value-of select="round(($count div $lacyTot) * 100)"/>% )  <xsl:value-of select="$tCount"/> are in TEI ( <xsl:value-of select="round(($tCount div $teiTot) * 100)"/>% )
 </xsl:message>
 
 </xsl:template>
</xsl:stylesheet>
