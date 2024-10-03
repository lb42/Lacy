<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">

  <!-- generate listPerson for all named actors in TEI plays -->

  <!-- &winita; -->
  
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
   <listPerson xmlns="http://www.tei-c.org/ns/1.0" type="actors">
     <xsl:for-each-group select="//t:actor"    
       group-by="normalize-space(replace(.,'[ -,.\n]',''))" >
       <xsl:sort/>
     <xsl:variable name="groupName" select="current-grouping-key()"/> 
      <xsl:variable name="normName" select="normalize-space(self::node())"/> 
      <xsl:variable name="name" select="self::node()"/> 
       
      
      <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{substring-after($groupName,'Mr')}">
        <xsl:for-each select="distinct-values(current-group())">
          <persName><xsl:value-of select="normalize-space(.)"/></persName>
        </xsl:for-each>       
      </person>
       <xsl:comment>
<xsl:value-of select="count($context//*:actor[matches(.,$name)])"/> 
</xsl:comment>
    <xsl:text>
</xsl:text>
     </xsl:for-each-group>
   </listPerson></xsl:template></xsl:stylesheet>
     
 
