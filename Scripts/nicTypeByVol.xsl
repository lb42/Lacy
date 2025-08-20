<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output omit-xml-declaration="yes" method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//body"/>
    </xsl:template>

    <!--  -->

    <xsl:template match="body">
        <xsl:variable name="types"
            select="distinct-values(//bibl/tokenize(@type, '_')[last()-1])"/>

      <!--  <xsl:text>Vol </xsl:text>-->
        <xsl:value-of select="$types"/>
<xsl:text>
</xsl:text>
        <xsl:for-each select="div">
            <xsl:sort select="number(substring-before(@n, '/'))"/>
            <xsl:variable name="vol" select="substring-before(@n, '/')"/>
            <xsl:variable name="start" select="."/>
        <!--    <xsl:value-of select="$vol"/>
            <xsl:text>,</xsl:text>
    -->        <xsl:for-each select="$types">
                <xsl:variable name="t" select="concat('_',.)"/>
                <xsl:if test="string-length($t) gt 1">
                    <xsl:value-of
                        select="count($start/bibl[not(starts-with(@status, 'replaced'))][contains(@type, $t)])"
                    />
                </xsl:if>
                <xsl:if test="not(position() = last())">
                    <xsl:text>,</xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>
</xsl:text>

        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
