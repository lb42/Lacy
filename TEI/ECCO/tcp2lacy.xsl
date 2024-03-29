<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t"
    version="2.0">
    <xsl:param name="lacyNo">L0000</xsl:param>

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="TEI">
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$lacyNo"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>


    <!-- simplify text level tagging -->

    <xsl:template match="@rendition"/>
    <xsl:template match="t:g[starts-with(@ref,'char:EOL')]"/>
    <xsl:template match="t:g[@ref = 'char:punc']">
        <xsl:text>—</xsl:text>
    </xsl:template>
    <xsl:template match="t:seg[@rend = 'decorInit']">
        <xsl:apply-templates/>
    </xsl:template>

<xsl:template match="t:abbr">
    <xsl:value-of select="."/>
</xsl:template>
    <xsl:template match="t:gap">
        <xsl:value-of select="t:desc"/>
    </xsl:template>

    <xsl:template match="t:gap[@reason = 'duplicate']"/>

    <!-- header changes -->

    <xsl:template match="t:publicationStmt">
        <publicationStmt xmlns="http://www.tei-c.org/ns/1.0">
            <distributor>Privately published on the Lacy Website</distributor>
            <idno>
                <xsl:value-of select="$lacyNo"/>
            </idno>
        </publicationStmt>
    </xsl:template>

    <xsl:template match="t:sourceDesc">
        <sourceDesc xmlns="http://www.tei-c.org/ns/1.0">
            <p>Retagged and re-edited from ECCO version checked against UM or BL original for Lacy
                edition. </p>
            <p>Details of the ECCO source are available from ECCO.</p>
        </sourceDesc>
    </xsl:template>

    <xsl:template match="t:encodingDesc"/>

    <xsl:template match="t:revisionDesc">
        <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
            <change when="2024-02-12">Header replaced</change>
        </revisionDesc>
    </xsl:template>

    <!-- front matter changes -->

    <xsl:template match="front/div">
        <xsl:choose>
            <xsl:when test="@type = 'title_page'">
                <titlePage xmlns="http://www.tei-c.org/ns/1.0">
                    <titlePart>
                        <xsl:value-of select="p[1]"/>
                    </titlePart>
                    <byline>
                        <xsl:value-of select="p[2]"/>
                    </byline>
                    <docImprint>
                        <xsl:value-of select="p[3]"/>
                    </docImprint>
                </titlePage>
            </xsl:when>
            <xsl:when test="@type = 'dramatis_personae'">
                <castList xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </castList>
            </xsl:when>
            <xsl:when test="@type eq 'prologue' or @type eq 'dedication' or @type eq 'preface'">
                <div type="liminal" subtype="{@type}" xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Unexpected div type</xsl:message>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="t:div[@type = 'dramatis_personae']/t:list">
        <xsl:for-each select="t:item">
            <castItem xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:choose>
                    <xsl:when test="t:label">
                        <role gender="M">
                            <xsl:value-of select="t:label"/>
                        </role>
                        <actor sex="M">
                            <xsl:apply-templates select="text()"/>
                        </actor>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
               </castItem>

        </xsl:for-each>
    </xsl:template>

    <!-- body changes -->
    <xsl:template match="t:floatingText">
        <quote xmlns="http://www.tei-c.org/ns/1.0" type="{@type}">
            <xsl:apply-templates/>
        </quote>
    </xsl:template>

    <xsl:template match="t:floatingText/t:body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:opener">
        <seg xmlns="http://www.tei-c.org/ns/1.0" type="opener">
            <xsl:apply-templates/>
        </seg>
    </xsl:template>
    <xsl:template match="t:closer">
        <seg xmlns="http://www.tei-c.org/ns/1.0" type="closer">
            <xsl:apply-templates/>
        </seg>
    </xsl:template>
    <xsl:template match="t:signed">
        <hi xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
</xsl:stylesheet>
