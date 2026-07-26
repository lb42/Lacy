<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
 version="3.0">
 
 <!-- show number of TEI titles per volume -->
 
 <xsl:template match="/">
  
  <xsl:variable name="zeroVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) eq 0]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($zeroVols), ' (',string-join($zeroVols,' '),') have 0 TEI titles')"/></xsl:message>
  <xsl:variable name="oneVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) eq 1]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($oneVols), ' (',string-join($oneVols,' '),') have 1 TEI title')"/></xsl:message>
  <xsl:variable name="twoVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) eq 2]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($twoVols), ' (',string-join($twoVols,' '),') have 2 TEI title')"/></xsl:message>
  <xsl:variable name="threeVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) eq 3]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($threeVols), ' (',string-join($threeVols,' '),') have 3 TEI titles')"/></xsl:message>
  <xsl:variable name="fourVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) ge 4]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($fourVols), ' (',string-join($fourVols,' '),') have 4+ TEI titles')"/></xsl:message>
  <xsl:variable name="fiveVols"  select="//*:div[@type='volume'][count(*:div[@type='work' and @subtype='TEI']) ge 5]/substring-before(@n,'/')"/>
  <xsl:message><xsl:value-of select="concat( count($fiveVols), ' (',string-join($fiveVols,' '),') have 5+ TEI titles')"/></xsl:message>
  
  
 </xsl:template>
</xsl:stylesheet>