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
                <title>Full UFO Reports</title>
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
                    td
                    {
                        border: 1px solid black;
                        font-family: 'Courier New', Courier, monospace !important;
                        text-align: left !important;
                        padding-left: 20px;
                    }
                    tr {
                        height: 25px;
                        border-bottom: 2px solid;
                    
                    }
                    tr:hover {
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.8);
                    }
                    th {
                        width: 200px;
                        text-transform: capitalize;
                    }
                    td {
                        width: 250px;
                        padding-right: 50px;
                    }
                    table {
                        background-color: #ffffff;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.8);
                        width: 80%;
                        margin-left: auto;
                        margin-right: auto;
                        border-collapse: collapse;
                    
                    }
                    h1 {
                        font-family: 'Courier New', Courier, monospace;
                    }
                    ol {
                    columns: 4 !important;
                    -webkit-columns: 4 !important;
                    -moz-columns: 4 !important;
                    text-align: left !important;
                       
                    }
                    .center
                    {
                    text-align: center !important;
                    
                    }
                    o1.center li
                    {
                    text-align: left; 
                    margin-left: 45%;
                    }
                </style>
            </head>
            <div id="header"/>
            <div class="container">
                <body>
                    <h1>Full UFO Reports</h1>
                    <h2>Table of Contents</h2>
                   <div class="row">
                    <ol class="center">
                        <xsl:for-each select="$UFOReports//report">
                       
                            <xsl:sort select="//eventDate/@date!tokenize(.,'/')[3]" order="descending"/>
                            <li>
                            <a href="#{//@id}"  style="font-size:x-large;">
                                <xsl:apply-templates select="//eventDate" mode="toc"/>
                            </a>
                            </li>
                        </xsl:for-each>
                    </ol>
                       
                            <hr/>
                   </div>
                    

                    <xsl:for-each select="$UFOReports//report">
                        <xsl:sort select="//eventName"/>
                      
                        <div class="row justify-content-center" id="{//@id}">
                            <div class="col">
                                <table>
                             
                                    <tr style="background-color: #acdbff;">
                                        <th>
                                            <h3>
                                                <saxon:assign name="counter" select="$counter + 1"/>
                                                <xsl:value-of select="$counter"/>. Event Name:</h3>
                                        </th>
                                        <th>
                                            <h3>
                                                <xsl:apply-templates select="//eventName"/>
                                            </h3>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>
                                            <h4>Report ID:</h4>
                                        </th>
                                        <td>
                                            <h4 style="font-weight: normal;">
                                                <a  href="..//..//Reports_PDF/{//@id}.pdf" target="_blank"><xsl:apply-templates select="//report//@id"/></a> 
                                            </h4>
                                        </td>
                                    </tr>


                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <h4 style="font-weight: normal;">
                                                <xsl:apply-templates select="//report"/>
                                            </h4>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>

                    </xsl:for-each>


                </body>

            </div>
            <div id="footer"/>
        </html>
    </xsl:template>


    <xsl:template match="//eventDate" mode="toc"> 
            <strong>
                <xsl:value-of select="@date"/>           
            </strong>
    </xsl:template>
    
    <xsl:template match="//eventDate">
        <span style="color:purple; font-weight: bold;">
            <xsl:value-of select="@date"/>           
       </span>
        
    </xsl:template>
    
    <xsl:template match="//ufoDesc">
        <span style="color:blue; font-weight: bold;">
            <xsl:apply-templates/>        
        </span>
        
    </xsl:template>
    
    <xsl:template match="//organization">
        <span style="color:green; font-weight: bold;">
            <xsl:apply-templates/>        
        </span>
        
    </xsl:template>

    <xsl:template match="//report">

        <p>
            <xsl:apply-templates select="//head"/>
        </p>

        <p>
            <xsl:apply-templates select="//address"/>
        </p>


        <p>
            <xsl:apply-templates select="//body"/>
        </p>


        <p>
            <xsl:apply-templates select="//signature"/>
        </p>



    </xsl:template>



</xsl:stylesheet>
