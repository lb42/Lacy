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

    <!-- counts number of titles per volume in each 20 year period      -->

    <xsl:template match="body">
        <xsl:text>'vol', 'before 1820', '1821-1840', '1841-1860','1861-1880','perf after 1880'
 </xsl:text>
        <xsl:for-each select="div">
            <xsl:sort select="number(substring-before(@n, '/'))"/>
            <xsl:variable name="vol">
                <xsl:value-of select="substring-before(@n, '/')"/>
            </xsl:variable>
            <xsl:variable name="volYr">
                <xsl:value-of select="substring-after(@n, '/')"/>
            </xsl:variable>
            <xsl:text>'</xsl:text>
            <xsl:value-of select="$vol"/>
            <xsl:text>', </xsl:text>
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter le '1820']])"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter gt '1820' and @notAfter le '1840']])"/>
 <xsl:text>,</xsl:text>
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter gt '1840' and @notAfter le '1860']])"/>
            <xsl:text>,</xsl:text>   <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter gt '1860' and @notAfter le '1880']])"/>
           
            <xsl:text>,</xsl:text>   
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter gt '1880' ]])"/>
       <!--     <xsl:text>,</xsl:text>
            <xsl:if test="not(position() = last())">
                <xsl:text>,</xsl:text>
            </xsl:if>-->
            <xsl:text>
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
