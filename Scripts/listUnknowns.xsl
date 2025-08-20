<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs" 
 version="2.0">
 
 <!-- run against authorList.xml -->
 
 <xsl:output method="text"/>
 
 <xsl:template match="/">
  <xsl:text>Unknown Authors listed in the Lacy Catalogue
</xsl:text>
  <xsl:for-each select="//*:person[*:ref[not(@target)] and not(@birth) and not(@ref)]">
   <xsl:if test="not(*:ptr) ">
<xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>: </xsl:text>
      <xsl:if test="@ref"><xsl:value-of select="concat(' viaf:', substring-after(@ref,'viaf/'))"/><xsl:text> </xsl:text></xsl:if>
       <xsl:for-each select="*:persName">
      <xsl:text> | </xsl:text>  <xsl:value-of select="."/>
       </xsl:for-each><xsl:text>
   </xsl:text>
      
  <xsl:for-each select="tokenize(*:writerOf)">
  <xsl:variable name="myId" select="."/>
   <xsl:value-of select="$myId"/><xsl:text> : </xsl:text>
   <xsl:value-of select="document('catalogue.xml')//*:bibl[@xml:id eq $myId]/normalize-space(*:title[1])"/>
   <xsl:text> (</xsl:text><xsl:value-of select="document('catalogue.xml')//*:bibl[@xml:id eq $myId]/normalize-space(*:eventName)"/>
  <xsl:text>)
   </xsl:text>
  </xsl:for-each>
   </xsl:if>
  </xsl:for-each> 
 </xsl:template>

</xsl:stylesheet>