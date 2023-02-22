<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="3.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xpath-default-namespace="http://www.w3.org/2005/xpath-functions"
                xmlns:mf="http://example.com/mf"
                exclude-result-prefixes="#all">

    <xsl:param name="json-uri" as="xs:string"/>

    <xsl:template name="xsl:initial-template">
        <xsl:sequence select="$json-uri => unparsed-text() => json-to-xml() => mf:apply-templates() => xml-to-json(map{'indent':true()})"/>
    </xsl:template>

    <xsl:function name="mf:apply-templates" as="node()*">
        <xsl:param name="nodes" as="node()*"/>
        <xsl:apply-templates select="$nodes"/>
    </xsl:function>

    <xsl:template match="array">
        <xsl:copy>
            <xsl:for-each-group select="map" composite="yes" group-by="string[@key = 'Category 1'], string[@key = 'Date 1'], string[@key = 'Date 2']">
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="number[@key = ('Paid', 'OS')]" expand-text="yes">
        <number key="{@key}">{sum(current-group()/number[@key = current()/@key])}</number>
    </xsl:template>

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:output method="text"/>

</xsl:stylesheet>
