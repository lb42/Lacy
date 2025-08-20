<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:a="http://www.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml"
 xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs a t" version="2.0">

  <!-- adds an @type derived from the catalog metadata to the text -->
  

 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>


 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates/>
 </xsl:template>

<xsl:template match="t:text">
 <xsl:variable name="id" select="parent::t:TEI/@xml:id"/>
 <xsl:variable name="types" select="tokenize(document('/home/lou/Public/Lacy/catalogue.xml')//t:div/t:bibl[@xml:id eq $id]/@type,'_')"/>
 <xsl:message><xsl:value-of select="$id"/><xsl:text> : </xsl:text><xsl:value-of select="$types"/></xsl:message>
 <xsl:copy>
 <xsl:attribute name="type" select="$types[last()]"/>
 <xsl:apply-templates/></xsl:copy>
</xsl:template>
 

</xsl:stylesheet>
