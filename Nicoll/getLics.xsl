<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:lb="http://lb42.github.io"
 exclude-result-prefixes="xs "
 version="3.0">
 <xsl:template match="/">
  <adds xmlns="http://lb42.github.io">
   <xsl:apply-templates select="//*:entry[@matches and *:lic]"/>
  </adds>
 </xsl:template>
 
 <xsl:template match="*:entry">
 
  <add to="{@matches}" xmlns="http://lb42.github.io">
   <xsl:variable name="licStr" select="normalize-space(*:lic[1])"/>
   <xsl:if test="*:lic[2]"><xsl:message>Only the first lic is taken into account</xsl:message></xsl:if>
   <xsl:variable name="licDate" select="lb:isoDate($licStr)[1]"/>
  
   <xsl:choose>
   <xsl:when test="matches($licStr, 'L\.C\.\s*$')"><!-- no date provided -->
    <eventName type="LC" >  <xsl:value-of select="$licStr"/></eventName>
   </xsl:when>
   <xsl:when test="matches($licStr, 'L\.C\.\s+as\s+')">
    <eventName type="LC" >  <xsl:value-of select="$licStr"/></eventName>
   </xsl:when>
   <xsl:when test="$licDate ne ''"><!-- Some date found -->
 <xsl:choose>
  <xsl:when test="matches($licStr, 'L\.? [\d\sA-Za-z]+\.?\s*\[[^\d]*[\d/]+')">
   <eventName type="larpent" n="{normalize-space(substring-before($licStr,'['))}" when="{$licDate}">
    <xsl:value-of select="$licStr"/>
   </eventName>
  </xsl:when>
  <xsl:when test="matches($licStr, 'MS[\.\s]+Larpent[\d\sA-Z\.]+\[[\d/]+')">
   <eventName type="larpent" n="{normalize-space(substring-before($licStr,'['))}" when="{$licDate}">
    <xsl:value-of select="$licStr"/>
   </eventName>
  </xsl:when> 
 
  <xsl:when test="matches($licStr, 'L\.C\.\s+')">
   <eventName type="LC" when="{$licDate}">  <xsl:value-of select="$licStr"/></eventName>
  </xsl:when>
  <xsl:otherwise>
   <xsl:comment>
    <xsl:text>No match for </xsl:text>
    <xsl:value-of select="$licStr"/></xsl:comment>
  </xsl:otherwise>
 </xsl:choose>
   </xsl:when>
  
  <xsl:when test="contains($licStr, '/')"> <!-- a month-year -->
   <xsl:analyze-string regex='(\d\d?)/(\d+)' select="$licStr">
    <xsl:matching-substring>
     <xsl:variable name="m" select="regex-group(1)"/>
     <xsl:variable name="y" select="regex-group(2)"/>
     <eventName type="LC" when="{concat($y,'-',$m)}"><xsl:value-of select="$licStr"/> </eventName></xsl:matching-substring></xsl:analyze-string>
  </xsl:when>
   <xsl:when test="matches($licStr,'1[78]\d\d')"><!-- there's a year at least --> 
    <xsl:analyze-string regex='(\d\d\d\d)' select="$licStr">
     <xsl:matching-substring>
      <eventName type="LC" when="{regex-group(1)}"><xsl:value-of select="$licStr"/> </eventName></xsl:matching-substring></xsl:analyze-string>
   </xsl:when>
  <xsl:otherwise>
  <!-- <xsl:comment>
    <xsl:text>No date found in  </xsl:text>
    <xsl:value-of select="$licStr"/></xsl:comment>-->
   <eventName type="LC"><xsl:value-of select="$licStr"/></eventName>
  </xsl:otherwise>

  </xsl:choose>
     </add>
  <xsl:text>
 </xsl:text>
 </xsl:template>
 
 
 <xsl:function name="lb:isoDate">
  <xsl:param name="str"/>
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
 </xsl:function>
 
 <xsl:function name="lb:toIso">
  <xsl:param name="str"/>       
  <xsl:variable name="normStr" select="normalize-space(replace($str,'[\[\]\.,]',' '))"/>
  <xsl:analyze-string regex="(\d+)\s+(.*)\s+(\d{{4}})\s*.*|([A-Za-z]+)\s+(\d+)\s+(\d{{4}})\s*.*|([A-Za-z]+)\s+(\d{{4}})\s*.*|(\d{{4}})\s*.*" select="$normStr">
   <xsl:matching-substring><xsl:choose><xsl:when test="matches($normStr,'(\d+)\s+(.*)\s+(\d{4})\s*.*')">
    <xsl:variable name="month" select="lb:monthNum(regex-group(2))"/>
    <xsl:value-of select="regex-group(3)"/><xsl:text>-</xsl:text>
    <xsl:value-of select="format-number(number($month), '00')"/><xsl:text>-</xsl:text>
    <xsl:value-of select="format-number(number(regex-group(1)), '00')"/></xsl:when>
    <xsl:when  test="matches($normStr,'([A-Za-z]+)\s+(\d+)\s+(\d{4})')">
     <!-- month dd year --> <xsl:variable name="month" select="lb:monthNum(regex-group(4))"/>
     <xsl:value-of select="regex-group(6)"/><xsl:text>-</xsl:text>
     <xsl:value-of select="format-number(number($month), '00')"/><xsl:text>-</xsl:text>
     <xsl:value-of select="format-number(number(regex-group(5)), '00')"/></xsl:when>
    <xsl:when test="matches($normStr,'([A-Za-z]+)\s+(\d{4})')">
     <!-- month year -->   <xsl:variable name="month" select="lb:monthNum(regex-group(7))"/>
     <xsl:value-of select="regex-group(8)"/><xsl:text>-</xsl:text>
     <xsl:value-of select="format-number(number($month), '00')"/>                 
    </xsl:when>  
    <xsl:when test="matches($normStr,'(\d{4})')">
     <!-- year -->   
     <xsl:value-of select="regex-group(9)"/></xsl:when>
    <xsl:otherwise></xsl:otherwise></xsl:choose>
   </xsl:matching-substring>
   <xsl:non-matching-substring><xsl:message>No match for <xsl:value-of select="$normStr"/></xsl:message></xsl:non-matching-substring></xsl:analyze-string>
 </xsl:function>
 
 <xsl:function name="lb:monthNum">
  <xsl:param name="s"/>
  <xsl:variable name="mn" select="substring($s,1,3)"/>
  <xsl:value-of select="index-of(('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'),$mn)"/>
 </xsl:function>
</xsl:stylesheet>