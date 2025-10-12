<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
 <xsl:output omit-xml-declaration="yes" method="text"/>
 <xsl:template match="/">
  <xsl:apply-templates select="//body"/>
 </xsl:template>

 <!--  -->

 <xsl:template match="body">
  <xsl:variable name="lacyTot" select="count(//div[@type = 'work'])"/>
  <xsl:variable name="vppTot"
   select="count(//div[@type = 'work' and bibl[@type = 'printSource']/idno[@type = 'vpp']])"/>
  <xsl:variable name="teiTot" select="count(//div[@type = 'work' and @subtype eq 'TEI'])"/> 
  
  <xsl:message>Checking balance for ...</xsl:message>
  
  <!-- define the types to count -->
  
  <xsl:variable name="types" select="distinct-values(//event[@type='firstPerf' and starts-with(@when,'18')]/substring(@when,1,3))"/>
  <!-- <xsl:variable name="types"
   select="distinct-values(//div[@type = 'work']/tokenize(@ana, '_')[last()])"/>-->
  
  <xsl:message> ... date criterion</xsl:message>
  
  <xsl:variable name="root" select="."/> 
  <xsl:text>
total,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:value-of select="concat(.,',')"/>
  </xsl:for-each>
  <xsl:text>
</xsl:text>
  <xsl:value-of select="$lacyTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="."/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:variable name='f'
    select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t]) "/>
    <!--     <xsl:variable name="f" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t)])"/> -->
   <xsl:variable name="teiF"
    select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and @subtype eq 'TEI']) "/>
    <!--  <xsl:variable name="teiF" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI'])"/>
 -->   <xsl:variable name="lacyPerc" as="xs:decimal">
     <xsl:choose>
      <xsl:when test="$f eq 0">
       <xsl:message>No Lacy titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/>
      </xsl:when>
      <xsl:when test="$teiF eq 0">    <xsl:message>No TEI titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/></xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="round( ($f div $lacyTot )*100)"/>
      </xsl:otherwise></xsl:choose>
    </xsl:variable>
 
     <xsl:variable name="diff" select = "$lacyPerc - $teiF"/>    
   <xsl:value-of select="$f"/>  
    <xsl:if test="abs($diff) gt 2"> 
     <xsl:message>For <xsl:value-of select="$t"/> %lacyTot = <xsl:value-of select="$lacyPerc"/> should be <xsl:value-of select="$teiF"/> </xsl:message>
     <xsl:value-of select="concat(' (',$diff,')')"/>
    </xsl:if>   
    <xsl:text>,</xsl:text>
   </xsl:if></xsl:for-each>
  <xsl:text>
</xsl:text>
    
  <xsl:value-of select="$vppTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="."/>
<!--   <xsl:message>Category <xsl:value-of select="$t"/>: </xsl:message>
-->   
   <xsl:if test="string-length($t) gt 1">
    <xsl:variable name='f'
     select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and bibl[@type = 'printSource']/idno[@type = 'vpp']]) "/>
    <!--     <xsl:variable name="f" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t)])"/> --> 
    <xsl:variable name="teiF"
      select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and @subtype eq 'TEI']) "/>
    <!--  <xsl:variable name="teiF" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI'])"/>
 --><xsl:variable name="vppPerc" as="xs:decimal">
     <xsl:choose>
      <xsl:when test="$f eq 0">
       <xsl:message>No VPP titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/>
      </xsl:when>
      <xsl:when test="$teiF eq 0">    <xsl:message>No TEI titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/></xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="round( ($f div $vppTot )*100)"/>
      </xsl:otherwise></xsl:choose>
    </xsl:variable>
      <xsl:variable name="diff" select = "$vppPerc - $teiF"/>    
     <xsl:value-of select="$f"/>  
     <xsl:if test="abs($diff) gt 2"> 
      <xsl:message>For <xsl:value-of select="$t"/> f%vppTot = <xsl:value-of select="$vppPerc"/> should be <xsl:value-of select="$teiF"/> </xsl:message>
      <xsl:value-of select="concat(' (',$diff,')')"/>
     </xsl:if>     
     <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  
  <xsl:text>
</xsl:text>

  <xsl:value-of select="$teiTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="."/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:value-of
     select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and @subtype eq 'TEI']) "/>
    <!--  <xsl:variable name="teiF" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI'])"/>
 -->
   </xsl:if>
   <xsl:if test="not(position() = last())">
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  <xsl:text>
</xsl:text>

<!-- just do it again -->
  
 <!-- <xsl:variable name="types" select="distinct-values(//event[@type='firstPerf' and starts-with(@when,'18')]/substring(@when,1,3))"/>
-->   <xsl:variable name="types"
   select="distinct-values(//div[@type = 'work']/tokenize(@ana, '_')[last()])"/>
  
  <xsl:message> ... genre criterion</xsl:message>
  
  <xsl:variable name="root" select="."/> 
  <xsl:text>
total,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:value-of select="concat(.,',')"/>
  </xsl:for-each>
  <xsl:text>
</xsl:text>
  <xsl:value-of select="$lacyTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="concat('_',.)"/>
   <xsl:if test="string-length($t) gt 1">
  <!--  <xsl:variable name='f'
     select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t]) "/>
-->         <xsl:variable name="f" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t)])"/> 
   <!-- <xsl:variable name="teiF"
     select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and @subtype eq 'TEI']) "/>
-->      <xsl:variable name="teiF" select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI'])"/>
    <xsl:variable name="lacyPerc" as="xs:decimal">
     <xsl:choose>
      <xsl:when test="$f eq 0">
       <xsl:message>No Lacy titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/>
      </xsl:when>
      <xsl:when test="$teiF eq 0">    <xsl:message>No TEI titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/></xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="round( ($f div $lacyTot )*100)"/>
      </xsl:otherwise></xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="diff" select = "$lacyPerc - $teiF"/>    
    <xsl:value-of select="$f"/>  
    <xsl:if test="abs($diff) gt 2"> 
     <xsl:message>For <xsl:value-of select="$t"/> %lacyTot = <xsl:value-of select="$lacyPerc"/> should be <xsl:value-of select="$teiF"/> </xsl:message>
     <xsl:value-of select="concat(' (',$diff,')')"/>
    </xsl:if>   
    <xsl:text>,</xsl:text>
   </xsl:if></xsl:for-each>
  <xsl:text>
</xsl:text>
  
  <xsl:value-of select="$vppTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="concat('_',.)"/>
   <!--   <xsl:message>Category <xsl:value-of select="$t"/>: </xsl:message>
-->   
   <xsl:if test="string-length($t) gt 1">
   <!-- <xsl:variable name='f'
     select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and bibl[@type = 'printSource']/idno[@type = 'vpp']]) "/>
-->       <xsl:variable name="f" select="count($root/div/div[@type = 'work' and bibl[@type = 'printSource']/idno[@type = 'vpp'] and ends-with(@ana, $t)])"/>  
    
    <!--    <xsl:variable name="teiF" select="count($root/div/div[@type = 'work' and substring(listEvent/event[@type='firstPerf']/@when,1,3) eq $t and @subtype eq 'TEI']) "/>
-->  <xsl:variable name="teiF"  select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI'])"/>
 <xsl:variable name="vppPerc" as="xs:decimal">
     <xsl:choose>
      <xsl:when test="$f eq 0">
       <xsl:message>No VPP titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/>
      </xsl:when>
      <xsl:when test="$teiF eq 0">    <xsl:message>No TEI titles for <xsl:value-of select="$t"/></xsl:message>
       <xsl:value-of select="0"/></xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="round( ($f div $vppTot )*100)"/>
      </xsl:otherwise></xsl:choose>
    </xsl:variable>
    <xsl:variable name="diff" select = "$vppPerc - $teiF"/>    
    <xsl:value-of select="$f"/>  
    <xsl:if test="abs($diff) gt 2"> 
     <xsl:message>For <xsl:value-of select="$t"/> f%vppTot = <xsl:value-of select="$vppPerc"/> should be <xsl:value-of select="$teiF"/> </xsl:message>
     <xsl:value-of select="concat(' (',$diff,')')"/>
    </xsl:if>     
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  
  <xsl:text>
</xsl:text>
  
  <xsl:value-of select="$teiTot"/>
  <xsl:text>,</xsl:text>
  <xsl:for-each select="$types">
   <xsl:sort/>
   <xsl:variable name="t" select="."/>
   <xsl:if test="string-length($t) gt 1">
    <xsl:value-of
     select="count($root/div/div[@type = 'work' and ends-with(@ana, $t) and @subtype eq 'TEI']) "/>
   </xsl:if>
   <xsl:if test="not(position() = last())">
    <xsl:text>,</xsl:text>
   </xsl:if>
  </xsl:for-each>
  <xsl:text>
</xsl:text>
  
 </xsl:template>
</xsl:stylesheet>
