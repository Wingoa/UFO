<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0" xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="UFOReports" select="collection('../Reports_XML/?select=*.xml')"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Reports per Year</title>
            </head>
            <body>
                
                <h1>Years</h1>
                
                <ol> <xsl:for-each-group select="$UFOReports//report" group-by="//eventDate/@date!tokenize(.,'/')[3]">
                    <xsl:sort select="//eventDate/@date!tokenize(.,'/')[3]" order="descending"/>   
                    <li><xsl:apply-templates select="//eventDate/@date!tokenize(.,'/')[3]"/><xsl:text>: </xsl:text>
                        <xsl:value-of select="count(current-group())"/>
                    </li>
                    
                </xsl:for-each-group></ol>
            </body>
        </html>
    </xsl:template>  
</xsl:stylesheet>
