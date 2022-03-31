<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e t" version="2.0">

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

   <xsl:template match="note[@type='firstPerf']">
       <note type="firstPerf" xmlns="http://www.tei-c.org/ns/1.0">
        <name><xsl:value-of select="."/></name>
       <xsl:text>
</xsl:text><xsl:copy-of select="../date"/>
       </note>
   </xsl:template>
    
    <xsl:template match="bibl[ref]">
        <bibl xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        <note type="digitizations" xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="ref">
                <xsl:copy-of select="."/>    
                </xsl:for-each>              
            </note>
        </bibl>
    </xsl:template>
         
         <xsl:template match="author">
             <author xmlns="http://www.tei-c.org/ns/1.0">
                 <xsl:apply-templates/>
             </author>
             <xsl:if test="note">
                 <note type="authorInfo" xmlns="http://www.tei-c.org/ns/1.0">
                     <xsl:value-of select="normalize-space(note)"/>
                 </note>
             </xsl:if>
         </xsl:template>
         
         <xsl:template match="title[@type='sub']">
             <subtitle xmlns="http://www.tei-c.org/ns/1.0">
                 <xsl:attribute name="acts">
                     <xsl:analyze-string select="." regex="in\s*(\d)\s[Aa]ct">
                 <xsl:matching-substring>
                      <xsl:value-of select="regex-group(1)"/>
                 </xsl:matching-substring>
       <!--        <xsl:non-matching-substring>0</xsl:non-matching-substring>
      -->               </xsl:analyze-string></xsl:attribute>
                 <xsl:attribute name="type">
                     <xsl:analyze-string select="." regex="(Comedy|Farce|Tragedy|Drama|Burlesque|Pantomime)">
                         <xsl:matching-substring>
                             <xsl:value-of select="regex-group(1)"/>
                         </xsl:matching-substring>
                     </xsl:analyze-string>
                 </xsl:attribute>
                 <xsl:apply-templates/>
             </subtitle>
                 
             
         </xsl:template>
         
         
         
     <xsl:template match="author/note"/>
    <xsl:template match="date"/>
    <xsl:template match="bibl/ref"/>
    
    <xsl:function name="functx:contains-any-of" as="xs:boolean"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="searchStrings" as="xs:string*"/>
        
        <xsl:sequence select="
            some $searchString in $searchStrings
            satisfies contains($arg,$searchString)
            "/>
        
    </xsl:function>
    
</xsl:stylesheet>
