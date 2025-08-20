<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">


 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="t:person/t:listBibl[@type='seeAlso']">
  <xsl:variable name="myId" select="ancestor::t:person/@xml:id"/>
  <xsl:copy>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
   <xsl:for-each select="document('boase.xml')/t:TEI/t:text/t:body/t:div[@corresp eq $myId]">
  <bibl><ref target="{concat('https://lb42.github.io/Lacy/boase.html#',@xml:id)}">Boase</ref></bibl>  
<!--
   <xsl:message>Found <xsl:value-of select="$myId"/></xsl:message>
 -->  </xsl:for-each>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
