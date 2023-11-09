<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 
 <!-- (a) produce shell script 'filecheck.sh' to check there is a file for each @target=local 
      (b) report on file type usage
 -->
 <xsl:param name="root">/home/lou/Data/Lacy/</xsl:param>
 <xsl:variable name="outFile"><xsl:value-of select="concat($root,'fileCheck.sh')"/></xsl:variable>
 
 <xsl:template match="/">
  <xsl:variable name="context" select="."/>
  <xsl:result-document href="{$outFile}">
  <xsl:for-each select="//*:div">   
    <xsl:for-each select="*:bibl/*:listRef/*:ref[starts-with(@target,'local')]">
    <xsl:variable name="idno"><xsl:value-of select ="ancestor::*:bibl/@xml:id"/></xsl:variable>
    <xsl:variable name="targ"><xsl:value-of select ="substring(@target,19)"/></xsl:variable>
    <xsl:variable name="file"><xsl:value-of select="concat($root, substring-after(@target,':'))"/></xsl:variable>
<xsl:text>if ! test -f </xsl:text>
<xsl:value-of select="$file" />
     <xsl:text>; then echo "</xsl:text><xsl:value-of select="$file"/><xsl:text> not found"; fi; 
</xsl:text></xsl:for-each></xsl:for-each></xsl:result-document>
   <xsl:for-each select="distinct-values(//*:ref/@target[starts-with(.,'local:')]/substring-before(substring-after(.,'-'),'.pdf'))">
   <xsl:sort/>
   <xsl:variable name="f" select="concat('-', ., '.pdf')"/>
   <xsl:message><xsl:value-of select="."/><xsl:text> </xsl:text> <xsl:value-of select="count($context//*:ref[ends-with(@target, $f)])"/></xsl:message>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
