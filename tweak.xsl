<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">

 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <!-- fix @n attribute -->

 <xsl:template match="bibl/@n">
  <xsl:attribute name="n">
   <xsl:value-of select="substring-before(., '_')"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="bibl/@status"/>

 <!-- add magic key on title -->

 <xsl:template match="title[not(@type = 'sub')]">
  <title xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="n">
    <xsl:choose>
     <xsl:when test="contains(., ':')">
      <xsl:value-of select="t:sanitize(substring-before(., ':'))"/>
     </xsl:when>
     <xsl:when test="contains(., ';')">
      <xsl:value-of select="t:sanitize(substring-before(., ';'))"/>
     </xsl:when>
     <xsl:when test="contains(., ',')">
      <xsl:value-of select="t:sanitize(substring-before(., ','))"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="t:sanitize(.)"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:apply-templates/>
  </title>
 </xsl:template>
 <!-- group performance info -->
 <xsl:template match="note[@type = 'firstPerf']">
  <note type="firstPerf" xmlns="http://www.tei-c.org/ns/1.0">
   <name>
    <xsl:value-of select="."/>
   </name>
   <xsl:text>
</xsl:text>
   <xsl:copy-of select="../date"/>
   <xsl:if test="../note[@type = 'LCP']">
    <ref type="ms" target="{../note[@type='LCP']/ref/@target}" xmlns="http://www.tei-c.org/ns/1.0"
     >LC ms</ref>
   </xsl:if>
  </note>


 </xsl:template>

 <!-- group digitization info -->

 <xsl:template match="bibl">
  <bibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>
   <xsl:attribute name="type">
    <xsl:analyze-string select="title[@type = 'sub']" regex="in\s*(\d)\s[Aa]ct">
     <xsl:matching-substring>
      <xsl:value-of select="regex-group(1)"/>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:text>_</xsl:text>
    <xsl:analyze-string select="title[@type = 'sub']"
     regex="([Cc]omedy|[Ff]arce|[Tt]ragedy|[Dd]rama|[Bb]urlesque|[Pp]antomime|[Cc]omedietta)">
     <xsl:matching-substring>
      <xsl:value-of select="regex-group(1)"/>
     </xsl:matching-substring>
    </xsl:analyze-string>
   </xsl:attribute>
   <xsl:apply-templates/>
   <xsl:if test="ref">
    <note type="digitizations" xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:for-each select="ref">
      <xsl:copy-of select="."/>
     </xsl:for-each>
    </note>
   </xsl:if>
  </bibl>
 </xsl:template>

 <xsl:template match="author">
  <author xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </author>
  <xsl:if test="note">
   <note type="authorInfo" xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:value-of select="normalize-space(note)"/>
   </note>
  </xsl:if>
 </xsl:template>

 <!-- more work to do here -->

 <xsl:template match="note[@type = 'LCP']/keywords">
  <note type="keywords">
   <xsl:apply-templates/>
  </note>
 </xsl:template>

 <xsl:template match="author/note"/>
 <xsl:template match="date"/>
 <xsl:template match="bibl/ref"/>

 <xsl:function name="functx:contains-any-of" as="xs:boolean" xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="searchStrings" as="xs:string*"/>

  <xsl:sequence select="
    some $searchString in $searchStrings
     satisfies contains($arg, $searchString)"/>

 </xsl:function>
 <xsl:function name="t:sanitize" as="xs:string">
  <xsl:param name="text"/>
  <xsl:variable name="result" select="lower-case(normalize-space(replace($text, '\W+', '')))"/>
  <xsl:value-of select="
    if (string-length($result) &gt; 21) then
     concat(substring($result, 1, 21), '...')
    else
     $result"/>
 </xsl:function>
</xsl:stylesheet>
