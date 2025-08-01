<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs "
version="2.0">

<!-- extract required components of dracor header from catalogue.xml -->



<xsl:template match="sourceDesc">
<xsl:copy>
<xsl:apply-templates select="bibl"/>
</xsl:copy></xsl:template>



<xsl:template match="eventName[@type]">
<listEvent xmlns="http://www.tei-c.org/ns/1.0">
<event type="{@type}" notAfter="{@notAfter}" xmlns="http://www.tei-c.org/ns/1.0">
<desc><xsl:text>First performed at </xsl:text>
<xsl:value-of select="name"/><xsl:text> on </xsl:text>
<xsl:copy-of select="date"/></desc>
<xsl:apply-templates/>
</event>
<xsl:if test="following-sibling::note[@type='otherPerfs']">
<event type="otherPerfs" notAfter="{date/@notAfter}">
<desc><xsl:text>Other performances at </xsl:text>
<xsl:value-of select="name"/><xsl:text> on </xsl:text>
<xsl:copy-of select="date"/></desc></event>
</xsl:if>

</listEvent>
</xsl:template>

<!-- just clone input -->




<xsl:template match="/ | @* | node()">
<xsl:copy>
<xsl:apply-templates select="@* | node()"/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
