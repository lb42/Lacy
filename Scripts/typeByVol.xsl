<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:apply-templates select="//body"/>
 </xsl:template>

 <!--  -->

 <xsl:template match="body">
  <xsl:variable name="lacyTot" select="count(//div[@type = 'work'])"/>
  <xsl:variable name="vppTot"
   select="count(//div[@type = 'work' and bibl[@type = 'printSource']/idno[@type = 'vpp']])"/>
  <xsl:variable name="teiTot" select="count(//div[@type = 'work' and @subtype eq 'TEI'])"/>
  <xsl:variable name="types"
   select="distinct-values(//div[@type = 'work']/tokenize(@ana, '_')[last()])"/>

  <xsl:variable name="root" select="."/>
 
  <xsl:text>
total,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:value-of select="concat(.,',')"/>
  </xsl:for-each>
  <xsl:text>
</xsl:text>
  <xsl:value-of select="$lacyTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:variable name="t" select="concat('_', .)"/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:value-of select="format-number(count($root/div/div[@type = 'work' and ends-with(@ana, $t)]) div $lacyTot, '#.##')"/>
   </xsl:if>
   <xsl:if test="not(position() = last())">
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  <xsl:text>
</xsl:text>

  <xsl:value-of select="$vppTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:variable name="t" select="concat('_', .)"/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:value-of
     select="format-number(count($root/div/div[@type = 'work' and ends-with(@ana, $t) and bibl[@type = 'printSource']/idno[@type = 'vpp']]) div $vppTot, '#.##')"
    />
   </xsl:if>
   <xsl:if test="not(position() = last())">
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  
  <xsl:text>
</xsl:text>

  <xsl:value-of select="$teiTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:variable name="t" select="concat('_', .)"/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:value-of
     select="format-number(count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI']) div $teiTot,'#.##')"/>
   </xsl:if>
   <xsl:if test="not(position() = last())">
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  <xsl:text>
</xsl:text>

 </xsl:template>
</xsl:stylesheet>
