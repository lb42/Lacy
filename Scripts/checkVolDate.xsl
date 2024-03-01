<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes"/>
  <!-- checks that div/@n indicates the latest perf date in its contents -->
 <xsl:template match="/">
  <xsl:for-each select="//div">
   <xsl:variable name="v1">  <xsl:value-of select="substring-after(@n,'/')"/></xsl:variable>
   <xsl:variable name="vList"><xsl:value-of select="bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter"/></xsl:variable>
   <xsl:variable name="v2">  <xsl:value-of select="max(bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter)"/></xsl:variable>
   <xsl:if test="$v1 ne $v2">
   <xsl:value-of select="@n"/>
   <xsl:text>     </xsl:text>
    <xsl:value-of select="max(bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter)"/>
    <xsl:text>     </xsl:text>
    <xsl:value-of select="$vList"/><xsl:text>
</xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
