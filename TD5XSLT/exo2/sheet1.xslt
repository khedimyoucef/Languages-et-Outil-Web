<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.1">
      <xsl:output method="html" indent="yes"/>
      <!-- can be overriden by the terminal xsltproc command-->

    <xsl:template match="/">
        <html>
            <head>
                <title>Pays avec population entre 9 et 10 millions</title>
            </head>
            <body>
                <h2>Pays avec population entre 9 et 10 millions</h2>
                <ul>
                    <xsl:for-each select="mondial/country">
                        <xsl:variable name="lastPopulation" select="population[last()]" />
                        <xsl:if test="$lastPopulation &gt;= 9000000 and $lastPopulation &lt;= 10000000">
                            <li>
                                <strong><xsl:value-of select="name"/></strong><br/>
                                Population: <xsl:value-of select="$lastPopulation"/><br/>
                                Année: <xsl:value-of select="$lastPopulation/@year"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

