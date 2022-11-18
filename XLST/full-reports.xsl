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
                <title>UFO Report Tables</title>
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
                    <h1>Full UFO Reports</h1>
                    <h2>Table of Contents</h2>
                    <ol>
                        <xsl:for-each select="$UFOReports//report">
                            <xsl:sort select="//eventLocation/@eloc"/>
                            <a href="#{//@eloc}">
                                <xsl:apply-templates select="//eventLocation" mode="toc"/>
                            </a>
                        </xsl:for-each>
                    </ol>
                    <hr/>
                    <xsl:for-each select="$UFOReports//report">

                        <xsl:sort select="//eventName"/>


                        <table id="{//@eloc}">

                            <tr style="background-color: #acdbff;">
                                <h3>Event Location: <xsl:apply-templates
                                        select='replace(//eventLocation/@eloc, "_", " ")'/></h3>
                            </tr>
                            <tr>
                                <h4>Event Name: <xsl:apply-templates select="//eventName"/></h4>
                            </tr>


                            <xsl:apply-templates select="//head"/>


                            <tr>
                                <p>
                                    <xsl:apply-templates select="//address"/>
                                </p>
                            </tr>
                            <tr>
                                <p>
                                    <xsl:apply-templates select="//body"/>
                                </p>
                            </tr>
                            <tr>
                                <p>
                                    <xsl:apply-templates select="//signature"/>
                                </p>
                            </tr>

                        </table>

                    </xsl:for-each>
                </body>
            </div>

            <div id="footer"/>

        </html>
    </xsl:template>


    <xsl:template match="//eventLocation" mode="toc">
        <li>
            <strong>
                <xsl:apply-templates select='replace(@eloc, "_", " ")'/>
            </strong>
        </li>

    </xsl:template>


    <xsl:template match="//head">
        <tr>
            <p>
                <xsl:apply-templates/>
            </p>
        </tr>

    </xsl:template>

</xsl:stylesheet>
