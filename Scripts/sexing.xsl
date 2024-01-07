<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs t"
 version="2.0">
 <xsl:template match="t:castItem[t:actor]">
  <castItem xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:variable name="role">
    <xsl:value-of select="t:case(t:role)"/>
   </xsl:variable>
  
   <role> 
 <!--   <xsl:message><xsl:value-of select="$role"/> </xsl:message>
-->    <xsl:attribute name="gender">
     <xsl:choose>
      <xsl:when test="starts-with($role,'Mrs')">F</xsl:when>
      <xsl:when test="starts-with($role,'Miss')">F</xsl:when>
      <xsl:when test="starts-with($role,'Madam')">F</xsl:when>
      <xsl:when test="starts-with($role,'Mademoiselle')">F</xsl:when>
      <xsl:when test="starts-with($role,'Lady')">F</xsl:when>     
      <xsl:when test="starts-with($role,'Mr')">M</xsl:when>
      <xsl:when test="starts-with($role,'Lord')">M</xsl:when>
      <xsl:when test="starts-with($role,'Capt')">M</xsl:when>
      <xsl:when test="starts-with($role,'A ')">M</xsl:when> 
      <xsl:when test="starts-with($role,'Count')">M</xsl:when>     
      
      <xsl:when test="starts-with($role,'Sir')">M</xsl:when>
      <xsl:when test="starts-with($role,'Tom')">M</xsl:when>
      <xsl:when test="starts-with($role,'Mar')">F</xsl:when> 
      <xsl:otherwise>?</xsl:otherwise>
     </xsl:choose>
    </xsl:attribute>
    <xsl:choose><xsl:when test="contains($role,'(')">
     <xsl:value-of select="substring-before($role,'(')"/>
    </xsl:when>
    <xsl:otherwise><xsl:value-of select="$role"/>
    </xsl:otherwise></xsl:choose>
   </role>
   <xsl:if test="contains($role,'(')">
    <roleDesc><xsl:value-of select="concat('(',substring-after($role,'('))"/></roleDesc>
  </xsl:if>
   <xsl:for-each select="t:actor"> 
    <xsl:variable name="actor">
    <xsl:value-of select="t:case(.)"/>
   </xsl:variable>

<actor>
  <!--  <xsl:message><xsl:value-of select="$actor"/> </xsl:message>
 -->    <xsl:attribute name="sex">
      <xsl:choose>
       <xsl:when test="starts-with($actor,'Mrs')">F</xsl:when>
       <xsl:when test="starts-with($actor,'Miss')">F</xsl:when>
       <xsl:when test="starts-with($actor,'Madam')">F</xsl:when>
       <xsl:when test="starts-with($actor,'Mademoiselle')">F</xsl:when>
       <xsl:when test="starts-with($actor,'Mr')">M</xsl:when>
       <xsl:otherwise>?</xsl:otherwise>
      </xsl:choose>
     </xsl:attribute>
 <xsl:value-of select="$actor"/>
</actor>   
   </xsl:for-each>
  </castItem><xsl:text>
</xsl:text>
 </xsl:template>
 
  <xsl:function name="t:case">
   <xsl:param name="s"/>
   <xsl:for-each select="tokenize($s)">
    <xsl:value-of select="concat(upper-case(substring(.,1,1)), lower-case(substring(.,2)),' ')"/>
   </xsl:for-each>
  </xsl:function>
 
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>