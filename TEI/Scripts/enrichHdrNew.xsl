<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs t" version="3.0">
 
 <!-- copy info from catalogue to individual text headers -->
 <!-- and enrich header with text component counts -->
 <!-- make basic changes for dracor conformance -->
 
 <xsl:variable name="today">
  <xsl:value-of
   select="
   format-date(current-date(),
   '[Y0001]-[M01]-[D01]')"
  />
 </xsl:variable>
 
 <xsl:variable name="currentFile" select="tokenize(base-uri(.), '/')[last()]"/>
 
 <!-- get figures for extent -->
 
  <xsl:variable name="ppCount" select="count(//t:pb)"/>
 <xsl:variable name="spCount" select="count(//t:sp)"/>
 <xsl:variable name="spvCount" select="count(//t:sp[t:l])"/> 
  <xsl:variable name="spString"
   select="normalize-space(replace(string-join(//t:sp/(t:p | t:l)/text(), ' '), '—', ' '))"/>
  <xsl:variable name="stString"
   select="normalize-space(replace(string-join(//t:stage, ' '), '[\(\)\-\.—]', ' '))"/>
  <xsl:variable name="spWords" select="count(tokenize($spString))"/>
  <xsl:variable name="stWords" select="count(tokenize($stString))"/>
 
 <xsl:template match="/">
  <xsl:message>
       <xsl:value-of 
       select="$currentFile"/> contains <xsl:value-of select="$ppCount"/> pages ; <xsl:value-of 
        select="$spWords+$stWords"/> words ; <xsl:value-of 
         select="$spCount"/> speeches,   <xsl:value-of select="$spvCount"/> of them in verse. 
  </xsl:message>
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="t:sourceDesc">
  
 <!-- copy data for source desc from catalogue -->
  
  <xsl:variable name="id" select="ancestor::*:TEI/@xml:id"/>
  <xsl:message>Text id is <xsl:value-of select="$id"/></xsl:message>
  <xsl:variable name="digBib" select="t:p"/>
  <xsl:for-each select="document('/home/lou/Public/Lacy/newCatalogue.xml')//*:div[@type='work' and @xml:id eq $id]">
   <xsl:variable name="catBib" select="."/>
   <xsl:variable name="subjectStr" select="$catBib/@type"/>
   <sourceDesc xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:apply-templates select="*"/>
   </sourceDesc>
  </xsl:for-each>
 </xsl:template>
 

 <xsl:template match="t:profileDesc">
  <profileDesc xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:variable name="id" select="ancestor::*:TEI/@xml:id"/>
   <xsl:apply-templates select="t:textClass"/>
   <particDesc>
    <xsl:copy-of select="document(concat('/home/lou/Public/Lacy/TEI/Partix/',$id,'.xml'))//*:particDesc/*:listPerson"/>
   </particDesc>
  </profileDesc>
  
 </xsl:template>

 
 <xsl:template match="t:revisionDesc">
 <!--<xsl:if test="not(preceding-sibling::t:profileDesc)">
  <profileDesc xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:variable name="id" select="ancestor::*:TEI/@xml:id"/>
   <xsl:variable name="catStr"
    select="document('/home/lou/Public/Lacy/newCatalogue.xml')//*:div[@type='work' and @xml:id eq $id]/@ana"/>
    <xsl:variable name="catStrs" select="tokenize($catStr, '_')"/>
   <xsl:comment>
    <xsl:value-of select="$catStr"/>
   </xsl:comment>
   <textClass xmlns="http://www.tei-c.org/ns/1.0">
    <catRef target="{concat('#size',$catStrs[1])}"/>
    <catRef target="{concat('#act',$catStrs[2])}"/>
    <catRef target="{concat('nic:',$catStrs[4])}"/>
    <keywords>
     <term>
      <xsl:value-of select="$catStrs[last()]"/>
     </term>
    </keywords>
   </textClass>
   <particDesc>
    <xsl:copy-of select="document(concat('/home/lou/Public/Lacy/TEI/Partix/',$id,'.xml'))//*:particDesc/*:listPerson"/>
   </particDesc>
  </profileDesc>
  </xsl:if>-->

<!-- and update revisionDesc -->
  
  <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
  <change when="{$today}">Metadata updated from new catalogue</change>
   <xsl:apply-templates/>
  </revisionDesc>
 </xsl:template>

<xsl:template match="@sex">
 <xsl:attribute name="ana" select="concat('#',.)"/>
</xsl:template>
 
 <xsl:template match="@subtype">
  <xsl:attribute name="n">copytext</xsl:attribute>
 </xsl:template>
 
 <!--<xsl:template match="@gender">
  <xsl:attribute name="ana" select="concat('#',.)"/>
 </xsl:template>
--> 
 <xsl:template match="@resp">
<xsl:if test=". ne 'source'">  <xsl:attribute name="source" select="concat('#',.)"/>
</xsl:if> </xsl:template>
 
 <xsl:template match="t:extent">
  <extent xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:value-of select="."/>
   <measure type="pp" quantity="{$ppCount}"/>
   <measure type="spCount" quantity="{$spCount}"/>
   <measure type="spvCount" quantity="{$spvCount}"/>
   <measure type="txWords" quantity="{$spWords+$stWords}"/>
   <measure type="spWords" quantity="{$spWords}"/>
   <measure type="stWords" quantity="{$stWords}"/>
  </extent><xsl:text>
</xsl:text>
 </xsl:template>
 
 <xsl:template match="t:note[@type eq 'localCopies']">
  <!--<listRef xmlns="http://www.tei-c.org/ns/1.0" type="localCopies">
 -->  
  <xsl:for-each select="t:ident">
   <ref xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="."/></ref>
   </xsl:for-each>
  <!--</listRef>-->
 </xsl:template>
 
 <xsl:template match="t:publicationStmt/t:idno">
  <xsl:copy>
   <xsl:attribute name="type">URL</xsl:attribute>
    <xsl:value-of select="concat('lae:',.)"/>
  </xsl:copy>
 </xsl:template>
 
 <!-- suppress superceded elements -->
 
 <xsl:template match="t:listRef"/>
 <xsl:template match="t:eventName"/>
 
 
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>
