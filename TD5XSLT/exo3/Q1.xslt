<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- xpath version is tied to the xslt version --> 
    <!-- xpath version 1.0 cannot multply directly the nodes  like this : -->

  <!--   <xsl:variable name="ponderee" select="sum(matieres/matiere/@coefficient * matieres/matiere/@note)"/> -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <!-- we can define the output method here but this can be overriden with the xsltproc command -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Resultats des concours</title>
        <style>
          table { border-collapse: collapse; width: 80%; margin-bottom: 40px; }
          th, td { border: 1px solid black; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; }
          h2, h3 { color: #333366; }
        </style>
      </head>
      <body>
        <h1>Resultats des concours</h1>
        <xsl:for-each select="concours/grade">
          <h2><xsl:value-of select="@nom"/></h2>
          <xsl:for-each select="etablissement">
            <h3><xsl:value-of select="@nom"/></h3>
            <table>
              <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Prenom</th>
                <th>Moyenne ponderee</th>
                <th>Statut</th>
              </tr>
              <xsl:for-each select="candidat">
                <tr>
                  <td><xsl:value-of select="@id"/></td>
                  <td><xsl:value-of select="nom"/></td>
                  <td><xsl:value-of select="prenom"/></td>
                  <xsl:variable name="total" select="sum(matieres/matiere/@coefficient)"/>
                  <xsl:variable name="ponderee" select="sum(matieres/matiere/@coefficient * matieres/matiere/@note)"/>
                  <xsl:variable name="moyenne" select="format-number($ponderee div $total, '0.00')"/>
                  <td>
                    <xsl:value-of select="$moyenne"/>
                  </td>
                  <td>
                    <!-- if atleast one note among the course is less than 5 the candidat is eliminated -->
                    <!-- therefore it is the bigger loop -->
                    <xsl:choose>
                    <!-- if  -->
                      <xsl:when test="matieres/matiere[@note &lt; 5]"> 
                        Ajourné
                      </xsl:when>
                      <!-- else -->
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="$ponderee div $total &gt;= 10">
                            Admis
                          </xsl:when>
                          <xsl:otherwise>
                            Ajourné
                          </xsl:otherwise>
                        </xsl:choose>
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

</xsl:stylesheet>
