<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="UFOreports" select="collection('../Reports_XML/?select=*.xml')"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>UFO Report Dates</title>
            </head>
            <body>
                <h1>UFO Report Dates</h1>
                <ul>
                    <xsl:apply-templates select="$UFOreports//report//eventDate"/>
                </ul>
                <xsl:apply-templates select="$UFOreports//report"/>
 <!--           <ol>
                <xsl:for-each-group select="$UFOReports//eventDate" group-by="@date">
                    <li><xsl:apply-templates/>
                        <ul>
                            <xsl:for-each select="ancestor::report">
                                <li><xsl:value-of select="@id"/>
                    </li>
                            </xsl:for-each>
                        </ul>
                    </li> 
                            
                </xsl:for-each-group>
            </ol>!-->
             
<!--Keep getting error message here. I was trying to get a list of all the reports containing each event date. !-->   
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="eventDate">
        <li>
            <strong>
                <xsl:apply-templates select="@date"/>
            </strong>
        </li>
    </xsl:template>   
<!-- Just a list of all the report dates !-->    
   
    <xsl:template match="report">
        <li>
            <strong>
                <xsl:apply-templates select="@id"/>
            </strong>
        </li>
    </xsl:template> 
    
<!--Just a list of all report id's. I was trying to figure out how to get a list of reports with dates. !-->
    
    <!-- <xsl:template match="report">
            <strong>
                <xsl:value-of select="count(eventDate)"/>
            </strong>
        
    </xsl:template>  !-->
    
    

</xsl:stylesheet>
