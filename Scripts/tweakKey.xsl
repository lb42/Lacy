<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs lb"
 xmlns:lb="http://lb42.github.io"
 version="2.0">
 
 <xsl:template match=" @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 
 <xsl:template match="//*:div/*:bibl/*:title[1]">
     <!-- calculate magic key from bibl -->
   <xsl:variable name="key">   
<!--    <xsl:message>Processing <xsl:value-of select="."/></xsl:message>-->
 <xsl:choose>
     <xsl:when test="contains(.,':')">
      <xsl:value-of select="lb:sanitize(substring-before(.,':'))"/>
     </xsl:when>
     <xsl:when test="contains(.,';')">
      <xsl:value-of select="lb:sanitize(substring-before(.,';'))"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="lb:sanitize(.)"/>
     </xsl:otherwise>
    </xsl:choose> 
    </xsl:variable>
   <xsl:variable name="key-2">
    <xsl:value-of select="@n"/>
    </xsl:variable>
   
<xsl:if test="$key ne $key-2"><xsl:message>Replacing <xsl:value-of select="concat($key-2, ' with ', $key)"/></xsl:message></xsl:if>
   
 <xsl:copy>
      <xsl:attribute name="n">
      <xsl:value-of select="$key"/>
     </xsl:attribute>
    <xsl:apply-templates/>
 </xsl:copy>

 </xsl:template>
 
 <xsl:function name="lb:sanitize" as="xs:string">
  <xsl:param name="text"/>        
  <xsl:variable name="result" select="
   lower-case(normalize-space(replace($text, '\W+', '')))"/>
  <xsl:value-of select="
   if (string-length($result) &gt; 21) then
   concat(substring($result, 1, 21), '...')
   else
   $result"/>
 </xsl:function>
</xsl:stylesheet>