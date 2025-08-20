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

    <!-- counts number of titles per volume in each 15 year period      -->

    <xsl:template match="body">
        <xsl:text>'vol', 'before 1845', '1845-1854', '1855-1864','1865-1874','perf after 1875'
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
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter lt '1845']])"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter ge '1845' and @notAfter le '1854']])"/>
 <xsl:text>,</xsl:text>
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter ge '1855' and @notAfter le '1864']])"/>
            <xsl:text>,</xsl:text>   <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter ge '1865' and @notAfter le '1874']])"/>
           
            <xsl:text>,</xsl:text>   
            <xsl:value-of
                select="count(bibl[not(starts-with(@status,'replaced'))][eventName[@notAfter gt '1874' ]])"/>
       <!--     <xsl:text>,</xsl:text>
            <xsl:if test="not(position() = last())">
                <xsl:text>,</xsl:text>
            </xsl:if>-->
            <xsl:text>
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
