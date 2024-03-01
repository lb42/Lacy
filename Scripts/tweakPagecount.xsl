<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">

<!-- adds a code for size to existing @type values on bibl --> 
  
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="div/bibl">

   <bibl xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="@*"/>
    
 <!--   <xsl:message><xsl:value-of select="concat('/',substring-before(note[@type='extent'],' pp'),'/=',number(substring-before(note[@type='extent'],' pp')))"/></xsl:message>
-->  
   <xsl:variable name="pp">
  <xsl:value-of select="number(substring-before(note[@type='extent'],' pp'))" />
   </xsl:variable>
  
  <xsl:variable name="size">
   <xsl:choose>
    <xsl:when test="$pp &lt;= 25">S</xsl:when>
    <xsl:when test="$pp &lt;= 50">M</xsl:when>
   <xsl:otherwise>L</xsl:otherwise>
   </xsl:choose>
   
  </xsl:variable>
    <xsl:variable name="sz" select="substring-before(@type,'_')"/>
   
    <xsl:if test="$sz ne $size">
     <xsl:message><xsl:value-of select="concat('Changing ', $sz,' to ',$size,' on ',@xml:id)"/></xsl:message>  
   <xsl:attribute name="type">
    <xsl:value-of select="concat($size,'_',@type)"/>
   </xsl:attribute>
    </xsl:if>
    
    
   <xsl:apply-templates/>
  
  </bibl>
 </xsl:template>

</xsl:stylesheet>
