<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
    exclude-result-prefixes="xs t"
    version="2.0">

  <!-- transfers data about extent (page count and range)  
      from the UMtitles.xml file into the catalogue -->
  
  
      <xsl:param name="extraFile">UMtitles.xml</xsl:param>
    
        <xsl:template match="/ | @* | node()">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:template>
    
  <xsl:template match="body/div/bibl">
      <xsl:variable name="currentBib" select="@xml:id"/>
      <xsl:variable name="currentVol" select="substring-before(parent::*:div/@n, '/')"/>
      
      <xsl:copy>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates/>
       <xsl:if test="document($extraFile)/*:vols/*:vol/*:title[@xml:id=$currentBib]/@pp gt '0'">    
          <note type="UM_extent" xmlns="http://www.tei-c.org/ns/1.0">
              <xsl:value-of select="document($extraFile)/*:vols/*:vol/*:title[@xml:id=$currentBib]/@pp"/>
              <xsl:text> pp (</xsl:text>
              <xsl:value-of select="document($extraFile)/*:vols/*:vol/*:title[@xml:id=$currentBib]/@from"/>
              <xsl:text> - </xsl:text>
              <xsl:value-of select="document($extraFile)/*:vols/*:vol/*:title[@xml:id=$currentBib]/@to"/>
              <xsl:text>)</xsl:text>
          </note>          
       </xsl:if>
      </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
