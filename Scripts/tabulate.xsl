<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:lb="http://lb42.github.io"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs  lb"
 version="3.0">
 <!--S_1_Farce_F._FARCE-->
 <xsl:template match="/">
  <xsl:variable name="root" select="."/>
  <!--  select="distinct-values(substring-after(substring-after(substring-after(//div/bibl/@type, '_'), '_'), '_'))">
-->  
  
  <xsl:for-each select="//div/bibl/@type">
     <xsl:variable name="cat" select="tokenize(.,'_')[last()]"/>

    <xsl:value-of select="$cat"/><xsl:text>|</xsl:text>
   <xsl:value-of select="count($root//div/bibl[contains(@type, $cat)])"/> <xsl:text>|</xsl:text>
   
   <xsl:for-each
    select="$root//div/bibl[contains(@type, $cat)]">   
        <xsl:value-of select="distinct-values(tokenize(@type,'_')[4])"/>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>


</xsl:stylesheet>
