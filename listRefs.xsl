<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:template match="/">
 <xsl:for-each select="//t:div[@type='volume']">
 <xsl:message> <xsl:value-of select="count(t:bibl/t:note[@type='digitizations']/t:ref) "/> in <xsl:value-of 
   select="substring-before(@n,'/')"/>
  </xsl:message>
  <vol n="{substring-before(@n,'/')}" ref="https://hdl">
   <xsl:for-each select="t:bibl">
    <title pp="0 0" key="{@xml:id}" label="{@n}"/> <xsl:text>
</xsl:text>
   </xsl:for-each>
  </vol><xsl:text>
</xsl:text>
 </xsl:for-each> 
<xsl:message>There are <xsl:value-of select="count(//t:div/t:bibl)"/> records. </xsl:message>  
   <xsl:message>There are <xsl:value-of select="count(//t:div/t:bibl[t:note[@type='digitizations'][t:ref]])"/> titles with at least one digref  and <xsl:value-of select="count(//t:div/t:bibl[t:note[@type='digitizations'][count(t:ref) gt 1]])"/> with more than one  </xsl:message>
<xsl:message>Of which, <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(@target,'victorian')])"/> from VPP </xsl:message>  
<xsl:message>... <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(@target,'archive')])"/> from Internet Archive </xsl:message>  
  <xsl:message>... <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(@target,'hdl')])"/> from HathiTrust</xsl:message>
   <xsl:message>... <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(@target,'ox.ac')])"/> from Bodleian Library</xsl:message>
    <xsl:message>... <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(@target,'gutenberg')])"/> from Project Gutenberg</xsl:message>
     <xsl:message>... <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[contains(.,'Google')])"/> from Google Books     
  </xsl:message>
 
   <xsl:message>There are <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref)"/> digrefs, including <xsl:value-of select="count(//t:note[@type='digitizations']/t:ref[starts-with(@target,
      'local')])"/> local copy links</xsl:message>
   <xsl:message> And there are <xsl:value-of select="count(//t:note/t:ref[@type='ms'])"/> links to LCP mss</xsl:message>
     <!-- 
<xsl:for-each select="//t:bibl[count(t:note/t:ref) gt 0]">
 <xsl:value-of select="@n"/><xsl:text>,</xsl:text>
 <xsl:value-of select="count(t:note/t:ref[starts-with(@target,'vpp')])"/><xsl:text>,</xsl:text>
 <xsl:value-of select="count(t:note/t:ref[starts-with(@target,'ia:')])"/><xsl:text>,</xsl:text>
 <xsl:value-of select="count(t:note/t:ref[starts-with(@target,'http')])"/><xsl:text>,</xsl:text>
 <xsl:value-of select="count(t:note/t:ref[starts-with(@target,'lcp')])"/><xsl:text>
 </xsl:text>
 
  </xsl:for-each>-->
 </xsl:template>
</xsl:stylesheet>
