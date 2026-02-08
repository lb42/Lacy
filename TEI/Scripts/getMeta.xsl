<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output media-type="text" omit-xml-declaration="yes"/>
 
 <!-- produce csv from existing metadata in one text -->
 <!-- run with doRole.sh -->
 
 <xsl:template match="/">
   <!-- field names are set in the doCounts shell script -->
   <!-- <xsl:text>id,title,pp,txWords,spCount,spFcount,spMount,roles,rolesM,rolesF,genre,class
</xsl:text>-->
  <xsl:for-each select="TEI">
   <xsl:variable name="qq">"</xsl:variable>
   <xsl:value-of select="@xml:id"/><xsl:text>,"</xsl:text>
  <xsl:value-of select="normalize-space(replace(teiHeader/fileDesc/titleStmt/title[1], $qq,''))"/>
<xsl:text>",</xsl:text>
   <xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/extent/measure[@type='pp']/@quantity"/><xsl:text>,</xsl:text>
   <xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/extent/measure[@type='txWords']/@quantity"/><xsl:text>,</xsl:text>
   <xsl:value-of select="count(//sp)"/><xsl:text>,</xsl:text>
   <xsl:value-of select="count(//sp[contains(@who,'_F')])"/><xsl:text>,</xsl:text>
   <xsl:value-of select="count(//sp[contains(@who,'_M')])"/><xsl:text>,</xsl:text>
   
   <xsl:value-of select="count(text/front//castList/castItem/role)"/><xsl:text>,</xsl:text>
   <xsl:value-of select="count(text/front//castList/castItem/role[@gender='M'])"/><xsl:text>,</xsl:text>
   <xsl:value-of select="count(text/front//castList/castItem/role[@gender='F'])"/><xsl:text>,</xsl:text>
   <xsl:value-of select="teiHeader/profileDesc/textClass/catRef[starts-with(@target,'nic:')]/substring-after(@target,'nic:')"/><xsl:text>,</xsl:text>
   <xsl:value-of select="teiHeader/profileDesc/textClass/keywords/term[1]"/><xsl:text>
   </xsl:text>
</xsl:for-each>
  
 </xsl:template>

</xsl:stylesheet>
