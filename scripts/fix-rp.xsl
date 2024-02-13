<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cmd="http://www.clarin.eu/cmd/" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="comment()" priority="1"/>
    
    <xsl:template match="cmd:ResourceRef">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="starts-with(.,'../../resources/microfiches')">
                    <xsl:variable name="rp" select="parent::cmd:ResourceProxy/@id"/>
                    <xsl:variable name="base" select="'../../resources/microfiches/'"/>
                    <xsl:variable name="p" select="/cmd:CMD/cmd:Components/cmd:Vragenlijst/cmd:Scan/cmd:Pagina[@ref=$rp]/cmd:id"/>
                    <!--
                    <xsl:variable name="v" select="/cmd:CMD/cmd:Components/cmd:Vragenlijst/cmd:identifier"/>
                    <xsl:variable name="s" select="/cmd:CMD/cmd:Components/cmd:Vragenlijst/cmd:Scan/cmd:id"/>
                    -->
                    <xsl:variable name="v" select="replace($p,'([^_]*)_.*','$1')"/>
                    <xsl:variable name="s" select="replace($p,'([^_]*_.*)-.*','$1')"/>
                    <xsl:value-of select="concat($base,$v,'/',$s,'/',$p,'.jpg')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="cmd:Resources">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
            <xsl:if test="empty(cmd:JournalFileProxyList)">
                <cmd:JournalFileProxyList/>
            </xsl:if>            
            <xsl:if test="empty(ResourceRelationList)">
                <cmd:ResourceRelationList/>
            </xsl:if>
        </xsl:copy>        
    </xsl:template>
    
    
</xsl:stylesheet>