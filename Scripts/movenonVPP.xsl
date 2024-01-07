<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:for-each select="//*:div">   
   <xsl:variable name="vol">
    <xsl:value-of select="substring-before(@n,'/')"/> 
   </xsl:variable>
   <xsl:for-each select="*:bibl[*:note/*:ref[starts-with(@target,'local')]]">
    <xsl:variable name="tit"><xsl:value-of select ="@xml:id"/></xsl:variable>
   <xsl:text>mv -n nonVPP/</xsl:text>
    <xsl:value-of select="$tit"/>
    <xsl:text>.pdf Vol</xsl:text>
   <xsl:value-of select="$vol"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="$tit"/>
  <xsl:text>
</xsl:text></xsl:for-each>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
