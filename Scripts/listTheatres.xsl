<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs" version="2.0">

 <!-- looks for theatres of first performance only -->

 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <listPlace xmlns="http://www.tei-c.org/ns/1.0" type="theatres">
   <xsl:for-each-group select="//t:eventName/t:name"
    group-by="normalize-space(replace(., '[ -,.\n/:]', ''))">
    <xsl:sort/>
    <xsl:variable name="groupName" select="current-grouping-key()"/>
    <xsl:variable name="normName" select="normalize-space(self::node())"/>
    <xsl:variable name="name" select="self::node()"/>


    <place xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$groupName}">
     <xsl:for-each select="distinct-values(current-group())">
      <name>
       <xsl:value-of select="normalize-space(.)"/>
      </name>
     </xsl:for-each>
    </place>
    <xsl:text>
</xsl:text>
   </xsl:for-each-group>
  </listPlace>
 </xsl:template>
</xsl:stylesheet>
