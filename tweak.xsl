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

<!-- suppress unwanted attributes -->
 <xsl:template match="div/@org"/>
 <xsl:template match="div/@part"/>
 <xsl:template match="note/@anchored"/>
 <xsl:template match="bibl/@status[not(. eq 'supplied')]"/>
 
 <!-- remove empty notes -->
 <xsl:template match="note[string-length(normalize-space(.)) eq 0][parent::date]"/>
 
 <!-- add @notBefore attribute to each volume -->

<xsl:template match="div[@type='volume']">
 <xsl:copy><xsl:attribute name="notBefore">
  <xsl:value-of select="max(bibl/date/@when)"/>
 </xsl:attribute>
 <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/></xsl:copy>
</xsl:template>
 
 <!-- fix @n attribute -->

 <xsl:template match="bibl/@n">
  <xsl:attribute name="n">
   <xsl:value-of select="substring-before(., '_')"/>
  </xsl:attribute>
 </xsl:template>

 
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
   <xsl:choose>
    <xsl:when test="contains(.,'[')">
   <name><xsl:value-of select="substring-before(.,'[')"/>
  </name>   
    </xsl:when>
    <xsl:otherwise>
     <name>
      <xsl:value-of select="."/>
     </name>
    </xsl:otherwise>
   </xsl:choose>

   <xsl:choose>
    <xsl:when test="not(contains(../date,'['))">     
     <xsl:copy-of select="../date"/>
    </xsl:when>
    <xsl:when test="starts-with(../date,'[')">     
     <xsl:copy-of select="../date"/>
    </xsl:when>
    <xsl:otherwise>
     <date><xsl:value-of select="substring-before(../date,'[')"/></date>
    </xsl:otherwise>
   </xsl:choose>  
   <xsl:if test="../note[@type = 'LCP']">. Licenced for performance 
    <ref type="ms" target="{../note[@type='LCP']/ref/@target}" xmlns="http://www.tei-c.org/ns/1.0"
     >LC ms</ref>
   </xsl:if>
   
  </note>

  <xsl:if test="contains(.,'[')">
   <note type="otherPerfs">
    <name><xsl:value-of select="substring-before(substring-after(.,'['),']')"/></name>
    <date><xsl:value-of select="substring-before(substring-after(../date,'['),']')"/></date> 
   </note>
  </xsl:if>

 </xsl:template>

 <!-- group digitization info -->

 <xsl:template match="bibl">
  <bibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>
   <xsl:attribute name="xml:id">
    <xsl:text>L</xsl:text>
    <xsl:number value="count(preceding::*:bibl)+1" format="0001"/>
   </xsl:attribute>
   <xsl:attribute name="type">
<xsl:if test="title[@type='sub']">
 <xsl:variable name="playType">
  <xsl:analyze-string select="title[@type = 'sub']" 
   regex="([Cc]omedy|[Ff]arce|[Tt]ragedy|[Dd]rama|[Bb]urlesque|[Pp]antomime|[Cc]omedietta)">
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
    <xsl:choose><xsl:when test="$playType"><xsl:value-of select="$playType"/></xsl:when>
     <xsl:otherwise>"X"</xsl:otherwise></xsl:choose>
</xsl:if>
   </xsl:attribute>
   <xsl:apply-templates/>
   <xsl:if test="ref">
    <note type="digitizations" xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:for-each select="ref">
      <xsl:copy-of select="."/>
     </xsl:for-each>
    </note>
   </xsl:if>
   <xsl:if test="@status='supplied'">
    <note type="firstPerf"><date /></note>
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
