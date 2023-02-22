<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="3.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                xmlns:mf="http://example.com/mf"
                exclude-result-prefixes="#all">

    <xsl:function name="mf:group" as="map(*)*">
        <xsl:param name="maps" as="map(*)*"/>
        <xsl:for-each-group select="$maps" composite="yes" group-by=".('Category 1'), .('Date 1'), .('Date 2')">
            <xsl:sequence select=". => map:put('Paid', sum(current-group()?Paid)) => map:put('OS', sum(current-group()?OS))"/>
        </xsl:for-each-group>
    </xsl:function>

    <xsl:template match=".[. instance of array(map(*))]">
        <xsl:sequence
                select="array { mf:group(?*) }"/>
    </xsl:template>

    <xsl:output method="json" indent="yes"/>

</xsl:stylesheet>
