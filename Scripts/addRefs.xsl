<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
    exclude-result-prefixes="xs t"
    version="2.0">
  
  <!-- add references from extraFile and rename note to listRefs -->
 
<xsl:param name="extraFile">htListFull-edited.xml</xsl:param>

 <xsl:template match="/ | @* | node()">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
 </xsl:template>
</xsl:stylesheet>
    
 <xsl:template match="div/bibl/note[@type='digitizations']">
      <xsl:variable name="currentBib" select="../@xml:id"/>
  <listRef xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:for-each select="ref">
    <xsl:copy-of select="."/>
   </xsl:for-each>
   <xsl:if test="document($extraFile)/*:listBibl/*:bibl[@xml:id=$currentBib]/*:ref/@target">
   <ref>
    <xsl:attribute name="target">
     <xsl:value-of select="document($extraFile)/*:listBibl/*:bibl[@xml:id=$currentBib]/*:ref/@target"/>
    </xsl:attribute>
    <xsl:text>HathiTrust</xsl:text></ref> </xsl:if> </listRef>
 </xsl:template>

 <xsl:template match="div/bibl[not(note[@type='digitizations'])]">
  <xsl:variable name="currentBib" select="@xml:id"/>
  <xsl:message>No previous digitization for <xsl:value-of select="$currentBib"/></xsl:message>
  <xsl:copy>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>  
   <xsl:if test="document($extraFile)/*:listBibl/*:bibl[@xml:id=$currentBib]/*:ref/@target">
    <listRef xmlns="http://www.tei-c.org/ns/1.0">
     <ref>
  <xsl:attribute name="target">
  <xsl:value-of select="document($extraFile)/*:listBibl/*:bibl[@xml:id=$currentBib]/*:ref/@target"/>
 </xsl:attribute>
   <xsl:text>Hathi Trust</xsl:text></ref>
  </listRef></xsl:if>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
