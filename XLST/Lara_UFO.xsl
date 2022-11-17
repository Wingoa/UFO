<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="UFOreports" select="collection('../Reports_XML/?select=*.xml')"/> 
    
    <xsl:template match="/">
        <html>
            <head><title>UFO Reports</title></head>
            <body>     
                <h1>UFO Reports</h1>
                <h2>Table of Contents</h2>
                <ul><xsl:apply-templates select="$UFOreports//eventDate" mode="toc"/></ul>
                <hr/>
                <xsl:apply-templates select="$UFOreports//report"/> 
            </body>
            
        </html>
    </xsl:template>
    
    <xsl:template match="eventDate" mode="toc">
        <li><strong><xsl:apply-templates select="@date"/></strong>
        </li>
        
    </xsl:template>
    
    <xsl:template match="report">
        <h2><xsl:value-of select="descendant::eventDate/@date"/>
        </h2>
        
        <xsl:apply-templates select="body"/>
    </xsl:template>
    
    <xsl:template match="body">
        <p><xsl:apply-templates/></p>
    </xsl:template>
</xsl:stylesheet>
