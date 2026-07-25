<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:lb ="http://lb42.github.io"
 exclude-result-prefixes="xs"
 version="3.0">
 <!-- add name link to catalogue.xml 
   a namelink e.g. W0123, is used as the @xml:id value on listPerson//person/@xml:id
   this script copies one from there if it is not already present as the value of an author/@n
   -->
  
 <xsl:template match="*:bibl[@type='originalSource']/*:author">
  <xsl:variable name="untidyName" select="."/>
 <xsl:variable name="tidyName" select="lb:tidy(.)"/>
  <xsl:variable name="count" select="count(document('/home/lou/Public/Lacy/authorList.xml')//*:person[@n eq $tidyName])"/> 
<xsl:copy>
 <xsl:attribute name="n">
   <xsl:choose>
    <xsl:when test="@n">
     <xsl:value-of select="@n"/>
    </xsl:when>
   <xsl:when test="$count eq 1">
    <xsl:value-of select="document('/home/lou/Public/Lacy/authorList.xml')//*:person[@n eq $tidyName]/@xml:id"/>
   </xsl:when>
   <xsl:when test="$count = 0">      
    <xsl:message>No matches for <xsl:value-of select="$tidyName"/></xsl:message>
   <xsl:message>* <xsl:value-of select="concat(ancestor::*:div/@xml:id, $untidyName)"/></xsl:message>
   </xsl:when>
 <xsl:when test="$count &gt; 1"><xsl:message><xsl:value-of select="$tidyName"/> is ambiguous</xsl:message>
 </xsl:when>  
  </xsl:choose>
</xsl:attribute>
  <xsl:apply-templates/>
</xsl:copy>

 </xsl:template>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:function name="lb:tidy">
  <xsl:param name="str"/>  
  <xsl:variable name="q">&quot;“</xsl:variable>
  <xsl:variable name="tidyN" select='normalize-space(replace(replace($str, "[\[\]]",""),$q,""))'/>
  <xsl:value-of select="concat(substring-before($tidyN,', '),substring(substring-after($tidyN,', '),1,1))"/>
 </xsl:function>
</xsl:stylesheet>