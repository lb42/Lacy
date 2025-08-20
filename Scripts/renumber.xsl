<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t " version="2.0">
 
 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 
 <xsl:param name="newId"/>
 
 <xsl:template match="TEI">
  <xsl:copy>
   <xsl:attribute name="xml:id" select="$newId"/>
  <xsl:apply-templates/>
  </xsl:copy>  
 </xsl:template>

<xsl:template match="sourceDesc/bibl[@type='source']">
 <xsl:apply-templates select="document('../catalogue.xml')//div/bibl[@xml:id eq $newId]"/>
</xsl:template>
 
<xsl:template match="bibl/@xml:id"/>
 
<xsl:template match="revisionDesc">
 <xsl:copy>
  <change xmlns="http://www.tei-c.org/ns/1.0" when="2025-01-14">Renumbering</change>
  <xsl:apply-templates/>
 </xsl:copy>
</xsl:template> 
 <xsl:template match="/ | @* | node()" >
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>