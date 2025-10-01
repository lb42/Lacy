<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:t="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs t"
version="2.0">

<xsl:variable name="theId" select="/TEI/@xml:id"/>
<xsl:variable name="theFile" select="concat('/home/lou/Public/Lacy/TEI/Partix/',
  $theId, '.xml')"/>

<xsl:template match="t:sp">
<xsl:variable name='spkr' select="t:speaker"/>
 <xsl:variable name="pers" select="ancestor::TEI/teiHeader/profileDesc/t:particDesc/t:listPerson/t:person[t:persName[@type='spkr'] = $spkr]"/>
 <xsl:copy>
<xsl:attribute name="who">
<!-- use @n if it's there -->
<xsl:choose>
 <xsl:when test="$pers/@n">
  <xsl:value-of select="concat('#',$pers/@n)"/>
 </xsl:when>
 <xsl:otherwise>
  <xsl:value-of select="concat('#',$pers/@xml:id)"/>
 </xsl:otherwise>
</xsl:choose>
 
</xsl:attribute>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>


<!-- otherwise just clone input -->


<xsl:template match="/ | @* | node()">
<xsl:copy>
<xsl:apply-templates select="@* | node()"/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
