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
          <h1>All Locations Mentioned Inside UFO Reports</h1>
              <h2>Event Locations:</h2>
        <ul><xsl:apply-templates select="$UFOreports//report//eventLocation"/></ul>
              <h2>All Other Locations:</h2>
              <ul><xsl:apply-templates select="$UFOreports//report//location" mode="list"/>
              </ul>
              <xsl:for-each select="$UFOreports//report">
                  <xsl:sort select="location"></xsl:sort>
              </xsl:for-each>
              <!--I was trying to sort the locations in alphabetical order !-->
          </body>
      </html>
    </xsl:template>
          
    
    <xsl:template match="eventLocation">
        <li><strong><xsl:apply-templates select="@eloc"/></strong>
        </li>
    
    </xsl:template>
    
    
    <xsl:template match="location" mode="list">
       
        <li><strong><xsl:apply-templates select="@loc"/></strong>
        </li>
        
    </xsl:template>
    
    <xsl:template match="location">           
        <ul> 
            <xsl:for-each select="//report//eventLocation[not(.=preceding::*)]">
                <li>
                    <xsl:value-of select="."/>
                </li>   
            </xsl:for-each>            
        </ul>
    </xsl:template>
    <!--I couldn't figure out how to use distinct values. This is the closest I could find online. !-->
</xsl:stylesheet>

