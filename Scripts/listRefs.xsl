<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
 <xsl:for-each select="//t:div[@type='volume']">

  <xsl:value-of select="format-number(count(t:bibl/t:note[@type='digitizations']/t:ref),'00') "/> refs in  vol <xsl:value-of 
   select="substring-before(@n,'/')"/><xsl:text>
</xsl:text>
</xsl:for-each>

<xsl:message>There are <xsl:value-of select="count(//t:div/t:bibl)"/> records. </xsl:message>  
   <xsl:message>There are <xsl:value-of select="count(//t:div/t:bibl[t:listRef/t:ref])"/> titles with at least one ref  and <xsl:value-of select="count(//t:div/t:bibl[t:listRef][count(t:ref) gt 1])"/> with more than one  </xsl:message>
<xsl:message>Of which, <xsl:value-of select="count(//t:ref[contains(@target,'victorian')])"/> from VPP </xsl:message>  
<xsl:message>... <xsl:value-of select="count(//t:ref[contains(@target,'archive')])"/> from Internet Archive </xsl:message>  
  <xsl:message>... <xsl:value-of select="count(//t:ref[contains(@target,'hdl')])"/> hdl from HathiTrust</xsl:message>
   <xsl:message>... <xsl:value-of select="count(//t:ref[contains(@target,'ox.ac')])"/> from Bodleian Library</xsl:message>
    <xsl:message>... <xsl:value-of select="count(//t:ref[contains(@target,'gutenberg')])"/> from Project Gutenberg</xsl:message>
     <xsl:message>... <xsl:value-of select="count(//t:ref[contains(.,'Google')])"/> from Google Books     
  </xsl:message>
 
   <xsl:message>There are <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref)"/> digrefs, including <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[starts-with(@target,
      'local')])"/> local copy links</xsl:message>
   <xsl:message> And there are <xsl:value-of select="count(//t:note/t:ref[@type='ms'])"/> links to LCP mss</xsl:message>
   
 </xsl:template>
</xsl:stylesheet>
