<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg"> 
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="UFOReports" select="collection('../Reports_XML/?select=*.xml')"/>

    <xsl:variable name="Interval" select="40"/>
    
    <xsl:template match="/">
        <svg width="100%" height="100%">
            <g transform="translate(60,575)">
                <text x="375" y="-450" text-anchor="middle"> Number of UFO Reports per Year</text>
                <line x1="20" x2="20" y1="0" y2="-450" stroke="black" stroke-width="1"/>
                <line x1="20" x2="750" y1="0" y2="0" stroke="black" stroke-width="1"/>
                <text x="20" y="30" text-anchor="middle">0</text>
                <text x="100" y="30" text-anchor="middle">3</text>
                <text x="180" y="30" text-anchor="middle">6</text>
                <text x="260" y="30" text-anchor="middle">9</text>
                <text x="340" y="30" text-anchor="middle">12</text>
                <text x="420" y="30" text-anchor="middle">15</text>
                <text x="500" y="30" text-anchor="middle">18</text>
                <text x="580" y="30" text-anchor="middle">21</text>
                <text x="660" y="30" text-anchor="middle">24</text>
                
    <xsl:for-each-group select="$UFOReports//report" group-by="//eventDate/@date!tokenize(.,'/')[3]">
        
        <xsl:variable name="xPos" select="count(current-group())*27"/>
        <xsl:variable name="yPos" select="position()*$Interval"/>
        
        <text x="-30" y="{-$yPos + 15}" text-anchor="middle"> <xsl:value-of select="//eventDate/@date!tokenize(.,'/')[3]"/></text>
        
        <rect x="21" y="-{$yPos}" height="20" width="{count(current-group())*27}" stroke="black" stroke-width="2" fill="blue"/>
        <text x="{$xPos + 30}" y="{-$yPos + 15}"><xsl:value-of select="count(current-group())"/></text>
    </xsl:for-each-group>
            </g>
        </svg>
    </xsl:template>

</xsl:stylesheet>