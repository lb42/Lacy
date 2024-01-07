<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:for-each select="distinct-values(//t:bibl/normalize-space(replace(t:author[1],'[\[\]]+','')))">
    <xsl:sort/>
   <xsl:variable name="a" select="."/> <xsl:text>
</xsl:text>
   <xsl:value-of select="concat('*',$a,'*')"/><xsl:text>  </xsl:text>
   <xsl:for-each select="$context//t:bibl[matches(normalize-space(t:author[1]),$a)]">
    <xsl:apply-templates select="." />
  </xsl:for-each></xsl:for-each>
 </xsl:template>
 
 <xsl:template match="t:bibl">
<xsl:text>
  </xsl:text>
  <xsl:value-of select="normalize-space(t:title[1])"/><xsl:text> </xsl:text>
  <xsl:value-of select="@n"/>
  <xsl:if test="t:listRef/t:ref[starts-with(@target,'vpp:')]">
   <xsl:text> </xsl:text><xsl:value-of select="@xml:id"/>
  </xsl:if>
  <xsl:if test="@status eq 'TEI-0'"><xsl:text> [T]</xsl:text></xsl:if>
 </xsl:template>
</xsl:stylesheet>