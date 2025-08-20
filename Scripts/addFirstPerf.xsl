<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t"
    version="2.0">

    <!-- copy @when from indicated Nicoll entry to catalogue -->

<xsl:param name="extraFile">/home/lou/Public/Lacy/Nicoll/allEntries.xml</xsl:param>
     <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="body/div/bibl[@corresp]/note[@type='firstPerf']/date">
        <xsl:variable name="nicId" select="substring-after(ancestor::bibl/@corresp,':')"/>
        <xsl:variable name="nicWhen"
            select="document($extraFile)//*:entry[@xml:id  = $nicId]/@when"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="when" select="$nicWhen"/>
                <xsl:apply-templates/>
        </xsl:copy>
     <xsl:if test="string-length($nicWhen) eq 0"><xsl:message>No Nicoll date for <xsl:value-of select="ancestor::bibl/@xml:id"/> </xsl:message></xsl:if>
     <xsl:if test="not(starts-with($nicWhen,@notAfter))">
      <xsl:message><xsl:value-of select="concat(ancestor::bibl/@xml:id,' has nicoll date ', $nicWhen, ' but lacy date ', normalize-space(.))"/></xsl:message>
     </xsl:if> 
     
    </xsl:template>
 
 

</xsl:stylesheet>
