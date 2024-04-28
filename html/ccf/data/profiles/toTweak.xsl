<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="ComponentSpec">
        <xsl:copy>
            <xsl:namespace name="cue" select="'http://www.clarin.eu/cmd/cues/1'"/>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="Component|Element">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@name"/>
            <xsl:choose>
                <xsl:when test="empty(*)">
                    <xsl:comment>cues</xsl:comment>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node() except ValueScheme"/>        
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>