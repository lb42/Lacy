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
  <listPerson>
   <xsl:variable name="chars2zap">["\[\]]</xsl:variable>
   <xsl:variable name="authorsNormalized" as="xs:string*"
    select="//t:div/t:bibl/descendant::t:author/normalize-space(replace(.,$chars2zap,''))"/>  
   <xsl:for-each select="distinct-values($authorsNormalized)">
    <xsl:sort select="."/>
    <xsl:if test="string-length(.) gt 1">
    <xsl:variable name="a" as="xs:string" select="."/>
    <xsl:variable name="f" select="count($authorsNormalized[. eq $a])"/> 
     <xsl:variable name="occurrences"><xsl:value-of select="$context//t:author[contains(normalize-space(replace(.,$chars2zap,'')),$a)]/parent::t:bibl/@xml:id"/></xsl:variable>
   
 <!--  <xsl:comment> <xsl:value-of select="$a"/> occurs <xsl:value-of select="$f"/> times</xsl:comment>
 -->    <xsl:variable name="nicNums" select="$context//t:div/t:bibl[contains($occurrences,@xml:id)]/@corresp"/>
       <xsl:variable name="nicNo" select="substring-after($nicNums[position() eq 1],':')"/>
<!--     <xsl:comment>Nicno <xsl:value-of select="$nicNo"/></xsl:comment>
-->     <xsl:variable name="nicName"><xsl:value-of 
      select="document('/home/lou/Public/Lacy/Nicoll/allEntries.xml')//(*:entry|*:entryFrag)[@xml:id=$nicNo]/*:author"></xsl:value-of>
     </xsl:variable>
     <xsl:variable name="id">
     <xsl:number value="position()" format="0001"/>
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
  
    <xsl:choose> 
     <xsl:when test="string-length($nicName) gt 0">
      <persName resp="Nicoll"><xsl:value-of select="$nicName"/></persName>
     </xsl:when>
     <xsl:when test="count($nicNums) eq 0">
      <xsl:message>Entry for <xsl:value-of select="$a"/> not linked to Nicoll </xsl:message>   
     </xsl:when>
   <xsl:otherwise>
    <xsl:message>Couldn't find <xsl:value-of select="$a"/> in <xsl:value-of select="$nicNums"/></xsl:message>   
   </xsl:otherwise></xsl:choose>
    
  <writerOf><xsl:value-of select="$occurrences"/></writerOf> 
   </person><xsl:text>
</xsl:text></xsl:if>
   </xsl:for-each>
</listPerson> </xsl:template>
</xsl:stylesheet>