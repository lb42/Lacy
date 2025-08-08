<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:t="http://www.tei-c.org/ns/1.0"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
exclude-result-prefixes="xs t"
version="2.0">

<xsl:template match="div/bibl">
<div type="work" xml:id="{@xml:id}"   ana="{@ana}" xmlns="http://www.tei-c.org/ns/1.0" >
<xsl:variable name="status" select="@status"/>
<xsl:if test="$status"><xsl:attribute name="subtype" select="@status"/></xsl:if>
<xsl:variable name="root" select="."/>

<bibl type="printSource" n="{@n}">

<xsl:apply-templates/>
<title xmlns="http://www.tei-c.org/ns/1.0" level="s">
Lacy's Acting Edition, volume <xsl:value-of 
select="substring-before(@n,'.')"/>, No. <xsl:value-of select="substring-after(@xml:id,'L')"/> </title>
<xsl:copy-of select="idno"/>
</bibl>

<xsl:variable name="Vc" select="count(listRef/ref[contains(@target,'-vpp')])"/>
<xsl:variable name="Uc" select="count(listRef/ref[contains(@target,'-um')])"/>

<xsl:for-each select="listRef/ref">
<bibl type="digitalSource"  xmlns="http://www.tei-c.org/ns/1.0">
<xsl:choose>
<xsl:when test="contains(@target,'-vpp')">
<xsl:attribute name="subtype">copy</xsl:attribute>
</xsl:when>
<xsl:when test="contains(@target,'mdp.') and not($Vc)">
<xsl:attribute name="subtype">copy</xsl:attribute>
</xsl:when>
</xsl:choose>
<xsl:copy-of select="."/>
<xsl:choose>
<xsl:when test="contains(@target,'mdp.')">
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'um.pdf')]"/>
<xsl:choose><xsl:when test="$f"><ref target="{concat('local:',$f)}"/></xsl:when>
<xsl:otherwise>
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'gb.pdf')]"/>
<ref target="{concat('local:',$f)}"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="contains(@target,'vpp')">
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'vpp.pdf')]"/>
<ref target="{concat('local:',$f)}"/>
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[contains(.,'/Vol')]"/>
 <xsl:if test="$f"><ref target="{concat('local:',$f)}"/></xsl:if><!-- allows for possibility that there is no VPP PDF file -->
</xsl:when>
<xsl:when test="contains(@target,'hvd') or starts-with(.,'HV')">
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'-hv.pdf')]"/>
<xsl:if test="$f"><ref target="{concat('local:',$f)}"/></xsl:if>
</xsl:when>
<xsl:when test="starts-with(.,'UW ')">
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'-uw.pdf')]"/>
<ref target="{concat('local:',$f)}"/>
</xsl:when>
<xsl:when test="starts-with(.,'UC ')">
<xsl:variable name='f' select="$root/note[@type='localCopies']/ident[ends-with(.,'-uc.pdf')]"/>
<xsl:if test="$f"><ref target="{concat('local:',$f)}"/></xsl:if>
</xsl:when>
</xsl:choose>
</bibl>
</xsl:for-each>

<xsl:comment><xsl:for-each select="note[@type='localCopies']/ident">
<ref target="{concat('local:',.)}"/></xsl:for-each></xsl:comment>

<xsl:if test="eventName">
<listEvent xmlns="http://www.tei-c.org/ns/1.0">
 
 <xsl:for-each select="eventName[@type eq 'LCP']">
  
  <xsl:variable name="LCPid" select="substring-before(substring-after(.,'LCP_'),')')"/>
  
  <event type="{@type}" >
   
   <xsl:if test="@when">
    <xsl:attribute name="when" select="@when"/>
   </xsl:if>
   
   <xsl:if test="@n">
    <xsl:attribute name="where" select="@n"/>
   </xsl:if>
   <desc xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:value-of select="doc('/home/lou/Public/Lacy/LacyLCP.xml')//*:bibl[starts-with(@n,$LCPid)]/*:licence"/>
   </desc>
   <bibl type="msSource"><xsl:value-of select="substring-before(substring-after(.,'('),')')"/></bibl>
  </event> 
  
 </xsl:for-each>
<!-- firstPerf events -->
<xsl:for-each select="eventName[@type='firstPerf']">
<xsl:variable name="dateNic" select="date[@source='nicoll']/@when"/>
<xsl:variable name="dateSrc" select="date[@source='text']/@when"/>
<xsl:variable name="dateNix" select="date[contains(.,'n.d.')]"/>

<xsl:variable name="fullName" select="replace(name,'\n',' ')"/>
<xsl:variable name="nName" select="concat(t:normName($fullName),' ')"/>
<xsl:variable name="where" select="substring-before($nName,' ')"/>
<xsl:if test="$where ne $fullName">
<xsl:message> <xsl:value-of select="$where"/>  ..  <xsl:value-of select="$fullName"/> </xsl:message>
</xsl:if>
<xsl:if test="$dateNic or $dateSrc">
<xsl:choose>
<!-- @when is available on both nicoll and source -->
<xsl:when test="$dateNic eq $dateSrc">
<event type="{@type}"  when="{date[@source='nicoll']/@when}" source="textNic" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/></desc>
</event></xsl:when>
<xsl:when test="starts-with($dateNic,$dateSrc) and $dateSrc">
<event type="{@type}" when="{date[@source='nicoll']/@when}" source="textNicStart" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/></desc>
</event>
</xsl:when>
<xsl:when test="starts-with($dateSrc,$dateNic)">
<event type="{@type}"  when="{date[@source='text']/@when}" source="nicTextStart" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/></desc>
</event>
</xsl:when>
<xsl:when test="$dateNic ne $dateSrc">
<event type="{@type}"  when="{$dateSrc}" source="text" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/>; Nicoll date <xsl:value-of select="$dateNic"/></desc>
</event></xsl:when>
<!-- @when is available on only one of nicoll and source -->
<xsl:when test="not($dateSrc) and $dateNic">
<event type="{@type}"  when="{date[@source='nicoll']/@when}" source="nicoll" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/></desc>
</event></xsl:when>
<xsl:when test="not($dateSrc)">
<event type="{@type}" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/>; date unknown</desc>
</event>
</xsl:when><xsl:when test="not($dateNic) and $dateSrc">
<event type="{@type}" when="{date[@source='text']/@when}" source="text" where="{$where}">
<desc>Premiered at <xsl:value-of select="name"/></desc>
</event>
</xsl:when>
<xsl:otherwise>

</xsl:otherwise>
</xsl:choose>
</xsl:if>

<xsl:if test="date[contains(.,'n.d.')]">
<event type="{@type}" source="text">
<desc>Premiered at <xsl:value-of select="name"/>; date unknown.</desc>
</event>
</xsl:if>

</xsl:for-each>

<!-- LCP events -->



<!-- otherPerf events -->

<xsl:for-each select="note[@type='otherPerfs']">
<event type='otherPerf'><desc><xsl:copy-of select="node()|text()"/></desc></event>
</xsl:for-each>
</listEvent></xsl:if>

</div>
</xsl:template>


<!-- suppress already processed parts of bibl -->

<xsl:template match="div/bibl/eventName"/>
<xsl:template match="div/bibl/listRef"/>
<xsl:template match="div/bibl/idno"/>
<xsl:template match="div/bibl/note[@type='otherPerfs']"/>
<xsl:template match="div/bibl/note[@type='localCopies']"/>


<!-- clone remaining input -->

<xsl:template match="/ | @* | node()">
<xsl:copy>
<xsl:apply-templates select="@* | node()"/>
</xsl:copy>
</xsl:template>

<!-- normalize name -->
<xsl:function name="t:normName">
<xsl:param name="n"/>
<xsl:variable name="result" select="normalize-space($n)"/>
<xsl:choose>
<xsl:when test="$result=''">Unknown</xsl:when>
<xsl:when test="contains($result,'Cambridge')">Cambridge</xsl:when>
<xsl:when test="contains($result,'Cremorne')">Cremorne</xsl:when>
<xsl:when test="contains($result,'Covent')">Covent</xsl:when>
<xsl:when test="contains($result,'Drury')">Drury</xsl:when>
<xsl:when test="contains($result,'Adelphi')">Adelphi</xsl:when>
<xsl:when test="contains($result,'Haymarket')">Haymarket</xsl:when>
<xsl:when test="contains($result,'Martin')">Martin</xsl:when>
<xsl:when test="contains($result,'Surrey')">Surrey</xsl:when>
<xsl:when test="starts-with($result,'Theatre Royal, ')"><xsl:value-of select="substring-after($result,'Theatre Royal, ')"/></xsl:when>
<xsl:when test="starts-with($result,'Royal ')"><xsl:value-of select="substring-after($result,'Royal ')"/></xsl:when>
<xsl:when test="starts-with($result,'New ')"><xsl:value-of select="substring-after($result,'New ')"/></xsl:when>
<xsl:otherwise><xsl:value-of select="$result"/></xsl:otherwise>
</xsl:choose>

</xsl:function>

</xsl:stylesheet>
