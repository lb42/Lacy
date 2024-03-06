<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <xsl:variable name="root" select="."/>
        <xsl:for-each select="//*:entry[contains(.,'See ')]">
        <xsl:variable name="myTitle" select="*:title[1]"/>
        <xsl:message><xsl:value-of select="normalize-space(.)"/>
<xsl:apply-templates select="$root//*:entry[starts-with(*:title[1],$myTitle)]"/>
    </xsl:message></xsl:for-each></xsl:template>
</xsl:stylesheet>