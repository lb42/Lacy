<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs t"
 version="2.0">

<xsl:param name="textId"/>

  <!-- generate listPerson for all named roles in TEI plays -->

  <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <particDesc  xmlns="http://www.tei-c.org/ns/1.0">
   <listPerson>

<!--<xsl:for-each select="distinct-values(//t:castList//t:role)">-->

<xsl:for-each select="//t:castList//t:role">
<xsl:if test="not(@gender)">
<xsl:message><xsl:value-of select="."/> : please assign a gender to this role and try again</xsl:message></xsl:if>
<xsl:variable name="pid"><xsl:value-of select="concat(substring-before($textId, '.xml'), '_', @gender, position())"/> </xsl:variable>
<!--<person xml:id="{replace(lower-case(.),'[\-\[,.\s]','')}">
-->

<person xml:id="{$pid}">
<persName type="role"><xsl:value-of select="."/></persName>
<xsl:text>
</xsl:text>
</person>
<xsl:text>
</xsl:text></xsl:for-each>

<xsl:for-each select="distinct-values($context//t:speaker)">
<xsl:variable name="pfx" select="."/>
<persName type="spkr" n="{count($context//*:speaker[starts-with(.,$pfx)])}">
<xsl:value-of select="$pfx"/>
</persName>
     <xsl:text>
</xsl:text></xsl:for-each>
    
   </listPerson></particDesc>
</xsl:template></xsl:stylesheet>
