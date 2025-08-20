<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:lb="http:lb42.github.io"
 xmlns:t="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs lb t" version="2.0">

<!-- make particLists from speaker and castItem tags--> 
  <xsl:template match="teiHeader"/>
 <xsl:template match="text">
  <xsl:variable name="root" select="."/>
  <xsl:variable name="id" select="ancestor::TEI/@xml:id"/>
  <particDesc xmlns="http://www.tei-c.org/ns/1.0" n="{$id}">
 <xsl:comment>   Roles in cast List  </xsl:comment>
   <listPerson type="roles">
    <xsl:for-each select="front//castItem/role">
     <xsl:sort/>
     <xsl:variable name="v" select="."/>
     <person xml:id="{lb:tidyId($v)}" sex="MALE">
      <persName><xsl:value-of select="$v"/></persName>
     </person> <xsl:text>
</xsl:text>
    </xsl:for-each>
   </listPerson>
   <xsl:comment>
    Roles in speeches
   </xsl:comment>
   <listPerson  type="speakers">
   <xsl:for-each select="distinct-values(body//speaker)">
    <xsl:sort/>
   <xsl:variable name="v" select="."/>
   <person>
    <xsl:attribute name="xml:id" select="lb:tidyId($v)"/>   
    <persName type="variant"> <xsl:attribute name="n" select="count($root/body//speaker[. eq $v])"/> <xsl:value-of select="$v"/></persName>
   </person>
  <xsl:text>
</xsl:text>
  </xsl:for-each></listPerson>
   <xsl:comment>    Actor names from castlist   </xsl:comment>
   <listPerson type="roles">
    <xsl:for-each select="front//castItem/actor">
     <xsl:sort/>
     <person xml:id="{lb:tidyId(.)}">
      <persName type="actor"><xsl:value-of select="normalize-space(.)"/></persName>
     </person> <xsl:text>
</xsl:text>
    </xsl:for-each>
   </listPerson>
 </particDesc> 
 </xsl:template>
 
   <xsl:function name="lb:tidyId">
    <xsl:param name="s"/>
    <xsl:variable name="q">'</xsl:variable>
  <xsl:variable name="junkChars" select="concat($q,'. ')"/> 
    <xsl:value-of select="upper-case(translate(normalize-space($s),$junkChars,''))"/>
   </xsl:function>
 
</xsl:stylesheet>
