<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:lb ="http://lb42.github.io"
 exclude-result-prefixes="xs"
 version="3.0">
 
 <!-- add dracor name to each catalogue entry
      reading them from dracNames.xml or making them up as nessa
 -->
  
 <xsl:template match="*:div[@type='work']">
  <xsl:variable name="lacyNum" select="@xml:id"/>
 <xsl:variable name="dracName" select="document('/home/lou/Public/Lacy/dracNames.xml')//*:dracName[@corresp eq $lacyNum]"/>
  <!-- we arbitrarily choose the first author -->
<xsl:variable name="auth" select="substring-before(*:bibl[@type='originalSource']/*:author[1],',')"/>
<xsl:variable name="titl" select="*:bibl[@type='originalSource']/*:title[@type='main']/@n"/>
 <xsl:copy>
 <xsl:attribute name="n">
<xsl:choose><xsl:when test="$dracName ne ''">
   <xsl:value-of select="$dracName"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="concat(lower-case($auth),'-',replace($titl,'\.',''))"/>
  </xsl:otherwise></xsl:choose>  
 </xsl:attribute>
  <xsl:apply-templates select="@*"/>
 <xsl:apply-templates/>
</xsl:copy>

 </xsl:template>
 
 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 

</xsl:stylesheet>
