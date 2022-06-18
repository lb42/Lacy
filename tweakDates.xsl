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
<xsl:template match="div[@type='volume']">
 <div type="volume"  n="{@n}/{@notBefore}">
  <xsl:apply-templates/>
 </div>
</xsl:template>
<xsl:template match="date">
 <xsl:variable name="lacyId">
  <xsl:value-of select="ancestor::bibl/@xml:id"/>
 </xsl:variable>
 <xsl:variable name="yr"> 
  <xsl:value-of select="t:getYr(normalize-space(.))"/>
 </xsl:variable>

 <xsl:choose>
  <xsl:when test="string-length(normalize-space(.)) eq 0">
   <xsl:message>Empty date in <xsl:value-of select="$lacyId"/></xsl:message>
  </xsl:when> 
  <!-- if there was no year, cant use @when-->
  <xsl:when test="$yr eq ''">
   <date><xsl:value-of select="normalize-space(.)"/></date>
   <xsl:if test="not(contains(.,'Unknown'))">
   </xsl:if>
  </xsl:when>
  <xsl:otherwise>
<!-- otherwise check it against any existing @when -->  
  
  <xsl:if test="@when">
  <xsl:variable name="claimedYr">
  <xsl:value-of select="@when"/>
 </xsl:variable>   
 <xsl:if test="$yr ne $claimedYr">
  <xsl:message><xsl:value-of select="$lacyId"/> : <xsl:value-of select="normalize-space(.)"/>  ...  <xsl:value-of select="$yr"/> or <xsl:value-of select="$claimedYr"/> ??? </xsl:message>
 </xsl:if>
 </xsl:if>
 <!-- and use it anyway -->
   <date when="{$yr}"><xsl:value-of select="normalize-space(.)"/></date>
  </xsl:otherwise>

<!--<xsl:message><xsl:value-of select="$lacyId"/> : <xsl:value-of select="normalize-space(.)"/>  ...  <xsl:value-of select="$yr"/></xsl:message>-->
</xsl:choose>

</xsl:template>
 
 <xsl:function name="t:getYr">
  <xsl:param name="str"/>
  <xsl:choose>
   <xsl:when test="$str eq 'Unknown'"/>
   <xsl:when test="matches($str, '1[78]\d\d')">
    <xsl:value-of select="replace($str,'(.*)(1[78]\d\d)(.*)$','$2')"/>    
   </xsl:when>
   <xsl:otherwise>
    <xsl:message> <xsl:value-of select="$str"/> contains no valid year</xsl:message>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function> 
</xsl:stylesheet>
