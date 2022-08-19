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
            <xsl:variable name="vol"><xsl:value-of select="substring-before(@n,'/')"/></xsl:variable>
            <xsl:variable name="volYr"><xsl:value-of select="substring-after(@n,'/')"/></xsl:variable>
           <xsl:value-of select="$vol"/>, <xsl:value-of select="$volYr"/><xsl:text>,</xsl:text>
            <xsl:for-each select="bibl/note[@type='firstPerf']/date">
               <!-- <xsl:variable name="interval">
              -->      <xsl:value-of select="$volYr - @when"/>
                <!--</xsl:variable>-->
               <!-- <xsl:value-of select="concat($interval,':', @when)"/>--><xsl:text>,</xsl:text>
            
            </xsl:for-each>
           <xsl:text>
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>