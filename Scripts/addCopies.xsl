<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">

<!-- adds local copy details from file copies.xml--> 
  
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="div/bibl">

   <bibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>  
    <xsl:variable name="myId" select="@xml:id"/>
    <xsl:variable name="myVol" select="document('copies.xml')/*:copies/*:cc[@id=$myId]/@vol"/>
    <xsl:apply-templates/>
    <xsl:variable name="files"><xsl:value-of select="document('copies.xml')/*:copies/*:cc[@id=$myId]"/></xsl:variable>
  <note type="localCopies">
  <xsl:for-each select="tokenize($files)">
   <ident>
    <xsl:value-of select="concat($myVol,'/',$myId,'/',.)"/>
   </ident><xsl:text>
</xsl:text>
  </xsl:for-each>
  </note>
  </bibl>
 </xsl:template>

</xsl:stylesheet>
