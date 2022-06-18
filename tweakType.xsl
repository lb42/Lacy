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

 <xsl:template match="bibl">
  <bibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>
  
   <xsl:attribute name="type">
    <xsl:if test="title[@type='sub']">
     <xsl:variable name="playType">
      <xsl:analyze-string select="title[@type = 'sub']" 
       regex="([Cc]omedy|[Cc]omic|[Ff]arce|[Tt]ragedy|[Dd]rama|[Bb]urle|[Pp]antomime|[Cc]omedietta|[Ee]xtravagan|[Oo]per[ae]|[Vv]audeville|[Pp]lay|[Ss]ketch|[Ii]nterlude|[Mm]usic)">
       <xsl:matching-substring>
        <xsl:value-of select="regex-group(1)"/>
       </xsl:matching-substring>
      </xsl:analyze-string>
     </xsl:variable>
     <xsl:analyze-string select="title[@type = 'sub']" regex="in\s*(\d)\s+[Aa]ct">
      <xsl:matching-substring>
       <xsl:value-of select="regex-group(1)"/>
      </xsl:matching-substring>
     </xsl:analyze-string>
     <xsl:text>_</xsl:text>
     <xsl:choose><xsl:when test="string-length($playType) gt 0">
      <xsl:value-of select="$playType"/></xsl:when>
      <xsl:otherwise>X</xsl:otherwise></xsl:choose>
    </xsl:if>
   </xsl:attribute>
  
   <xsl:apply-templates/>
  
  </bibl>
 </xsl:template>

</xsl:stylesheet>
