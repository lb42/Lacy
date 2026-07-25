<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:template match="t:person/t:listBibl[@type='lacyTitles']">
  <xsl:variable name="persLink" select="ancestor::t:person/@xml:id"/>
  <listBibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:for-each select="document('/home/lou/Public/Lacy/catalogue.xml')//t:author[@n = $persLink]">
    <xsl:sort select="ancestor::t:div[@type='work']/@xml:id"/>
    <bibl> <ref target="{ancestor::t:div[@type='work']/@xml:id}">
      <xsl:value-of select="normalize-space(following-sibling::t:title[@type='main'])"/>
      <xsl:if test="ancestor::t:div[@type='work']/@subtype eq 'TEI'"><xsl:text> [T]</xsl:text></xsl:if>
  </ref></bibl><xsl:text>
</xsl:text>
   </xsl:for-each>   
</listBibl>
</xsl:template>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>