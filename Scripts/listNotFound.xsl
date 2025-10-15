<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
version="2.0">
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:text>Titles listed in the Lacy Catalogue, but not online
  </xsl:text>
<xsl:for-each
select="//*:div[@type = 'volume'][*:div[@type = 'work' and @subtype = 'nf']]">
<xsl:text>  
 
------------

</xsl:text>
<xsl:value-of select="concat('Volume ', @n)"/>
<xsl:text>
</xsl:text>
<xsl:for-each select="*:div[@type = 'work' and @subtype = 'nf']"><xsl:text>
</xsl:text>
<xsl:value-of select="@xml:id"/>
<xsl:text>: </xsl:text>
<xsl:for-each select="*:bibl/*:author[position() ne last()]">
<xsl:value-of select="normalize-space(.)"/>
<xsl:text>; </xsl:text>
</xsl:for-each>
<xsl:value-of select="normalize-space(*:bibl/*:author[position() eq last()])"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="normalize-space(*:bibl/*:title[1])"/>
<xsl:text>. </xsl:text>
<xsl:for-each select="*:bibl/*:title[@type = 'sub']">
<xsl:value-of select="normalize-space(.)"/>
<xsl:text>  </xsl:text>
</xsl:for-each>

<xsl:text>(</xsl:text>
<xsl:value-of
select="normalize-space(*:listEvent/*:event[@type = 'firstPerf'][1]/*:desc)"/>
<xsl:text>) </xsl:text>

</xsl:for-each>
</xsl:for-each>
<xsl:text>
  </xsl:text>
<!--  <xsl:text>Titles listed in the Lacy Catalogue, but not yet found in Nicoll
  </xsl:text>
  <xsl:for-each select="//*:div/*:bibl[not(@corresp)]">
   <xsl:value-of select="@xml:id"/><xsl:text>: </xsl:text>  
   <xsl:for-each select="*:author[position() ne last()]">
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>; </xsl:text>  
   </xsl:for-each>
   <xsl:value-of select="normalize-space(*:author[position() eq last()])"/>
 <xsl:text> : </xsl:text>
   <xsl:value-of select="normalize-space(*:title[1])"/><xsl:text>. </xsl:text>
   <xsl:value-of select="normalize-space(*:title[@type='sub'])"/><xsl:text>  (</xsl:text>
   <xsl:value-of select="normalize-space(*:eventName[@type='firstPerf']/*:name)"/><xsl:text> </xsl:text>
   <xsl:value-of select="normalize-space(*:eventName[@type='firstPerf']/@notAfter)"/><xsl:text>)
</xsl:text>
  </xsl:for-each> -->
</xsl:template>

</xsl:stylesheet>
