<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:math="http://www.w3.org/2005/xpath-functions/math"
exclude-result-prefixes="xs math"
version="3.0">
<xsl:template match="/">
<xsl:for-each select="//*:TEI">
<xsl:variable name='myId' select="@xml:id"/>
<xsl:variable name='myCount' select="count(*:text//*:pb)"/>
<xsl:variable name='yourCount' select="document('listPages.xml')/*:pages/*:pCount[@text eq $myId]/@count"/>
<xsl:message><xsl:value-of select="concat($myId, ' : ', $myCount, ' ', $yourCount)"/> </xsl:message>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
