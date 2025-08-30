<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:a="http://www.abbyy.com/FineReader_xml/FineReader10-schema-v1.xml"
 xmlns:f="http://expath.org/ns/file"
 xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs a t" version="2.0">

  <!-- adds bibl for TEI versions according to old catalogue -->
  

 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>


 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates/>
 </xsl:template>

<xsl:template match="t:listEvent">
 <xsl:variable name="id" select="parent::t:div[@type='work']/@xml:id"/>
<xsl:variable name="url" select="concat('https://lb42.github.io/Lacy/',$id,'.html')"/>
 <xsl:variable name='file' select="concat('/home/lou/Public/',substring-after($url,'https://'))"/>
 <xsl:if test="document('/home/lou/Public/Lacy/oldCatalogue.xml')//t:bibl[@xml:id eq $id and contains(@status,'TEI')]">
 <xsl:message><xsl:value-of select="$id"/><xsl:text> is in TEI </xsl:text></xsl:message>
  <xsl:if test="not(f:exists($file))">
   <xsl:message>... but  <xsl:value-of select="$file"/> not found</xsl:message>
  </xsl:if>
  
  <bibl xmlns="http://www.tei-c.org/ns/1.0" type="digitalSource" subtype="TEI"><ref target="{$url}">TEI</ref> </bibl>
 </xsl:if>
 <listEvent xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:apply-templates/>
 </listEvent>
</xsl:template>
 

</xsl:stylesheet>
