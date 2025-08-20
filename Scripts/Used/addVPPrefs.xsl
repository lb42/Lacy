<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">
 
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="listRef">
 <xsl:variable name="identList" select="following-sibling::note[@type='localCopies']/ident"/>
 <xsl:variable name="identString" select="string-join($identList,' ')"/>
 <xsl:variable name="textId" select="ancestor::bibl/@xml:id"/>
 <xsl:text>
 </xsl:text>
 <xsl:copy>  
  <xsl:if test="contains($identString, '-vpp')">
<!--  <xsl:message><xsl:value-of select="$textId"/> is a vpp file</xsl:message>
-->   <ref xmlns="http://www.tei-c.org/ns/1.0" target="{concat('https://lb42.github.io/Lacy/Source/VPP/',$textId,'-vpp.pdf')}">LDB from VPP</ref>
 </xsl:if>
  <xsl:apply-templates/>
</xsl:copy></xsl:template>

<xsl:template match="listRef/ref">
 <xsl:copy>
  <xsl:apply-templates select="@*"/>
 <xsl:choose> 
  <xsl:when test="contains(@target, 'mdp')">UM from HT</xsl:when>
  <xsl:when test="contains(@target, 'uiug')">UIU from HT</xsl:when>
  <xsl:when test="contains(@target, 'hvd')">HVD from HT</xsl:when>
  <xsl:when test="contains(@target, 'uc1')">UC from HT</xsl:when>
 <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
 </xsl:choose>
 </xsl:copy>
</xsl:template>

<xsl:template match="note/ident">
 <xsl:copy-of select="."/><xsl:text> </xsl:text>  
</xsl:template>
</xsl:stylesheet>