<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <!-- produces a person list from authors in catalogue 
 (with help from mdh)  jan 2024 -->
 
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <authorList>
   <xsl:variable name="authorsNormalized" as="xs:string*"
    select="//t:div/t:bibl/descendant::t:author/normalize-space(replace(.,'[\[\]]',''))"/>  
   <xsl:for-each select="distinct-values($authorsNormalized)">
    <xsl:sort select="."/>
    <xsl:variable name="a" as="xs:string" select="."/>
    <xsl:variable name="f" select="count($authorsNormalized[. eq $a])"/> 
   <xsl:variable name="occurrences"><xsl:value-of select="$context//t:author[contains(normalize-space(.),$a)]/parent::t:bibl/@xml:id"/></xsl:variable>
   
   <xsl:comment> <xsl:value-of select="$a"/> occurs <xsl:value-of select="$f"/> times
</xsl:comment>
   
   <xsl:variable name="id">
     <xsl:number value="position()" format="001"/>
   </xsl:variable>  
   <person role="author" xml:id="{concat('W',$id)}">
  <xsl:attribute name="freq">
   <xsl:value-of select="$f"/>
  </xsl:attribute>
    <xsl:attribute name="lacyTitles">
     <xsl:choose>
      <xsl:when test="$f &lt; 6">few</xsl:when><!-- low frequency -->
      <xsl:when test="$f &lt; 20">some</xsl:when><!-- medium frequency -->
      <xsl:when test="$f &lt; 50">many</xsl:when><!-- prolific -->
      <xsl:otherwise>over50</xsl:otherwise><!-- ott -->
     </xsl:choose>
    </xsl:attribute>
   <persName> <xsl:value-of select="$a"/></persName>
    <persName resp="Nicoll"><xsl:value-of select="upper-case($a)"/></persName>
   <writerOf><xsl:value-of select="$occurrences"/></writerOf> 
   </person><xsl:text>
</xsl:text>
   </xsl:for-each>
</authorList> </xsl:template>
</xsl:stylesheet>