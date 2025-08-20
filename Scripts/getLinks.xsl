<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="3.0">
 <!--
 <div source="http://hdl.handle.net/2027/mdp.39015067453160" type="volume" n="23/1855">
  https://babel.hathitrust.org/cgi/pt?id=mdp.39015067452998&seq=9
 
--> <xsl:template match="/">
  <xsl:for-each select="//extent[contains(., '(UM copy:')]">
   <xsl:variable name="lacyNo" select="ancestor::bibl/@xml:id"/>
   <xsl:variable name="vol" select="substring-after(ancestor::div[@type='volume']/@source,'mdp.')"/>
   <xsl:variable name="lacyNo" select="ancestor::bibl/@xml:id"/>
   <xsl:variable name="page" select="substring-before(substring-after(.,'(UM copy: '),'-')"/>
   <xsl:variable name="target" select="concat('https://babel.hathitrust.org/cgi/pt?id=mdp.', $vol, '&amp;seq=', $page)"/>
   <ref target="{$target}"> <xsl:value-of select="$lacyNo"/> </ref>
     </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>