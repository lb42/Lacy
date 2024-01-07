<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:a="http://www.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml"
 xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs a t" version="2.0">

 

 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>

 <xsl:variable name="inputFile">
  <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
 </xsl:variable>

 <xsl:variable name="idno">
  <xsl:value-of select="substring-before($inputFile, '.')"/>
 </xsl:variable>

 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates/>
 </xsl:template>

<xsl:template match="t:TEI">
 <xsl:copy>
 <xsl:attribute name="xml:id" select="$idno"/>
 <xsl:apply-templates/></xsl:copy>
</xsl:template>
 

</xsl:stylesheet>
