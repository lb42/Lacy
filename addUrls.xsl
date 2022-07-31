<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e" version="2.0">

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

   <xsl:template match="@target">
   <xsl:attribute name="target">   <xsl:value-of select="t:expandPrefix(.)"/></xsl:attribute>
   </xsl:template>
    
   <xsl:variable name="listPrefixDef" select="document('listPrefixDef.xml')"/>
       
    
    <xsl:function name="t:expandPrefix">
        <xsl:param name="ref"/>
        <xsl:message>Expanding <xsl:value-of select="$ref"/></xsl:message>
      <xsl:choose>
            <xsl:when test="starts-with($ref, 'http')">
                <xsl:value-of select="$ref"/>
            </xsl:when>
            <xsl:when test="contains($ref, ':')">
                <xsl:variable name="prefix" select="substring-before($ref, ':')"/>
                <xsl:variable name="matchPattern" select="$listPrefixDef//t:prefixDef[@ident = $prefix]/@matchPattern"/>
                <xsl:variable name="replacePattern" select="$listPrefixDef//t:prefixDef[@ident = $prefix]/@replacementPattern"/>
                <xsl:choose>
                    <xsl:when test="$matchPattern">
                        <xsl:message>Replacing <xsl:value-of select="$matchPattern"/> with <xsl:value-of select="$replacePattern"/>
                        </xsl:message>             
                        
                        
                        <xsl:value-of
                            select="replace(substring-after($ref, ':'), $matchPattern, $replacePattern)"
                        />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="concat('no matching prefix ', $prefix, ' found for ', $ref)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$ref"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>


