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
                <title>UFO Report Highlights</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
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
                        margin-top: 50px;
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
                     word-wrap: break-word;
                    
                    }
                    .centered
                    {
                    text-align: center !important;
                    
                    }
                    ol.centered li
                    {
                    text-align: left; 
                    margin-left: 10px;
                    }
                    /*Floating Back-To-Top Button*/
                    #myBtn {
                    position: fixed;
                    bottom: 50px;
                    float: right;
                    right: 18.5%;
                    left: 77.25%;
                    max-width: 80px;
                    width: 100%;
                    font-size: 12px;
                    border-color: black;
                    background-color: rgb(64,64,64);
                    padding: .5px;
                    border-radius: 4px;
                    text-decoration:none;
                    }
                    /*On Hover Color Change*/
                    #myBtn:hover {
                    background-color: #7dbbf1;
                    }
                    
                </style>
            </head>
            <body>
            <div id="header"/>
            
            <div class="container">
              
                    <h1>UFO Report Highlights</h1>
                    <h2>Table of Contents</h2>
                    
                    <div class="row">
                        <div class="col">
                        <ol class="centered">
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
                    </div>

                    <xsl:for-each select="$UFOReports//report">
                        <xsl:sort select="//eventDate/@date!tokenize(.,'/')[3]" order="descending"/>
                        <div class="row justify-content-center" id="{//@id}">
                            <div class="col">
                            </div>
                        </div>
                        <div class="row justify-content-center">
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
                                    <tr>
                                        <th>
                                            <h4>Report Date:</h4>
                                        </th>
                                        <td>
                                            <h4 style="font-weight: normal;">
                                                <xsl:apply-templates select="//eventDate//@date"/>
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <h4>Event Location:</h4>
                                        </th>
                                        <th>
                                            <h4 style="font-weight: normal;">
                                                <xsl:apply-templates select="//eventLocation"/>
                                            </h4>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>UFO Descriptions:</th>
                                        <th style="font-weight: normal; text-align: left;">
                                            <ul>
                                                <xsl:apply-templates select="//ufoDesc"/>
                                            </ul>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>Weather Conditions:</th>
                                        <th style="font-weight: normal; text-align: left;">
                                            <ul>
                                                <xsl:apply-templates select="//weather"/>
                                            </ul>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>Significant Notes:</th>
                                        <th style="font-weight: normal; text-align: left;">
                                            <ul>
                                                <xsl:apply-templates select="//event"/>
                                            </ul>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>Associated Organizations:</th>
                                        <th style="font-weight: normal; text-align: left;">
                                            <ul>
                                                <xsl:apply-templates select="//organization"/>
                                            </ul>
                                        </th>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    </xsl:for-each>
                    <button id="myBtn"><a href="#top" style="color: white">Back to Top</a></button>
                    
               
            </div>
            </body>
            <div id="footer"/>
        </html>
    </xsl:template>
    
    <xsl:template match="//eventDate" mode="toc"> 
        <strong>
            <xsl:value-of select="@date"/>           
        </strong>
    </xsl:template>

    <xsl:template match="eventLocation">

        <xsl:variable name="hyperlink">
            <xsl:apply-templates/>
        </xsl:variable>

        <a target="_blank" href="https://www.google.com/search?q={$hyperlink}">
            <xsl:apply-templates/>
        </a>

    </xsl:template>


    <xsl:template match="ufoDesc">

        <li>
            <span class="ufoDesc">
                <xsl:apply-templates/>
            </span>
        </li>

    </xsl:template>


    <xsl:template match="weather">

        <li>
            <span class="weather">
                <xsl:apply-templates/>
            </span>
        </li>

    </xsl:template>

    <xsl:template match="event">

        <li>
            <span class="event">
                <xsl:apply-templates/>
            </span>
        </li>

    </xsl:template>

    <xsl:template match="organization">

        <li>
            <span class="org">
                <xsl:apply-templates/>
            </span>
        </li>
        <!--this needs distinct values-->

    </xsl:template>




</xsl:stylesheet>
