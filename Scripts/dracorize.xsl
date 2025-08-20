<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns:lb="http://lb42.github.io"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t lb" version="2.0">
 
 <!-- TODO
  drop bibl/@status 
  move bibl/@corresp to <idno type="nicoll">
  move  eventName to sourceDesc/listEvent/event
  remove listRef
  change ref to idno with @type indicating target type?
  nest bibl type=source within bibl type=digital (yuk)
  @sex and @gender not available for role and actor
  change ref and ident to idno passim
  -->

 <!-- add @who and make dracor conformant -->
 <xsl:param name="thePlay">L0012</xsl:param>
 
 <xsl:variable name="theDoc" select="concat('/home/lou/Public/Lacy/TEI/Partix/Ed/', $thePlay, '.xml')"/>
 <xsl:variable name="today" select="current-date()"/>

 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

<xsl:template match="/">
 <xsl:apply-templates select="TEI"/>
</xsl:template>

 <xsl:template match="TEI">
  <!-- add required @xml:lang -->
  <xsl:copy><xsl:attribute name="xml:lang">eng</xsl:attribute>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/></xsl:copy>
 </xsl:template>

 <xsl:template match="titleStmt/title/@n"/>
 
 <xsl:template match="titleStmt/title">
  <!-- add required @type -->
 <xsl:copy> <xsl:attribute name="type">main</xsl:attribute>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/></xsl:copy>
 </xsl:template>

 <xsl:template match="author">
  <!-- add forename and surname if possible -->
  <xsl:choose>
   <xsl:when test="contains(., ',')">
    <author xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:apply-templates select="@*"/>
     <forename>
      <xsl:value-of select="normalize-space(substring-after(., ','))"/>
     </forename>
     <surname>
      <xsl:value-of select="substring-before(., ',')"/>
     </surname>
    </author>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="distributor">
  <ab xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="."/></ab>
 </xsl:template>
 
 <xsl:template match="listPerson/@type"/>
 
 <xsl:template match="revisionDesc">
 
  <profileDesc xmlns="http://www.tei-c.org/ns/1.0">
   <particDesc>
    <xsl:apply-templates select="document($theDoc)/particDesc/listPerson[@type = 'roles'][1]"/>
   </particDesc>
  </profileDesc>
  <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
   <change when="{$today}">Dracorize</change>
   <xsl:apply-templates/>
  </revisionDesc>
 </xsl:template>
 
 <xsl:template match="person">
  <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{@xml:id}" sex="MALE"><xsl:apply-templates/></person>
 </xsl:template>
 
 <xsl:template match="persName/@type">
  <xsl:choose>
   <xsl:when test=". eq 'spkr'"><xsl:attribute name="type">variant</xsl:attribute></xsl:when>
   <xsl:otherwise/>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="persName/@n"/>
  
 <xsl:template match="sp">
  <sp xmlns="http://www.tei-c.org/ns/1.0" who="{concat('#',lb:getId(speaker))}">
   <xsl:apply-templates/>
  </sp>
 </xsl:template>
 
 <xsl:template match="hi">
  <emph xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></emph>
 </xsl:template>
 
 <xsl:template match="div/@xml:id"/>
 <xsl:template match="head/@xml:id"/>
 <xsl:template match="note/@xml:id"/>
 
 <xsl:template match="body//div[not(@type)]">
  <xsl:choose>
   <xsl:when test="div">
    <div xmlns="http://www.tei-c.org/ns/1.0" type="act">
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:otherwise>
    <div xmlns="http://www.tei-c.org/ns/1.0" type="scene">
     <xsl:apply-templates/>
    </div>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:function name="lb:getId">
  <xsl:param name="spkr"/>
  <xsl:value-of select="document($theDoc)/particDesc/listPerson[@type = 'roles'][1]/(person|personGrp)[persName[@type='spkr'][contains(.,$spkr)]]/@xml:id"/> 
 </xsl:function>
</xsl:stylesheet>
