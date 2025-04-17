<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t"
    version="2.0">

    <!-- transfers data from lacyEntries.xml file into the catalogue -->


    <xsl:param name="extraFile">../lacyEntries.xml</xsl:param>

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="body/div/bibl">
        <xsl:variable name="myId" select="@xml:id"/>
        <xsl:variable name="nType"
            select="document($extraFile)//*:entry[@matches = $myId]/@type"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="ana" select="@type"/>
            <xsl:attribute name="type">
    <xsl:choose>
                    <xsl:when test="$nType">
                        <xsl:value-of select="substring-before($nType,'.')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="contains(@type,'_Com')">C</xsl:when>
                            <xsl:when test="contains(@type,'_Farce')">F</xsl:when>
                            <xsl:when test="contains(@type,'_Drama')">D</xsl:when>
                            <xsl:when test="contains(@type,'_Trag')">T</xsl:when>
                            <xsl:when test="contains(@type,'_Oper')">O</xsl:when>
                            <xsl:when test="contains(@type,'_Burle')">Bsq</xsl:when>
                            <xsl:when test="contains(@type,'_Extrav')">Ext</xsl:when>
                          <xsl:otherwise>
                              <xsl:text>xxx</xsl:text>
                              
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:message>No match for <xsl:value-of select="$myId"/></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="substring-after($nType,'.') or ($nType eq 'xxx')">
                <xsl:attribute name="subtype">
                    <xsl:value-of select="$nType"/>
                </xsl:attribute>
            </xsl:if>
            
            <xsl:apply-templates/>

        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
