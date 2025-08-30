<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns:lb="http://lb42.github.io"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t lb" version="2.0">
 
 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 
 <xsl:template match="*:lic">
  <xsl:variable name="licStr" select="normalize-space(.)"/>
  <xsl:variable name="licDate" select="lb:isoDate($licStr)[1]"/>
  <xsl:message><xsl:value-of select="$licStr"/> contains <xsl:value-of select="$licDate"/></xsl:message>
  <xsl:copy >
   <xsl:if test="$licDate"><xsl:attribute name="when">
    <xsl:value-of select="$licDate"/>
   </xsl:attribute></xsl:if>
   <xsl:apply-templates/>
  </xsl:copy>
  
 </xsl:template>

 <xsl:template match="/ | @* | node()" >
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:function name="lb:isoDate">
  <xsl:param name="str"/>
  <xsl:choose><xsl:when test="matches($str,'.*\d\d?/\d\d?/\d\d\d?\d?')">
   <xsl:analyze-string regex='(\d\d?)/(\d\d?)/(\d+)' select="$str">
   <xsl:matching-substring>
    <xsl:variable name="d">
     <xsl:if test="string-length(regex-group(1)) eq 1">0</xsl:if>    
     <xsl:value-of select="regex-group(1)"/>
    </xsl:variable>
    <xsl:variable name="m">
     <xsl:if test="string-length(regex-group(2)) eq 1">0</xsl:if>    
     <xsl:value-of select="regex-group(2)"/>
    </xsl:variable>
    <xsl:variable name="y">
     <xsl:if test="string-length(regex-group(3)) eq 2">18</xsl:if>    
     <xsl:value-of select="regex-group(3)"/>
    </xsl:variable>   
    <xsl:value-of select="concat($y,'-',$m,'-',$d)"/>   
   </xsl:matching-substring>
   <!--<xsl:non-matching-substring>
    <xsl:message>No date in <xsl:value-of select="$str"/></xsl:message></xsl:non-matching-substring>
-->  </xsl:analyze-string>
  </xsl:when>
  
  <xsl:when test="contains($str, '/')"> <!-- a month-year -->
   <xsl:analyze-string regex='(\d\d?)/(\d+)' select="$str">
    <xsl:matching-substring>
     <xsl:variable name="m" select="regex-group(1)"/>
     <xsl:variable name="y" select="regex-group(2)"/>
     <xsl:if test="string-length($y) eq 2"><xsl:value-of select="concat('18',$y,'-',$m)"/></xsl:if>
     <xsl:value-of select="concat($y,'-',$m)"/>
    </xsl:matching-substring></xsl:analyze-string>
  </xsl:when>
  <xsl:when test="matches($str,'1[78]\d\d')"><!-- there's a year at least --> 
   <xsl:analyze-string regex='(\d\d\d\d)' select="$str">
    <xsl:matching-substring>
     <xsl:value-of select="regex-group(1)"/>
   </xsl:matching-substring></xsl:analyze-string>
  </xsl:when>
  </xsl:choose>
 </xsl:function>
 
 <xsl:function name="lb:monthNum">
  <xsl:param name="s"/>
  <xsl:variable name="mn" select="substring($s,1,3)"/>
  <xsl:value-of select="index-of(('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'),$mn)"/>
 </xsl:function>
</xsl:stylesheet>