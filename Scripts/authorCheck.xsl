<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">

 
 
 <xsl:template match="/">
  <xsl:variable name="root" select="."/>
  <xsl:variable name="workTot" select="count(//t:div[@type='work'])"/>  
  <xsl:variable name="teiTot" select="count(//t:div[@type='work' and @subtype='TEI'])"/>
  <xsl:variable name="authorTot" select="count(document('../authorList.xml')//t:person)"/>
  <xsl:message><xsl:value-of 
    select="concat($workTot,' works - ', $teiTot, ' in TEI - ',$authorTot, ' authors')"/></xsl:message>
  
  <xsl:variable name="teiList" select="//t:div[@type='work' and @subtype='TEI']/@xml:id" />
  
  <xsl:text>Person,Name,lacyCount,percAuthors,teiCount,percTEI
  </xsl:text>
  <xsl:for-each select="document('../authorList.xml')//t:person">
   <xsl:variable name="lacyCount" select="count(t:listBibl[@type='lacyTitles']/t:bibl)"/>
   <xsl:variable name="teiCount" select="count(t:listBibl[@type='lacyTitles']/t:bibl/t:ref[@target = $teiList])"/>
    <!--$root//t:div[@type='work' and @subtype='TEI']/@xml:id])"/>-->
   <xsl:value-of select="concat(@xml:id,',|',t:persName[@type='main'],'|,',$lacyCount,',', t:perc($lacyCount,$workTot),',',$teiCount, ',', t:perc($teiCount,$teiTot))"/>  <xsl:text>
</xsl:text>
   
  </xsl:for-each>
<!--
  <xsl:for-each select="distinct-values(//t:div[@type='work']/tokenize(@ana,'_')[last()])">
   <xsl:sort/>
   <xsl:variable name="val" select="."/>
   <xsl:variable name="count" select="count($context//t:div[ends-with(@ana, $val)])"/>
   
   <xsl:variable name="percPop" select="format-number($count div $pop *100, '##.##')"/>
   <xsl:message><xsl:value-of select="concat($val,' occurs ',$count,' times, i.e. ',$percPop,' % of LAE
')"/></xsl:message>
   <xsl:variable name="count" select="count($context//t:div[@subtype='TEI' and ends-with(@ana, $val)])"/>
   <xsl:variable name="percSamp" select="format-number($count div $samp *100,'##.##')"/>
   <xsl:message><xsl:value-of select="concat($val,' occurs ',$count,' times i.e. ',$percSamp,'% of TEI subset
    ')"/></xsl:message>
   
   
  </xsl:for-each>
 -->
 </xsl:template>
 
 <xsl:function name="t:perc">
  <xsl:param name="count"/>
  <xsl:param name="pop"/>
<xsl:value-of select="format-number($count div $pop *100,'##.##')"/>
 </xsl:function>
 
</xsl:stylesheet>
