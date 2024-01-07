<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:for-each select="//*:bibl/*:note/*:ref[contains(@target,'vpp')]">   
   <xsl:variable name="vol">
    <xsl:value-of select="substring-before(ancestor::*:bibl/@n,'.')"/> 
   </xsl:variable>
   <xsl:variable name="tit">
    <xsl:value-of select="substring-after(ancestor::*:bibl/@n,'.')"/> 
   </xsl:variable>
   <xsl:text>mv -n VPP/</xsl:text>
   <xsl:if test="string-length($vol) eq 1">0</xsl:if>
   <xsl:value-of select="$vol"/>
   <xsl:if test="string-length($tit) eq 1">0</xsl:if>
   <xsl:value-of select="$tit"/>
   <xsl:text>*/* Vol</xsl:text>
   <xsl:value-of select="$vol"/> 
   <xsl:text>/</xsl:text>
   <xsl:value-of select="ancestor::*:bibl/@xml:id"/><xsl:text>
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
