<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:t="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs t"
version="2.0">

<xsl:variable name="theId" select="/TEI/@xml:id"/>
 <xsl:variable name="today">
  <xsl:value-of select="format-date(current-date(),
   '[Y0001]-[M01]-[D01]')"
  />
 </xsl:variable>

<xsl:template match="t:pb">
 <xsl:variable name="n">
  <xsl:number value="@n" format="001"/>
 </xsl:variable>
 <xsl:copy>
  <xsl:attribute name="n" select="@n"/>
<xsl:attribute name="facs">
  <xsl:value-of select="concat('../Pages/',$theId, '/', $theId,'-',$n,'.jpg')"/>
</xsl:attribute>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

<xsl:template match="t:revisionDesc">
 <xsl:copy>
   <change xmlns="http://www.tei-c.org/ns/1.0" when="{$today}">Add @facs links to page images</change>
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
