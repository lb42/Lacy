<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">

<!-- run this in Lacy/TEI
  $saxon -xi driver.tei ../Scripts/listActors.xsl
-->
 
 <xsl:output method="text"/>
  
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
<xsl:message>Found <xsl:value-of select="count(//t:actor)"/> actors</xsl:message>

<xsl:for-each select="//t:actor">
<xsl:sort select="normalize-space(replace(.,'[ -,.\n]',''))"/>
<xsl:variable name="tag" 
select="normalize-space(replace(.,'[ -,.\n]',''))"/>
<xsl:variable name="play" select="ancestor::t:TEI/@xml:id"/>
<xsl:variable name="role" select="preceding-sibling::t:role"/>
<xsl:variable name="perfD" 
select="ancestor::t:TEI/t:teiHeader/t:fileDesc/t:sourceDesc/t:listEvent/t:event[@type='firstPerf']/@when"/>
<xsl:variable name="perfL" 
select="ancestor::t:TEI/t:teiHeader/t:fileDesc/t:sourceDesc/t:listEvent/t:event[@type='firstPerf']/@where"/>

<xsl:value-of select="$tag"/> played <xsl:value-of 
select="$role"/> in <xsl:value-of select="$play"/> at <xsl:value-of select="$perfL"/> on <xsl:value-of select="$perfD"/>
<xsl:text>
</xsl:text>
</xsl:for-each>
    <!-- <xsl:for-each-group select="//t:actor"    
       group-by="normalize-space(replace(.,'[ -,.\n]',''))" >
       <xsl:sort/>
     <xsl:variable name="groupName" select="current-grouping-key()"/> 
      <xsl:variable name="normName" select="normalize-space(self::node())"/> 
      <xsl:variable name="name" select="self::node()"/> 
       
      
      <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$groupName}">
        <xsl:for-each select="distinct-values(current-group())">
          <persName><xsl:value-of select="normalize-space(.)"/></persName>
        </xsl:for-each>       
      </person>
       <xsl:comment>
<xsl:value-of select="count($context//*:actor[matches(.,$name)])"/> 
</xsl:comment>
    <xsl:text>
</xsl:text>
     </xsl:for-each-group>-->
   </xsl:template></xsl:stylesheet>
     
 
