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
                <h1>Locations: List 1</h1>
<!--whc: This first list calls for an additional template rule below. It will give every location element, but
                    because it is structured to do so by first matching on reports, it can't be reduced to a sorted list
                    of places with each containing a list of reports that contain them.-->
                <ol>
                    <xsl:apply-templates select="$UFOReports//report[.//eventLocation]"/>
               </ol>
                
                <h1>Orgs</h1>
                <!--whc: This first list calls for an additional template rule below. It will give every location element, but
                    because it is structured to do so by first matching on reports, it can't be reduced to a sorted list
                    of places with each containing a list of reports that contain them.-->
                <ol>
                    <xsl:apply-templates select="$UFOReports//report[.//organization]" mode="org"/>
                </ol>
                
                <h1>Years</h1>
                
                <ol> <xsl:for-each-group select="$UFOReports//report" group-by="//eventDate/@date!tokenize(.,'/')[3]">
                    <xsl:sort select="//eventDate/@date!tokenize(.,'/')[3]" order="descending"/>   
                <li><xsl:apply-templates select="//eventDate/@date!tokenize(.,'/')[3]"/><xsl:text>: </xsl:text>
                    <xsl:value-of select="count(current-group())"/>
                </li>
                    
                </xsl:for-each-group></ol>
                
                <h1>Orgs2</h1>
                
                
                
        <!--        <ol> <xsl:for-each-group select="$UFOReports//report[.//organization]" 
                    group-by="//organization/@org">
                    <xsl:sort select="//organization/@org" order="descending"/>   
                    <li><xsl:apply-templates select=".//organization"/><xsl:text>: </xsl:text>
                        <xsl:value-of select="count(current-group())"/>
                    </li>
                    
                </xsl:for-each-group></ol>-->
                
                <h1>Locations: List 2</h1>
 <!--whc: the problem with the second list is that it will only give the first instance of any location in
     the whole collection. Therefore it will not give all the report numbers for each location. -->
                <ol>
                    <xsl:for-each-group select="$UFOReports//location" group-by="@loc">
                        <li><xsl:apply-templates/><ul>
                            <xsl:for-each select="ancestor::report">
                                <li><xsl:value-of select="@id"/></li>
                            </xsl:for-each>
                        </ul>
                        </li>
                    </xsl:for-each-group>
                </ol>
            </body>
        </html>
    </xsl:template>  
    
    <xsl:template match="report">
        <xsl:for-each-group select=".//eventLocation" group-by="@eloc">
            <li>
                <xsl:apply-templates/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates select="ancestor::report/data(@id)"/>
            </li>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="report" mode="org">
        <xsl:for-each-group select=".//organization" group-by="@org">
            <li>
                <xsl:apply-templates/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates select="ancestor::report/data(@id)"/>
            </li>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
