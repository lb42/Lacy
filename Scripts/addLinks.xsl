<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">
 
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>
 
<xsl:template match="eventName">
 <xsl:copy-of select="."/>
 <xsl:if test="not(starts-with(ancestor::bibl/@status, 'nf')) and contains(preceding-sibling::extent,'(UM copy: ')">
 <listRef xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:if test="following-sibling::listRef">
   <xsl:apply-templates select="following-sibling::listRef/*"/>
  </xsl:if> 
   <xsl:call-template name="linker"/>
  </listRef>
 </xsl:if>
</xsl:template>

<xsl:template match="listRef"/>
 
 <xsl:template name="linker">
    <xsl:variable name="extent" select="ancestor::bibl/extent"/>
   <xsl:variable name="vol" select="substring-after(ancestor::div[@type='volume']/@source,'mdp.')"/>
   <xsl:variable name="lacyNo" select="ancestor::bibl/@xml:id"/>
   <xsl:variable name="page" select="substring-before(substring-after($extent,'(UM copy: '),'-')"/>
   <xsl:variable name="target" select="concat('https://babel.hathitrust.org/cgi/pt?id=mdp.', $vol, '&amp;seq=', $page)"/>
  <ref xmlns="http://www.tei-c.org/ns/1.0" target="{$target}"> <xsl:value-of select="$lacyNo"/> </ref>
 </xsl:template>
</xsl:stylesheet>