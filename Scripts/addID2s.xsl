<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">

 <xsl:template match="*:bibl[*:ref]">
  <xsl:copy>
   <xsl:attribute name="xml:id">
 <!--   <xsl:value-of select="substring-before(*:ref[1],'.pdf')"/>
-->   <xsl:value-of select="*:ref[1]"/>
   </xsl:attribute>
   <xsl:apply-templates select="@*"/>
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