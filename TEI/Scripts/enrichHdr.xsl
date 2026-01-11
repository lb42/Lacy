<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs t" version="3.0">
 
 <!-- copy info from catalogue to individual text headers -->
 <!-- and enrich header with text component counts -->

 
 <xsl:variable name="today">
  <xsl:value-of
   select="
   format-date(current-date(),
   '[Y0001]-[M01]-[D01]')"
  />
 </xsl:variable>
 
 <!-- set globals -->
 <xsl:variable name="ppCount" select="count(//t:pb)"/>
 <xsl:variable name="spCount" select="count(//t:sp)"/>
 <xsl:variable name="spvCount" select="count(//t:sp[t:l])"/> 
 <xsl:variable name="spString"
   select="normalize-space(replace(string-join(//t:sp/(t:p | t:l)/text(), ' '), '—', ' '))"/>
 <xsl:variable name="stString"
   select="normalize-space(replace(string-join(//t:stage, ' '), '[\(\)\-\.—]', ' '))"/>
 <xsl:variable name="spWords" select="count(tokenize($spString))"/>
 <xsl:variable name="stWords" select="count(tokenize($stString))"/>
 <xsl:variable name="fileTitle" select="concat(//t:titlePage//t:titlePart[@type='main'],' TEI edition')"/>
 <xsl:variable name="currentFile" select="tokenize(base-uri(.), '/')[last()]"/> 
 
 <xsl:template match="/">
  <xsl:message>  <xsl:value-of 
       select="concat($currentFile, ' ',   $fileTitle)"/></xsl:message>
    <xsl:message><xsl:value-of select="$ppCount"/> pages ; <xsl:value-of 
        select="$spWords+$stWords"/> words, of them  <xsl:value-of select="$spWords"/> spoken and <xsl:value-of select="$stWords"/> in stage directions; <xsl:value-of  select="$spCount"/> speeches, <xsl:value-of select="$spvCount"/> of them in verse. 
  </xsl:message>
  <xsl:apply-templates/>
 </xsl:template>

 
 <xsl:template match="t:sourceDesc"> 
 <!-- replace with source info as given in catalogue -->
 <xsl:variable name="id" select="ancestor::*:TEI/@xml:id"/>
<!-- <xsl:message>Now adding metadata for text id  <xsl:value-of select="$id"/> </xsl:message>-->
<xsl:if test="not(following::t:revisionDesc)">
<xsl:message>!!! Revision Desc is missing: cannot add profileDesc !!! </xsl:message>
</xsl:if>

<xsl:for-each select="document('/home/lou/Public/Lacy/catalogue.xml')//*:div[@type='work' and @xml:id eq $id]">
   <xsl:variable name="catBib" select="."/>
   <xsl:variable name="subjectStr" select="$catBib/@type"/>
   <sourceDesc xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:apply-templates select="*"/>
   </sourceDesc>
  </xsl:for-each>
 </xsl:template>
 

 <xsl:template match="t:revisionDesc">
  <profileDesc xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:variable name="id" select="ancestor::*:TEI/@xml:id"/>
   <xsl:variable name="catStr"
    select="document('/home/lou/Public/Lacy/catalogue.xml')//*:div[@type='work' and @xml:id eq $id]/@ana"/>
   <xsl:variable name="catStrs" select="tokenize($catStr, '_')"/>
   <xsl:comment>
    <xsl:value-of select="$catStrs"/>
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
  <xsl:copy>
   <change when="{$today}"  xmlns="http://www.tei-c.org/ns/1.0">Standardize header components</change>
   <xsl:apply-templates/>
  </xsl:copy>
 </xsl:template>


 <xsl:template match="@resp">
<xsl:if test=". ne 'source'">  <xsl:attribute name="source" select="concat('#',.)"/>
</xsl:if> </xsl:template>
 
 <xsl:template match="t:extent">
   <xsl:copy>
   <xsl:value-of select="."/>
    <measure  xmlns="http://www.tei-c.org/ns/1.0" type="pp" quantity="{$ppCount}"/><xsl:text>
  </xsl:text>
    <measure type="spCount" quantity="{$spCount}"  xmlns="http://www.tei-c.org/ns/1.0"/><xsl:text>
  </xsl:text>
    <measure type="spvCount" quantity="{$spvCount}"  xmlns="http://www.tei-c.org/ns/1.0"/><xsl:text>
  </xsl:text>
    <measure type="txWords" quantity="{$spWords+$stWords}"  xmlns="http://www.tei-c.org/ns/1.0"/><xsl:text>
  </xsl:text>
    <measure type="spWords" quantity="{$spWords}"  xmlns="http://www.tei-c.org/ns/1.0"/><xsl:text>
  </xsl:text>
    <measure type="stWords" quantity="{$stWords}"  xmlns="http://www.tei-c.org/ns/1.0"/><xsl:text>
  </xsl:text>
</xsl:copy>  
 </xsl:template>
 
 <!-- make uniform some claims -->
 
<xsl:template match="t:publicationStmt">
<xsl:copy>
 <distributor xmlns="http://www.tei-c.org/ns/1.0">Privately distributed by the Digital Lacy Project</distributor>
<idno xmlns="http://www.tei-c.org/ns/1.0" type='LAE'>
<xsl:value-of select="ancestor::t:TEI/@xml:id"/>
</idno>
 <availability xmlns="http://www.tei-c.org/ns/1.0"><licence xmlns="http://www.tei-c.org/ns/1.0" target="https://creativecommons.org/publicdomain/zero/1.0/">The Lacy Project waives all rights to the TEI encoding applied to this material, which is believed to be in the public domain. You may copy, modify, distribute and perform this work freely. </licence></availability>
</xsl:copy>
</xsl:template>
 
<xsl:template match="t:fileDesc/t:titleStmt">
 <xsl:copy>
  <title xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="$fileTitle"/></title>
  <xsl:copy-of select="author"/>
 <!-- <xsl:apply-templates select="*"/>
-->  <respStmt xmlns="http://www.tei-c.org/ns/1.0">
   <resp xmlns="http://www.tei-c.org/ns/1.0">TEI conversion</resp>
   <name xmlns="http://www.tei-c.org/ns/1.0">Lou Burnard</name>
  </respStmt>
 </xsl:copy>
</xsl:template> 

<!-- suppress replaced elements -->
 
<xsl:template match="t:respStmt"/>
 <xsl:template match="t:profileDesc"/>

 <!-- suppress superceded elements -->
 
 <xsl:template match="t:publicationStmt/t:idno"/>
 <xsl:template match="t:listRef"/>
 <xsl:template match="t:eventName"/>

 
 <!-- default template: copy everything -->
 <xsl:template match="* | @* | processing-instruction()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
</xsl:stylesheet>
