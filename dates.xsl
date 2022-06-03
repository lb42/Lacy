<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output omit-xml-declaration="yes" method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//body"/>
    </xsl:template>
    <xsl:template match="body">
        <xsl:for-each select="div">
           <xsl:value-of select="@n"/>, <xsl:value-of select="@notBefore"/><xsl:text>,</xsl:text>
            <xsl:for-each select="bibl/note[@type='firstPerf']/date">
                <xsl:value-of select="@when"/><xsl:text>,</xsl:text></xsl:for-each>
            <xsl:value-of select="avg(bibl/note[@type='firstPerf']/date/@when[. gt '0000'])"/><xsl:text>
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>