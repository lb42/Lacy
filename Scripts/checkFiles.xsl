<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  version="2.0">
  <xsl:output omit-xml-declaration="yes" method="text"/>

  <!-- run 
saxon catalogue.xml checkFiles.xsl to

(a) produce shell script '$root/fileCheck.sh' 
(this checks that each file specified as a local copy actually exists)

(b) report on location codes used in local copy filenames

 -->

  <xsl:param name="root">/home/lou/Data/Lacy/</xsl:param>
  <xsl:variable name="outFile">
    <xsl:value-of select="concat($root, 'fileCheck.sh')"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:variable name="context" select="."/>
    <xsl:result-document href="{$outFile}">
      <xsl:for-each select="//*:div">
        <xsl:for-each select="*:bibl/*:note[@type = 'localCopies']/*:ident">
          <xsl:variable name="file">
            <xsl:value-of select="."/>
          </xsl:variable>
          <xsl:if test="not(contains($file, 'ages'))">
            <xsl:text>if ! test -f </xsl:text>
            <xsl:value-of select="$file"/>
            <xsl:text>; then echo "</xsl:text>
            <xsl:value-of select="$file"/>
            <xsl:text> not found"; fi; 
</xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:for-each
      select="distinct-values(//*:ident/substring-before(substring-after(., '-'), '.pdf'))">
      <xsl:sort/>
      <xsl:variable name="f" select="concat('-', ., '.pdf')"/>
      <xsl:message>
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="count($context//*:ident[ends-with(., $f)])"/>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
