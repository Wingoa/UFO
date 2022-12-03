<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0" xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="UFOReports" select="collection('../Reports_XML/?select=*.xml')"/>
    
    <xsl:variable name="counter" select="0" saxon:assignable="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Locations</title>
            </head>
            <body>
                <h1>Locations</h1>
                <ol>
                    <xsl:apply-templates select="$UFOReports//report[.//location]"/>
               </ol>
            </body>
        </html>
    </xsl:template>     
    <xsl:template match="report">
        <xsl:for-each-group select=".//location" group-by="@loc">
            <li>
                <xsl:apply-templates/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates select="ancestor::report/data(@id)"/>
            </li>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
