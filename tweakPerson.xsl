<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
 version="3.0">
 
 <xsl:template match="*:person">
  <xsl:copy>  
   <xsl:choose>
   <xsl:when test="*:persName[contains(.,'(1')]">
    <xsl:variable name="birth" select="substring(substring-after(*:persName[contains(.,'(1')], '('),1,4)"/>
    <xsl:variable name="death" select="substring(substring-after(*:persName[contains(.,'(1')], '–'),1,4)"/>
     <xsl:attribute name="age">
     <xsl:choose>
      <xsl:when test="$birth &lt; '1688'">G0</xsl:when>
      <xsl:when test="$birth &lt; '1780'">G1</xsl:when>
      <xsl:when test="$birth &lt; '1800'">G2</xsl:when>
      <xsl:when test="$birth &lt; '1820'">G3</xsl:when>
      <xsl:when test="$birth &lt; '1840'">G4</xsl:when>
      <xsl:otherwise>G5</xsl:otherwise>
     </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="@*"/>   
    <birth xmlns="http://lb42.github.io" when="{$birth}"/>
    <death xmlns="http://lb42.github.io" when="{$death}"/>
   </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="@*"/>       
    </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates/> 
   <xsl:if test="@ref">
    <idno xmlns="http://lb42.github.io" type="VIAF"><xsl:value-of select="substring-after(@ref,'viaf/')"/></idno>  
   </xsl:if>
   <xsl:for-each select="*:ref[@target]">
    <ptr xmlns="http://lb42.github.io"  type="seeAlso" target="{@target}"/>
   </xsl:for-each>
   <xsl:if test="@dlb">
    <ptr xmlns="http://lb42.github.io" target="DLB"/>
   </xsl:if>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="@birth"/> <xsl:template match="@freq"/> <xsl:template match="@lacyTitles"/><xsl:template match="@dlb"/><xsl:template match="@ref"/>
 
<xsl:template match="*:person/*:ref[@target]"/>
 
 <xsl:template match="*:listBibl">
  <xsl:copy>
   <xsl:for-each select="tokenize(.)">
    <bibl xmlns="http://lb42.github.io" ><xsl:value-of select="."/></bibl>
   </xsl:for-each>
  </xsl:copy> 
 </xsl:template>
  
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>