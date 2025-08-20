<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs"
 version="3.0">
 
<!-- process catalogue to a more dracor like format -->
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="(listBibl|div)/bibl">
  <bibl type="digitalResource" xml:id="{@xml:id}" n="{@n}">
   <bibl type="originalSource">
    <xsl:apply-templates/>
 <xsl:if test="@corresp">    
  <idno type="nicoll"><xsl:value-of select="substring-after(@corresp,':')"/></idno></xsl:if>
   </bibl>
   <linkGrp><desc>Online copies: </desc>
   <xsl:apply-templates select="listRef/*"/>
   </linkGrp>
    <xsl:apply-templates select="note/*"/>
<xsl:if test="note[not(@type)]">
 <note type="misc">
  <xsl:copy select="note[not(@type)]"/>
 </note>
</xsl:if>
</bibl> 
 </xsl:template>

<xsl:template match="listRef"/>
<xsl:template match="note[@type='localCopies']"/>
 <xsl:template match="note[@type='otherPerfs']"/>
 <xsl:template match="note[@type='authorInfo']"/>
 <xsl:template match="note[not(@type)]"/>
 
<xsl:template match="eventName">
 <date type="{@type}" >
  <xsl:if test="@notAfter">
   <xsl:attribute name="notAfter" select="@notAfter"/>
  </xsl:if>
  <name><xsl:value-of select="name"/></name>
  <xsl:choose>
   <xsl:when test="date[@resp eq 'source']"><xsl:value-of select="date[@resp eq 'source']/@when"/></xsl:when>
   <xsl:when test="date[@resp eq 'nicoll']"><xsl:value-of select="date[@resp eq 'nicoll']/@when"/></xsl:when>
   <xsl:otherwise> n.d. </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="date[@resp eq 'source']"/>
 </date>
 <xsl:if test="following-sibling::note[@type='otherPerfs']">
  <xsl:copy-of select="following-sibling::note[@type='otherPerfs']"/>
 </xsl:if>
</xsl:template>
 
 <xsl:template match="listRef/ref">
  <ptr type="{.}" target="{@target}"/><xsl:text>
</xsl:text>
 </xsl:template> 
 
<xsl:template match="note/ident">
 <idno type="ident"><xsl:value-of select="."/></idno><xsl:text>
</xsl:text>
</xsl:template> 
 
 
 
 <xsl:template match="teiHeader"/>
</xsl:stylesheet>