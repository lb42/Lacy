<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:output omit-xml-declaration="yes" method="text"/>
 
 <xsl:variable name="root" select="/"/>
 <xsl:variable name="allWorks" select="$root//div[@type = 'work']"/>
 <xsl:variable name="vppWorks" select="$allWorks[bibl[@type='originalSource']/idno[@type='vpp']]"/>
 <xsl:variable name="teiWorks" select="$allWorks[@subtype = 'TEI']"/>
 
 <xsl:variable name="lacyTot" select="count($allWorks)"/>
 <xsl:variable name="vppTot" select="count($vppWorks)"/>
 <xsl:variable name="teiTot" select="count($teiWorks)"/>
 
 <xsl:template match="/">
  <xsl:apply-templates select="$root//body"/>
 </xsl:template>
 
 <xsl:template match="body">
  <xsl:message>Totals: <xsl:value-of select="$lacyTot"/> Lacy titles, <xsl:value-of select="$vppTot"/> are in VPP; and <xsl:value-of select="$teiTot"/> in TEI</xsl:message>
  
  <xsl:message>TEI per Volume counts: </xsl:message>
  <xsl:variable name="volumes" select="//div[@type='volume']"/>
  
  <xsl:for-each select="0 to 3">
   <xsl:variable name="vCount" select="."/>
   <xsl:variable name="matchingVols" select="$volumes[count(child::div[@type='work' and @subtype='TEI']) eq $vCount]"/>
   <xsl:variable name="vNames" select="for $v in $matchingVols return substring-before($v/@n, '/')"/>
   <xsl:message>
    <xsl:value-of select="count($vNames)"/> (<xsl:value-of select="string-join($vNames, ' ')"/>) have <xsl:value-of select="$vCount"/> TEI title<xsl:if test="$vCount ne 1">s</xsl:if>
   </xsl:message>
  </xsl:for-each>
  
  <xsl:variable name="v4Plus" select="$volumes[count(child::div[@type='work' and @subtype='TEI']) ge 4]"/>
  <xsl:variable name="v4Names" select="for $v in $v4Plus return substring-before($v/@n, '/')"/>
  <xsl:message>
   <xsl:value-of select="count($v4Names)"/> (<xsl:value-of select="string-join($v4Names, ' ')"/>) have 4+ TEI titles
  </xsl:message>
  
  <xsl:message>Checking balance for ...</xsl:message>
  
  <xsl:variable name="dateTypes" 
   select="distinct-values($allWorks/listEvent/event[@type = 'firstPerf' and starts-with(@when, '18')]/substring(@when, 1, 3))"/>
  <xsl:call-template name="generate-report">
   <xsl:with-param name="label" select="'date criterion'"/>
   <xsl:with-param name="types" select="$dateTypes"/>
   <xsl:with-param name="mode" select="'date'"/>
  </xsl:call-template>
  
  <xsl:variable name="genreTypes" select="distinct-values($allWorks/tokenize(@ana, '_')[last()])"/>
  <xsl:call-template name="generate-report">
   <xsl:with-param name="label" select="'genre criterion'"/>
   <xsl:with-param name="types" select="$genreTypes"/>
   <xsl:with-param name="mode" select="'genre'"/>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="generate-report">
  <xsl:param name="label"/>
  <xsl:param name="types"/>
  <xsl:param name="mode"/>
  
  <xsl:message> ... <xsl:value-of select="$label"/></xsl:message>
  <xsl:text>total,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:value-of select="concat(., ',')"/>
  </xsl:for-each>
  <xsl:text>&#10;</xsl:text>
  
  <xsl:call-template name="output-row">
   <xsl:with-param name="rowLabel" select="'Lacy'"/>
   <xsl:with-param name="works" select="$allWorks"/>
   <xsl:with-param name="total" select="$lacyTot"/>
   <xsl:with-param name="types" select="$types"/>
   <xsl:with-param name="mode" select="$mode"/>
  </xsl:call-template>
  
  <xsl:call-template name="output-row">
   <xsl:with-param name="rowLabel" select="'VPP'"/>
   <xsl:with-param name="works" select="$vppWorks"/>
   <xsl:with-param name="total" select="$vppTot"/>
   <xsl:with-param name="types" select="$types"/>
   <xsl:with-param name="mode" select="$mode"/>
  </xsl:call-template>
  
  <xsl:call-template name="output-row">
   <xsl:with-param name="rowLabel" select="'TEI'"/>
   <xsl:with-param name="works" select="$teiWorks"/>
   <xsl:with-param name="total" select="$teiTot"/>
   <xsl:with-param name="types" select="$types"/>
   <xsl:with-param name="mode" select="$mode"/>
   <xsl:with-param name="isTEI" select="true()"/>
  </xsl:call-template>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>
 
 <xsl:template name="output-row">
  <xsl:param name="rowLabel"/>
  <xsl:param name="works"/>
  <xsl:param name="total"/>
  <xsl:param name="types"/>
  <xsl:param name="mode"/>
  <xsl:param name="isTEI" select="false()"/>
  
  <xsl:value-of select="$total"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="."/>
   
   <xsl:variable name="f" select="count(if ($mode eq 'date') 
    then $works[substring(listEvent/event[@type = 'firstPerf'][1]/@when, 1, 3) eq $t]
    else $works[ends-with(@ana, concat('_', $t))])"/>
   
   <xsl:value-of select="$f"/>
   
   <xsl:if test="not($isTEI)">
    <xsl:variable name="teiF" select="count(if ($mode eq 'date') 
     then $teiWorks[substring(listEvent/event[@type = 'firstPerf'][1]/@when, 1, 3) eq $t] 
     else $teiWorks[ends-with(@ana, concat('_', $t))])"/>
    
    <xsl:variable name="perc" select="if ($total gt 0) then round(($f div $total) * 100) else 0"/>
    <xsl:variable name="diff" select="$perc - $teiF"/>
    
    <xsl:if test="abs($diff) gt 2">
     <xsl:value-of select="concat(' (', $diff, ')')"/>
     <xsl:message>For <xsl:value-of select="$t"/>, <xsl:value-of select="$rowLabel"/>% = <xsl:value-of select="$perc"/> should be <xsl:value-of select="$teiF"/></xsl:message>
    </xsl:if>
   </xsl:if>
   <xsl:text>,</xsl:text>
  </xsl:for-each>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>
 
</xsl:stylesheet>
