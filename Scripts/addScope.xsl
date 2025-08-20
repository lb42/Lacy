<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 exclude-result-prefixes="xs math"
 version="3.0">
 
<!-- add biblScope-->
 
 <xsl:template match="*:extent[contains(.,'(UM')]">
  <extent xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="substring-before(.,'(UM')"/></extent>
  <biblScope unit="volume" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="substring-before(ancestor::*:bibl/@n, '.')"/></biblScope>
  <biblScope unit="pages" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="substring-before(substring-after(.,'copy:'),')')"/></biblScope>
 </xsl:template> 
 
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>