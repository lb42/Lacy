<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:t="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs t"
version="2.0">

<!-- just clone input -->


<xsl:template match="/ | @* | node()">
<xsl:copy>
<xsl:apply-templates select="@* | node()"/>
</xsl:copy>
</xsl:template>

<!-- and tweak ref/@n -->

<!-- '-bod'
'-gb'
'-ia'
'-lb'
'-osu'
'-uc'
'-ui'
'-uiu'-->
<xsl:template match="t:listRef/t:ref[not(@n)]">
<xsl:variable name="id" select="ancestor::t:bibl/@xml:id"/>
<xsl:copy>
<xsl:attribute name="n">
<xsl:choose>
<xsl:when test="contains(@target,'mdp')"><xsl:value-of select="concat($id,'-um')"/></xsl:when>
<xsl:when test="contains(@target,'hvd')"><xsl:value-of select="concat($id,'-hv')"/></xsl:when>
<xsl:when test="contains(@target,'-hv.')"><xsl:value-of select="concat($id,'-hv')"/></xsl:when>
<xsl:when test="contains(@target,'iau.')"><xsl:value-of select="concat($id,'-iau')"/></xsl:when>
<xsl:when test="contains(@target,'bl')"><xsl:value-of select="concat($id,'-bl')"/></xsl:when>
<xsl:when test="contains(@target,'google')"><xsl:value-of select="concat($id,'-gb')"/></xsl:when>
<xsl:when test="contains(@target,'osu.')"><xsl:value-of select="concat($id,'-osu')"/></xsl:when>
<xsl:when test="contains(@target,'uiug.')"><xsl:value-of select="concat($id,'-uiu')"/></xsl:when>
<xsl:when test="contains(@target,'uiuo.')"><xsl:value-of select="concat($id,'-uiu')"/></xsl:when>
<xsl:when test="contains(@target,'uiu.')"><xsl:value-of select="concat($id,'-uiu')"/></xsl:when>
<xsl:when test="contains(@target,'purl.ox.ac')"><xsl:value-of select="concat($id,'-bod')"/></xsl:when>
<xsl:when test="contains(@target,'uc1')"><xsl:value-of select="concat($id,'-uc')"/></xsl:when>
<xsl:when test="contains(@target,'uc2')"><xsl:value-of select="concat($id,'-uc')"/></xsl:when>

<xsl:when test="contains(@target,'-vpp')"><xsl:value-of select="concat($id,'-vpp')"/></xsl:when>
<xsl:when test="contains(.,'UW from')"><xsl:value-of select="concat($id,'-uw')"/></xsl:when>
<xsl:when test="contains(.,'UIU from')"><xsl:value-of select="concat($id,'-uiu')"/></xsl:when>
<xsl:when test="contains(.,'LB from')"><xsl:value-of select="concat($id,'-lb')"/></xsl:when>

<xsl:otherwise><xsl:value-of select="concat($id,'-XX')"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:apply-templates select="@*"/>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
