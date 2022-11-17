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
            <head><title>UFO Reports</title>
                <link type="text/css" href="../style.css" rel="stylesheet"/>
                <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"/>
                <script>
                    $(function () {
                    $("#header").load("header.html");
                    $("#footer").load("footer.html");
                    });
                </script>
                <style>
                    table,
                    th,
                    td {
                    border: 1px solid black;
                    font-family: 'Courier New', Courier, monospace !important;
                    }
                    tr {
                    height: 25px !important;
                    border-bottom: 2px solid !important;
                    
                    }
                    tr:hover {
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.8) !important;
                    }
                    th {
                    width: 200px !important;
                    text-transform: capitalize !important;
                    }
                    td {
                    width: 250px !important;
                    padding-right: 50px !important;
                    }
                    table {
                    background-color: #ffffff !important;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.8) !important;
                    margin-top: 50px !important;
                    width: 80% !important;
                    margin-left: auto !important;
                    margin-right: auto !important;
                    border-collapse: collapse !important;
                    
                    }
                    h1 {
                    font-family: 'Courier New', Courier, monospace !important;
                    }
                </style>
              
            </head>
          
           
            <div id="header"/>
            <div class="container">
            <body>     
                <h1>Full UFO Reports</h1>
                <h2>Table of Contents</h2><ol>
                <xsl:for-each select="$UFOreports//report">
                    <xsl:sort select="//eventLocation/@eloc"/>               
                    <a href="#{//@eloc}"><xsl:apply-templates select="//eventLocation" mode="toc"/></a>
                </xsl:for-each>
                </ol>
                <hr/>
                <xsl:apply-templates select="$UFOreports//report" mode="two"/> 
            </body>
            </div>
            <div id="footer"/>
        </html>
    </xsl:template>
    
    <xsl:template match="//eventLocation" mode="toc">
        <li><strong><xsl:apply-templates select='replace(@eloc,"_"," ")'/></strong>
        </li>
        
    </xsl:template>
        
    <xsl:template match="$UFOreports//report" mode="two">
      <table id="{//@eloc}" style="background-color:white;">
          <tr style="background-color: #acdbff;"><h3>Event Location: <xsl:apply-templates select='replace(//eventLocation/@eloc,"_"," ")'/></h3></tr>
          <tr><h4>Event Name: <xsl:apply-templates select="//eventName"/></h4></tr>
          <tr><p><xsl:apply-templates select="//head"/></p></tr>
          <tr><p><xsl:apply-templates select="//address"/></p></tr>
          <tr><p><xsl:apply-templates select="//body"/></p></tr>
          <tr><p><xsl:apply-templates select="//signature"/></p></tr>
      </table>
        
    </xsl:template>
</xsl:stylesheet>  
