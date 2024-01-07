<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:for-each select="//*:bibl//*:ref[contains(.,'VPP original')]">   
   <xsl:variable name="from">
    <xsl:value-of select="substring-after(@target,'local:')"/> 
   </xsl:variable>
   <xsl:variable name="to">
    <xsl:value-of select="substring-after(substring-after(@target,'/'),'/')"/> 
   </xsl:variable>
   
   <xsl:value-of select="concat('cp ',$from,' VPP-pdf/', $to)"/>
   <xsl:text>
</xsl:text>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
