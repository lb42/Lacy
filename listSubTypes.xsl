<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output omit-xml-declaration="yes"/>
  
        <xsl:template match="/">
            <xsl:variable name="context" select="."/>
    
            <xsl:for-each select="distinct-values(//*:bibl/@type)">
             <xsl:sort/>
                 <xsl:variable name="typeVal" select="."/>
                 
                <xsl:value-of select="concat($typeVal,
                    '  (' , count($context//*:bibl[@type=$typeVal]),')')"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
            <xsl:for-each select="distinct-values(//*:bibl/@subtype)">
                <xsl:sort/>
                <xsl:variable name="typeVal" select="."/>
                
                <xsl:value-of select="concat($typeVal,
                    '  (' , count($context//*:bibl[@subtype=$typeVal]),')')"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:template>
        
    
</xsl:stylesheet>