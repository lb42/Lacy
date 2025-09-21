<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:template match="/">
        <xsl:variable name="root" select="t:TEI"/>

        <xsl:for-each select="distinct-values(//t:actor[@sex = 'F'])">
            <xsl:sort select="tokenize(.)[last()]"/>
            <!--  <xsl:message>   <xsl:value-of select="."/>
            </xsl:message>-->
            <xsl:value-of select="normalize-space(upper-case(.))"/>
            <xsl:variable name="myActor" select="."/>
            <xsl:for-each select="$root//t:castItem/t:actor[matches(., $myActor)]">
                <xsl:text> as </xsl:text>
                <xsl:value-of select="preceding-sibling::t:role[1]"/>
                <xsl:text> in "</xsl:text>
                <xsl:value-of
                    select="normalize-space(ancestor::*:TEI[1]/*:teiHeader/*:fileDesc/*:titleStmt/*:title[1])"/>
                <xsl:apply-templates
                    select="ancestor::*:TEI[1]/*:teiHeader/*:fileDesc/*:sourceDesc/*:bibl[@type = 'source']/*:eventName"/>

                <xsl:text>)
</xsl:text>
            </xsl:for-each>

        </xsl:for-each>

    </xsl:template>

    <xsl:template match="t:eventName">
        <xsl:text>" </xsl:text>
        <xsl:value-of select="ancestor::t:TEI[1]/@xml:id"/>
        <xsl:text> (First performed  </xsl:text>
        <xsl:value-of select="normalize-space(t:name[1])"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@notAfter"/>
    </xsl:template>
</xsl:stylesheet>
