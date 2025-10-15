<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">

 
 <!-- adds links to formatted version of TEI titles in authorList  -->

<xsl:param name="webRoot">'https://lb42.github.io/Lacy'</xsl:param>
 <xsl:template match="*:bibl/*:ref[starts-with(@target, 'lacy:')]">
  <xsl:variable name="theId" select="substring-after(@target, ':')"/>
  <xsl:choose>
   <xsl:when
    test="document('/home/lou/Public/Lacy/catalogue.xml')//t:div[@type = 'work' and @xml:id = $theId and @subtype = 'TEI']">
    <ref xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:attribute name="target">
      <xsl:value-of select="concat('$webRoot', $theId, '.html')"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </ref>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:function name="t:isTEI">
  <xsl:param name="id"/>

  <xsl:for-each
   select="document('/home/lou/Public/Lacy/catalogue.xml')//t:div[@type = 'work' and @xml:id = $id and @subtype = 'TEI']">
   <xsl:message><xsl:value-of select="$id"/> Bing!</xsl:message>
  </xsl:for-each>

  <xsl:value-of
   select="count(document('/home/lou/Public/Lacy/catalogue.xml')//t:div[@type = 'work' and @xml:id = $id and @subtype = 'TEI']) gt 0"
  />
 </xsl:function>

 <!-- just clone input -->


 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
