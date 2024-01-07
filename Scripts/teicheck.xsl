<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:output omit-xml-declaration="yes" method="text"/>
 
 <xsl:template match="/">
  <xsl:for-each select="document('TEI/driver.xml')//*:include">
   <xsl:message><xsl:value-of select="@href"/></xsl:message>
   <xsl:variable name="idno" select="substring-before(@href,'.xml')"/>
   <xsl:
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>