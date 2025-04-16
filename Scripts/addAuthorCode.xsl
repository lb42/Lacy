<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">

<!-- enhances catalogue to include a  @ref on author elements, 
     using data from authors.xml -->
  
 <xsl:param name="extraFile">/home/lou/Public/Lacy/authorList.xml</xsl:param>

 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="body/div/bibl/author[1]">
  <xsl:variable name="currentBib" select="parent::bibl/@xml:id"/>
  <xsl:variable name="currentAuth" select="."/>
  <xsl:for-each select="document($extraFile)/*:listPerson/*:person/*:writerOf[contains(.,$currentBib)]">
 <!--  <xsl:variable name="titles" select="."/>
   <xsl:if test="contains($titles, $currentBib)">
 -->   <xsl:variable name="aCode" select="parent::*:person/@xml:id"/>
    <xsl:message>
     <xsl:value-of select="concat('Author for ', $currentBib, ' is ', $aCode)"/>
    </xsl:message>
    <author xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:attribute name="ref" select="$aCode"/>
     <xsl:value-of select="preceding-sibling::*:persName"/>
    </author>
   <!--</xsl:if>-->
  </xsl:for-each>
 </xsl:template>
 <xsl:template match="*:writerOf"/>
</xsl:stylesheet>
