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

   <!-- plots number of titles per volume in each of 3 size categories -->
 
 <xsl:template match="body">     <xsl:text>['vol', 'pp &lt; 25', 'pp 25 - 49', 'pp 50+',
 </xsl:text>
         <xsl:for-each select="child::div[@type='volume']">
          <xsl:sort select="number(substring-before(@n,'/'))"/>
          <xsl:variable name="vol"><xsl:value-of select="substring-before(@n,'/')"/></xsl:variable>
            <xsl:variable name="volYr"><xsl:value-of select="substring-after(@n,'/')"/></xsl:variable>          
         <xsl:text>'</xsl:text> <xsl:value-of select="$vol"/> <xsl:text>', </xsl:text> 
         <xsl:value-of select="count(child::div[@type='work' and starts-with(@ana,'S') and not(bibl/@subtype='replaced')])"/><xsl:text>,</xsl:text>
          <xsl:value-of select="count(child::div[@type='work' and starts-with(@ana,'M') and not(bibl/@subtype='replaced')])"/><xsl:text>,</xsl:text>
          <xsl:value-of select="count(child::div[@type='work' and starts-with(@ana,'L') and not(bibl/@subtype='replaced')])"/>
                   <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
          <xsl:text>
</xsl:text>
         </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
