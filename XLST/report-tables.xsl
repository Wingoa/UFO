<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">

    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>

    <xsl:variable name="UFOReports" select="collection('../Reports_XML/?select=*.xml')"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>UFO Report List</title>
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
                    }</style>
            </head>
            <div id="header"/>
            <div class="container">
                <body>
                    <h1>UFO Report List</h1>

                    <xsl:for-each select="$UFOReports//report">
                        <div class="row justify-content-center">
                            <div class="col">
                                <table>

                                    <tr style="background-color: #acdbff;">
                                        <th>
                                            <h3>
                                                <!-- Would be cool to get this to work//counting the reports <xsl:value-of select="count(preceding::$UFOReports) + 1"/>.-->
                                                Event Name / Report ID:</h3>
                                        </th>
                                        <th>
                                            <h3><xsl:apply-templates select="//eventName"/> /
                                                  <xsl:apply-templates select="//report//@id"/></h3>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>
                                            <h4>Report Date:</h4>
                                        </th>
                                        <td>
                                            <h4 style="font-weight: normal;">
                                                <xsl:apply-templates select="//eventDate//@date"/> <!-- this needs to be value of -->
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


                </body>

            </div>
            <div id="footer"/>
        </html>
    </xsl:template>

    <xsl:template match="eventLocation">

        <a target="_blank" href="https://www.google.com/search?q=">
            <!-- Need to apply template in here -->
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
