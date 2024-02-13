<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cmd="http://www.clarin.eu/cmd/"
    version="1.0">

    <xsl:param name="rec">/Users/menzowi/Documents/Projects/VLB/huc-cmdi-app/html/ccf/data/records/inprogress/md1/metadata/old.cmdi</xsl:param>
    
    <xsl:template match="comment()"/>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="cmd:Resources">
        <xsl:copy>
            <xsl:apply-templates select="document($rec)//cmd:ResourceProxyList"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*[local-name()='cmd:Scan']" priority="10">
        <cmd:Scan ref="s">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="*[local-name()='cmd:id']"/>
            <xsl:apply-templates select="*[local-name()='cmd:commentaarScan']"/>
            <xsl:apply-templates select="*[local-name()='cmd:aantalPaginas']"/>
            <xsl:apply-templates select="*[local-name()='cmd:Pagina']">
                <xsl:sort select="*[local-name()='cmd:nr']" data-type="number"/>
            </xsl:apply-templates>
        </cmd:Scan>        
    </xsl:template>

    <xsl:template match="*[local-name()='cmd:Pagina']" priority="10">
        <cmd:Pagina ref="p{*[local-name()='cmd:nr']}">
            <xsl:apply-templates select="@*|node()"/>
        </cmd:Pagina>
    </xsl:template>
    
</xsl:stylesheet>