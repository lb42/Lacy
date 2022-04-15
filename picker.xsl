<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:param name="vol">31</xsl:param>
    <xsl:template match="/">
        <xsl:apply-templates select="//*:div[@type='volume']"/>
    </xsl:template>
    <xsl:template match="*:div">
        <xsl:text>VOLUME </xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="*:bibl">
        <xsl:value-of select="count(preceding::*:bibl)+1"/>
        <xsl:text> </xsl:text><xsl:value-of select="@n"/>
    </xsl:template>
</xsl:stylesheet>