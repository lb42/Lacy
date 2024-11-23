<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math"
 version="3.0">
 <xsl:template match="*:listPerson">
  <TEI xmlns="http://www.tei-c.org/ns/1.0">
       <teiHeader>
     <fileDesc>
      <titleStmt>
       <title>Lacy's People: a list of the authors credited in Lacy's Acting Edition</title>
      <respStmt><resp>Constructed and curated by</resp><name>Lou Burnard</name></respStmt></titleStmt>
      <publicationStmt>
       <p>Unpublished draft for the Digital Lacy website</p>
      </publicationStmt>
      <sourceDesc>
       <p>Pulled together from a variety of sources</p>
      </sourceDesc>
     </fileDesc>
        <revisionDesc><change when="2024-11-23">Added TEI header</change></revisionDesc>
    </teiHeader>
    <text>
     <body><listPerson type="authors">
 <xsl:apply-templates/>
     </listPerson>
     </body></text></TEI>
 </xsl:template>
 
 <xsl:template match="*:person">
 <person xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:choose>
   <xsl:when test="*:persName[contains(.,'(1')]">
    <xsl:variable name="birth" select="substring(substring-after(*:persName[contains(.,'(1')], '('),1,4)"/>
    <xsl:variable name="death" select="substring(substring-after(*:persName[contains(.,'(1')], '–'),1,4)"/>
     <xsl:attribute name="age">
     <xsl:choose>
      <xsl:when test="$birth &lt; '1688'">G0</xsl:when>
      <xsl:when test="$birth &lt; '1780'">G1</xsl:when>
      <xsl:when test="$birth &lt; '1800'">G2</xsl:when>
      <xsl:when test="$birth &lt; '1820'">G3</xsl:when>
      <xsl:when test="$birth &lt; '1840'">G4</xsl:when>
      <xsl:otherwise>G5</xsl:otherwise>
     </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="@*"/>   
    <birth xmlns="http://www.tei-c.org/ns/1.0" when="{$birth}"/>
    <death xmlns="http://www.tei-c.org/ns/1.0" when="{$death}"/>
   </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="@*"/>       
    </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates/> 
   <xsl:if test="@ref">
    <idno  type="VIAF"><xsl:value-of select="substring-after(@ref,'viaf/')"/></idno>  
   </xsl:if>
  <xsl:if test="*:ref">
   <listBibl xmlns="http://www.tei-c.org/ns/1.0" type="seeAlso">
   <xsl:for-each select="*:ref[@target]">
 <bibl><ref xmlns="http://www.tei-c.org/ns/1.0"  target="{@target}"><xsl:value-of select="."/></ref>
 </bibl>  </xsl:for-each>
   <xsl:if test="@dlb">
 <bibl>   <ref target="DLB"/></bibl>
   </xsl:if>
   </listBibl>
  </xsl:if>
 </person>

 </xsl:template>
 
 <xsl:template match="@birth"/> <xsl:template match="@freq"/> <xsl:template match="@lacyTitles"/><xsl:template match="@dlb"/><xsl:template match="@ref"/>
 
<xsl:template match="*:person/*:ref[@target]"/>
 
 <xsl:template match="*:listBibl">
  <listBibl xmlns="http://www.tei-c.org/ns/1.0" type="lacyTitles">
   <xsl:for-each select="tokenize(.)">
    <bibl><xsl:value-of select="."/></bibl>
   </xsl:for-each>
  </listBibl> 
 </xsl:template>
  
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>