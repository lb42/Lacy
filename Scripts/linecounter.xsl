<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
 <xsl:output omit-xml-declaration="yes"/>
 
 <xsl:template match="/">
  
  <xsl:text>
 ----------------------------
</xsl:text>
  <xsl:value-of select="/TEI/@xml:id"/><xsl:text>: </xsl:text>
  <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author[1]"/><xsl:text>: </xsl:text>
  <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title[1]"/>
  <xsl:apply-templates select="/TEI/text/body"/>
 </xsl:template>
 
 <xsl:template match="*:body">
  <xsl:variable name="context" select="."/>
  <xsl:for-each select="distinct-values(//*:sp/*:speaker)">
   <xsl:sort/>
   <xsl:variable name="this" select="."/>
   <xsl:text>
"</xsl:text>
   <xsl:value-of select="."/>
   <xsl:text>" ... </xsl:text>
   <xsl:value-of
    select="count($context//*:sp/(*:l | *:p)[preceding-sibling::*:speaker[1] eq $this])"/>
   <xsl:text>: </xsl:text>
   <xsl:variable name="everyLine">
    <xsl:value-of
     select="$context//*:sp/(*:l | *:p)[preceding-sibling::*:speaker[1] eq $this]/text()"/>
   </xsl:variable>

   <xsl:value-of
    select="string-length(normalize-space($everyLine)) - string-length(translate(normalize-space($everyLine), ' ', '')) + 1"
   />
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
