<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cmd="http://www.clarin.eu/cmd/"
    version="1.0">

    <xsl:param name="rec">/Users/menzowi/Documents/Projects/VLB/huc-cmdi-app/html/ccf/data/records/inprogress/md1/metadata/old.cmdi</xsl:param>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:comment>identity</xsl:comment>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="cmd:Resources">
        <xsl:comment>cmd:Resources</xsl:comment>
        <xsl:copy-of select="document($rec)//cmd:Resources"/>
    </xsl:template>

    <xsl:template match="cmd:Vragenlijst">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:comment>cmd:Vragenlijst</xsl:comment>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="cmd:Scan" priority="10">
        <xsl:comment>cmd:Scan</xsl:comment>
        <cmd:Scan ref="s">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="cmd:id"/>
            <xsl:apply-templates select="cmd:commentaarScan"/>
            <xsl:apply-templates select="cmd:aantalPaginas"/>
            <xsl:apply-templates select="cmd:Pagina">
                <xsl:sort select="cmd:nr" data-type="number"/>
            </xsl:apply-templates>
        </cmd:Scan>        
    </xsl:template>

    <xsl:template match="cmd:Pagina" priority="10">
        <xsl:comment>cmd:Pagina</xsl:comment>
        <cmd:Pagina ref="p{cmd:nr}">
            <xsl:apply-templates select="@*|node()"/>
        </cmd:Pagina>
    </xsl:template>
    
</xsl:stylesheet>