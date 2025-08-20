<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">
 
 <xsl:template match="/ | @* | node()">
 <!-- <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>-->
  <xsl:apply-templates/>
 </xsl:template>
 
 

<xsl:template match="div/bibl[not(contains(@status,'nf'))]">
 <xsl:variable name="textId" select="@xml:id"/>
 <dig play="{$textId}">
  <xsl:variable name="identList" select="note[@type='localCopies']/ident"/>
  <xsl:variable name="identString" select="string-join($identList,' ')"/>
  
  <xsl:for-each select="listRef/ref">
  <xsl:variable name="url" select="@target"/>
  <xsl:variable name="nVal" select="@n"/>
  <xsl:choose>
 <!--  <xsl:when test="contains($identString, concat($textId,'-vpp'))">
    <ref target="{concat('https://lb42.github.io/Lacy/Source/VPP/',$textId,'-vpp.pdf')}">
     Copytext (UB from VPP)
    </ref>
-->   <!--</xsl:when>-->
   <xsl:when test="contains($url, 'VPP')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-vpp.pdf')">
      <ref target="{$url}" n="{concat($textId,'-vpp')}">
       Copytext (UB from VPP)
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when> 
   <xsl:when test="contains($url, 'lb42')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
    <xsl:choose><xsl:when test="contains($theFile,'-lb.pdf')">
     <ref target="{$url}" n="{concat($textId,'-lb')}">
      Copytext (from LB private collection)
     </ref>
    </xsl:when>
     <xsl:otherwise>
      <ref target="{$url}" n="{concat($textId,'-bl')}">
       Copytext from BL volume digitized by Google
      </ref>
     </xsl:otherwise>
</xsl:choose>   </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($url, 'mdp')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-um.pdf')">
      <ref target="{$url}" n="{concat($textId,'-um')}">
       Copytext (UM from HathiTrust)
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when>
  <!-- <xsl:when test="contains($url, '/hvd')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-hv.pdf')">
      <ref target="{$url}" >
       <xsl:value-of select="concat('local:',$theFile)"/>
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($url, 'archive.org')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-uw.pdf')">
      <ref target="{$url}" >
       <xsl:value-of select="concat('local:',$theFile)"/>
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($url, '/uiug')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-uiu.pdf')">
      <ref target="{$url}" >
       <xsl:value-of select="concat('local:',$theFile)"/>
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($url, 'uc1.')">
    <xsl:for-each select="$identList">
     <xsl:variable name="theFile" select="."/> 
     <xsl:if test="contains($theFile,'-uc.pdf')">
      <ref target="{$url}" >
       <xsl:value-of select="concat('local:',$theFile)"/>
      </ref>
     </xsl:if>
    </xsl:for-each>
   </xsl:when>-->
  </xsl:choose>
 </xsl:for-each>
  <listRef type="otherCopies">
   <xsl:copy-of  select="listRef/ref[not(contains(@target,'vpp')) and not(contains(@target,'mdp')) and not(contains(@target,'lb42'))]"/>
  </listRef>
 </dig><xsl:text>
 </xsl:text>
</xsl:template>
 
</xsl:stylesheet>