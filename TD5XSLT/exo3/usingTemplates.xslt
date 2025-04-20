<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/concours">
        <html>
            <head>
                <title>Rssultats des Candidats</title>
            </head>
            <body>
                <h1>Resultats des Candidats</h1>
                <xsl:for-each select="grade">
                    <h2><xsl:value-of select="@nom"/></h2>
                    <xsl:for-each select="etablissement">
                        <h3><xsl:value-of select="@nom"/></h3>
                        <table border="1">
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Prenom</th>
                                <th>Moyenne Ponderee</th>
                                <th>Statut (Status)</th>
                            </tr>
                            <xsl:for-each select="candidat">
                                <xsl:variable name="totalCoef">
                                    <xsl:call-template name="sumCoefficients">
                                        <xsl:with-param name="nodes" select="matieres/matiere"/>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:variable name="totalNote">
                                    <xsl:call-template name="sumProducts">
                                        <xsl:with-param name="nodes" select="matieres/matiere"/>
                                    </xsl:call-template>
                                </xsl:variable>
                                
                                <tr>
                                    <td><xsl:value-of select="@id"/></td>
                                    <td><xsl:value-of select="nom"/></td>
                                    <td><xsl:value-of select="prenom"/></td>
                                    <td>
                                        <xsl:value-of select="format-number($totalNote div $totalCoef, '0.00')"/>
                                    </td>
                                    <td>
                                        <xsl:choose>
                                        <!-- the test loops through the elements  -->
                                        <!-- if at most one note of the exam is less than 5 the test returns true -->
                                            <xsl:when test="matieres/matiere[@note &lt; 5]">
                                                Ajourne 
                                            </xsl:when>
                                            <!-- the total note is equal to the sum of each exam note * it's according coeff -->
                                            <xsl:when test="$totalNote div $totalCoef &gt;= 10">
                                                Admis 
                                            </xsl:when>
                                            <xsl:otherwise>
                                                Ajourne
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </xsl:for-each>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    

    <xsl:template name="sumCoefficients">

        <xsl:param name="nodes"/>
        <xsl:param name="sum" select="0"/><!-- init the value of the variable using select -->
        <xsl:choose>
            <xsl:when test="count($nodes) &gt; 0">
                <xsl:variable name="first" select="$nodes[1]"/>
                <xsl:variable name="rest" select="$nodes[position() &gt; 1]"/>
                <!--select all nodes except the first one.  $nodes[position() &gt; 1] -->
                <!-- this is a recursive function that calls it self and each time it subtstracts an element until the list is empty -->
                <xsl:call-template name="sumCoefficients">
                    <xsl:with-param name="nodes" select="$rest"/>
                    <xsl:with-param name="sum" select="$sum + number($first/@coefficient)"/>  <!-- mat/@coef-->
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$sum"/>   <!-- this returns the value to our function sumCoefficients -->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="sumProducts">
        <xsl:param name="nodes"/>
        <xsl:param name="sum" select="0"/>
        <xsl:choose>
            <xsl:when test="count($nodes) &gt; 0">
                <xsl:variable name="first" select="$nodes[1]"/>
                <xsl:variable name="rest" select="$nodes[position() &gt; 1]"/>
                <xsl:call-template name="sumProducts">
                    <xsl:with-param name="nodes" select="$rest"/>
                    <xsl:with-param
                        name="sum"
                        select="$sum + (number($first/@coefficient) * number($first/@note))"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$sum"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
