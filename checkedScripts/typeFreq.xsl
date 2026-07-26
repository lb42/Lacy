<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:output method="text"/>
 
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:variable name="pop" select="count(//t:div[@type='work' and not(@subtype='nf')])"/>  
  <xsl:variable name="samp" select="count(//t:div[@type='work' and @subtype='TEI'])"/>

  <xsl:message><xsl:value-of select="concat('pop is ',$pop,' samp is ',$samp)"/></xsl:message>
<xsl:text>Type, Count, Perc, TEI-count, TEI-perc, TEI-diff
</xsl:text>

  <xsl:for-each select="distinct-values(//t:div[@type='work']/tokenize(@ana,'_')[last()])">
   <xsl:sort/>
   <xsl:variable name="val" select="."/>
   <xsl:if test="$val ne ''">
   <xsl:variable name="count" select="count($context//t:div[ends-with(@ana, $val)])"/>
    <xsl:variable name="percPop" select="$count div $pop *100"/>
    
  <!-- <xsl:variable name="percPop" select="format-number($count div $pop *100, '##.##')"/>
 --><!--  <xsl:message><xsl:value-of select="concat($val,' occurs ',$count,' times, i.e. ',$percPop,' % of LAE
')"/></xsl:message>
-->   <xsl:variable name="countSamp" select="count($context//t:div[@subtype='TEI' and ends-with(@ana, $val)])"/>
   <xsl:variable name="percSamp" select="$countSamp div $samp *100"/>
    
  <!-- <xsl:message><xsl:value-of select="concat($val,' occurs ',$countSamp,' times i.e. ',$percSamp,'% of TEI subset
    ')"/></xsl:message>
 -->
    <xsl:variable name="sampDiff" select="$percPop - $percSamp"/>
    
    
    <xsl:value-of select="concat($val, ',', $count, ',', format-number($percPop,'##.####'), ',',$countSamp, ',', format-number($percSamp, '##.####'), ',   ' , format-number($sampDiff,'##.####') )"/>
   <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
   <xsl:text>
</xsl:text></xsl:if>
  </xsl:for-each>
 
 </xsl:template>
</xsl:stylesheet>
