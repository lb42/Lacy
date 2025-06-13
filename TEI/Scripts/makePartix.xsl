<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs t"
 version="2.0">

  <!-- generate listPerson for all named roles in TEI plays -->

  <xsl:template match="/">
  <xsl:variable name="context" select="."/>
   <listPerson xmlns="http://www.tei-c.org/ns/1.0">

   <xsl:for-each select="distinct-values(//t:castList//t:role)">
<person xml:id="{replace(lower-case(.),'[\-\[,.\s]','')}">
<persName type="role"><xsl:value-of select="."/></persName>
<xsl:comment>Add speaker counts here</xsl:comment>
</person>
<xsl:text>
</xsl:text></xsl:for-each>

<xsl:for-each select="distinct-values($context//t:speaker)">
<xsl:variable name="pfx" select="."/>

<persName type="spkr" n="{count($context//*:speaker[starts-with(.,$pfx)])}">
<xsl:value-of select="normalize-space(.)"/>
</persName>
     <xsl:text>
</xsl:text></xsl:for-each>
    
   </listPerson></xsl:template></xsl:stylesheet>
