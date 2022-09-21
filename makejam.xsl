<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"   
    exclude-result-prefixes="xs t"
    version="2.0">
         
   <!-- 
         input ~/Public/Lacy/doneVols.xml 
         output pdfjam commands to be run inside ~/Data/Lacy
       -->
    
     <xsl:template match="*:vols/*:vol">
      <xsl:variable name="volNo">  <xsl:value-of select="@n"/>
      </xsl:variable>  
         <xsl:for-each select="*:title">
             <xsl:value-of select='concat("pdfjam -o Vol", $volNo, "/",@xml:id, " HTvols/vol",$volNo,".pdf ",
                 @from,"-",@to)'/><xsl:text>
</xsl:text>
         </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>