<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:lb="https://lb42.github.io"
 exclude-result-prefixes="xs lb" version="3.0">
 
 <!-- add key from authorList to catalogue entries -->
 
 <xsl:template match="/ | @* | node() | comment()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node() | comment()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="*:author">
  <xsl:variable name="auth" select="lb:sanitize(.)"/>
 <!-- <xsl:message>Looking for <xsl:value-of select="$auth"/></xsl:message>
-->  <xsl:variable name="myAuth" select="."/>
  <xsl:for-each select="doc('/home/lou/Public/Lacy/authorList.xml')//*:persName[@type='main']">
   <xsl:variable name="try" select="lb:sanitize(.)"/>
   <xsl:variable name="key" select="ancestor::*:person/@xml:id"/>
   <xsl:if test="starts-with($try,$auth)">
 <!--   <xsl:message>Found!</xsl:message>
 -->   <xsl:copy select="$myAuth"> 
     <xsl:attribute name="ref" select="concat('lacyAuth:',$key)"/>
     <xsl:apply-templates />
    </xsl:copy> 
    
   </xsl:if>
  </xsl:for-each>
 
 
 </xsl:template>
 
 
 
 <xsl:function name="lb:sanitize" as="xs:string">
  <xsl:param name="text"/>
  <xsl:variable name="title">
   <xsl:choose>
    <xsl:when test="contains($text,'(')">
     <xsl:value-of select="substring-before($text,'(')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$text"/>
    </xsl:otherwise></xsl:choose>
  </xsl:variable> 
  <xsl:variable name="result" select="lower-case(normalize-space(replace($title, '\W+', '')))"/>
  <xsl:value-of select="
   if (string-length($result) &gt; 12) then
   substring($result, 1, 12)
   else
   $result"/>
 </xsl:function>
</xsl:stylesheet>