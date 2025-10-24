<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:t="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs t"
version="2.0">

<xsl:variable name="theId" select="/TEI/@xml:id"/>

<!-- various pre-release tidyups -->

<xsl:template match="titlePage">
<xsl:copy><xsl:apply-templates select="*"/></xsl:copy>
</xsl:template>

<xsl:template match="t:titlePart[not(@type)]">
<!--<xsl:message>pos: <xsl:value-of select="position()"/> <xsl:value-of select="."/></xsl:message>
-->
<xsl:variable name='type'>
<xsl:choose>
<xsl:when test="position() eq 1">main</xsl:when>
<xsl:when test="starts-with(normalize-space(.),'Or')">alt</xsl:when>
<xsl:when test="position() eq 2 and starts-with(normalize-space(.),'A')">sub</xsl:when>
<xsl:when test="contains(.,'Act') or contains(.,'act')">sub</xsl:when>
<xsl:when test="contains(.,'erform')">performance</xsl:when>
<xsl:when test="contains(.,'Adapted') or contains(., 'Founded')">source</xsl:when>
<xsl:otherwise>desc</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<!--<xsl:message> type= <xsl:value-of select="$type"/></xsl:message>-->
<xsl:copy>
<xsl:attribute name="type" select="$type"/>
<xsl:value-of select="."/>
</xsl:copy>
</xsl:template>

<xsl:template match="actor/@ana">
<xsl:attribute name="sex"><xsl:value-of select="substring-after(.,'#')"/></xsl:attribute></xsl:template>

<xsl:template match="role[matches(.,'[A-Z][A-Z]+')]">
<role xmlns="http://www.tei-c.org/ns/1.0" gender="{@gender}">
<xsl:for-each select="tokenize(.)">
<xsl:value-of select="substring(.,1,1)"/>
<xsl:value-of select="lower-case(substring(.,2))"/>
<xsl:text> </xsl:text>
</xsl:for-each>
</role></xsl:template>


<!-- otherwise just clone input -->


<xsl:template match="/ | @* | node()">
<xsl:copy>
<xsl:apply-templates select="@* | node()"/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
