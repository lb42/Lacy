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


    
 <xsl:template match="body">     <xsl:text>['volYr', 'age &lt; 10', 'age 10 - 19', 'age 20+'],
 </xsl:text>
 <!-- <xsl:text>vol,volyr,undated,age0-2,age3-9,age10-19,age20-29,age30plus
    </xsl:text>-->
        <xsl:for-each select="div">
            
            <xsl:variable name="vol"><xsl:value-of select="substring-before(@n,'/')"/></xsl:variable>
            <xsl:variable name="volYr"><xsl:value-of select="substring-after(@n,'/')"/></xsl:variable>
            <xsl:variable name="limit0">
                <xsl:value-of select="$volYr - 3"/>
            </xsl:variable> 
            <xsl:variable name="limit1">
                <xsl:value-of select="$volYr"/>
            </xsl:variable>
            <xsl:variable name="limit2">
                <xsl:value-of select="$volYr - 10"/>
            </xsl:variable>
            <xsl:variable name="limit3">
                <xsl:value-of select="$volYr - 20"/>
            </xsl:variable>
            <xsl:variable name="limit4">
                <xsl:value-of select="$volYr - 30"/>
            </xsl:variable>
    
        <!-- 
         <xsl:value-of select="$vol"/>, <xsl:value-of select="$volYr"/><xsl:text>,</xsl:text>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date[not(@notAfter)])"/><xsl:text>,</xsl:text> 
           <xsl:message>Limit0 is <xsl:value-of 
                select="$limit0"/> (volyr -3)</xsl:message>
            <xsl:message>Limit1 is <xsl:value-of 
                select="$limit1"/> (volyr)</xsl:message>
            <xsl:message>Limit2 is <xsl:value-of 
                select="$limit2"/> (volyr-10)</xsl:message>
            <xsl:message>Limit3 is <xsl:value-of 
                select="$limit3"/> (volyr-20)</xsl:message>
            <xsl:message>Limit4 is <xsl:value-of 
                select="$limit4"/> (volyr-30)</xsl:message>

            <xsl:message>Considering    <xsl:value-of select="bibl/note[@type='firstPerf']/date/@notAfter"/></xsl:message>   
            <xsl:message>Accepting   in slot 1 <xsl:value-of select="bibl/note[@type='firstPerf']/date/@notAfter[. > $limit0  and $limit1 >= .]"/></xsl:message>
            <xsl:message>Accepting   in slot 2 <xsl:value-of select="bibl/note[@type='firstPerf']/date/@notAfter[. > $limit2  and $limit0 >= .]"/></xsl:message>
            <xsl:message>Accepting   in slot 3 <xsl:value-of select="bibl/note[@type='firstPerf']/date/@notAfter[. > $limit3  and $limit2 >= .]"/></xsl:message>
            <xsl:message>Accepting   in slot 4 <xsl:value-of select="bibl/note[@type='firstPerf']/date/@notAfter[. > $limit4  and $limit3 >= .]"/></xsl:message>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[. > $limit0 and $limit1 >= .])"/><xsl:text>,</xsl:text>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[. > $limit2 and $limit0 >= .])"/><xsl:text>,</xsl:text>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[. > $limit3 and $limit2 >= .])"/><xsl:text>,</xsl:text>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[. > $limit4 and $limit3 >= .])"/><xsl:text>,</xsl:text>
            <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[$limit4 > .])"/>
            -->
         <xsl:text>['</xsl:text> <xsl:value-of select="$volYr"/> <xsl:text>', </xsl:text> 
         <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[(. > $limit0 and $limit1 >= .) or (. > $limit2 and $limit0 >= .)])"/><xsl:text>,</xsl:text>
         <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[. > $limit3 and $limit2 >= .])"/><xsl:text>,</xsl:text>
         <xsl:value-of select="count(bibl/note[@type='firstPerf']/date/@notAfter[$limit3 >= .])"/><xsl:text>],
</xsl:text>
         </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
