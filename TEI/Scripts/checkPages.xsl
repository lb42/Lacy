<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:math="http://www.w3.org/2005/xpath-functions/math"
exclude-result-prefixes="xs math"
version="3.0">
<xsl:template match="/">
<xsl:for-each select="//*:TEI">
<xsl:variable name='myId' select="@xml:id"/>
 <xsl:variable name="myVol" select="substring-before(substring-after(*:teiHeader/*:fileDesc/*:sourceDesc/*:bibl/*:title[@level='s'],'volume '),',')"/>
<xsl:variable name='myCount' select="count(*:text//*:pb)+1"/>
<xsl:variable name='yourCount' select="document('listPages.xml')/*:pages/*:pCount[@text eq $myId]/@count"/>
 <xsl:if test="$yourCount gt '1'">
<xsl:message><xsl:value-of select="concat($myVol,' ', $myId, ' : ', $myCount, ' pp,', $yourCount), ' pb'"/> </xsl:message>
</xsl:if>
 
 <xsl:apply-templates select="*:text//*:pb[preceding::*:pb]"/>
 
</xsl:for-each>
</xsl:template>
 
 <xsl:template match="*:pb">
  <xsl:variable name="me" select="@n" as="xs:integer"/>
  <xsl:variable name="bro" select='preceding::*:pb[1]/@n' as='xs:integer'/>
<!--  <xsl:message><xsl:value-of select="$me"/></xsl:message>
-->  <xsl:if test="$bro+1 ne $me">
   <xsl:message>Gap before p. <xsl:value-of select="$me"/></xsl:message>
  </xsl:if>
 </xsl:template>
</xsl:stylesheet>
