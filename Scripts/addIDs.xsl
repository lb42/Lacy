<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">

<xsl:template match="*:div[@type='xref']">
 <xref xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:copy-of select="*:p"/>
 </xref>
</xsl:template>

 <xsl:template match="*:div">
  <xsl:copy>
   <xsl:variable name="id">
    <xsl:number value="count(preceding-sibling::*:div)" format='001'/>
   </xsl:variable>
   <xsl:attribute name="xml:id">
    <xsl:value-of select="concat('P',$id)"/>
   </xsl:attribute>
   <xsl:attribute name="n">
    <xsl:value-of select="replace(@n,',\s*$','')"/>
   </xsl:attribute>
   <xsl:apply-templates/>
  </xsl:copy>
 </xsl:template> 
  <!-- just clone input -->
  

  
  <xsl:template match="/ | @* | node()">
   <xsl:copy>
    <xsl:apply-templates select="@* | node()"/>
   </xsl:copy>
  </xsl:template>

</xsl:stylesheet>