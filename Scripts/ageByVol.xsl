<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output omit-xml-declaration="yes" method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//body"/>
    </xsl:template>

    
 <xsl:template match="body">     

  <xsl:text>['vol', 'age &lt; 5', 'age 5 - 19', 'age 20+'],
 </xsl:text>
         <xsl:for-each select="div">
         <xsl:sort select="number(substring-before(@n,'/'))"/>
            <xsl:variable name="vol"><xsl:value-of select="substring-before(@n,'/')"/></xsl:variable>
            <xsl:variable name="volYr"><xsl:value-of select="substring-after(@n,'/')"/></xsl:variable>
            <xsl:variable name="low1" select="$volYr - 5"/>
            <xsl:variable name="low2" select="$volYr - 20"/>
            <xsl:variable name="low3" select="1700"/>

         <xsl:text>['</xsl:text> <xsl:value-of select="$vol"/> <xsl:text>', </xsl:text> 
         <xsl:value-of select="count(bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter[. >= $low1 and . &lt;= $volYr])"/><xsl:text>,</xsl:text>
         <xsl:value-of select="count(bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter[. >= $low2  and . &lt;= $low1])"/><xsl:text>,</xsl:text>
         <xsl:value-of select="count(bibl[not(@status='replaced')]/note[@type='firstPerf']/date/@notAfter[. >= $low3 and . &lt;= $low2])"/><xsl:text>]</xsl:text>
          <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
          <xsl:text>
</xsl:text>
         </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
