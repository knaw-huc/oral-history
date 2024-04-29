<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:csv="https://di.huc.knuw.nl/ns/csv"
    exclude-result-prefixes="xs csv"
    version="2.0">
    
    <xsl:param name="csv"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="csv:getTokens" as="xs:string+">
        <xsl:param name="str" as="xs:string"/>
        <xsl:analyze-string select="concat($str, ',')" regex='(("[^"]*")+|[^,]*),'>
            <xsl:matching-substring>
                <xsl:sequence select='replace(regex-group(1), "^""|""$|("")""", "$1")'/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <xsl:template name="main">
        <csv>
            <xsl:choose>
                <xsl:when test="unparsed-text-available($csv)">
                    <xsl:variable name="tab" select="unparsed-text($csv)"/>
                    <xsl:variable name="lines" select="tokenize($tab, '(\r)?\n')" as="xs:string+"/>
                    <xsl:variable name="elemNames" select="csv:getTokens($lines[1])" as="xs:string+"/>
                    <xsl:message>DBG: CSV[<xsl:value-of select="$csv"/>] headers[<xsl:value-of select="string-join($elemNames,',')"/>]</xsl:message>
                    <xsl:for-each select="$lines[position() &gt; 1][normalize-space(.) != '']">
                        <xsl:variable name="line" select="position()"/>
                        <xsl:message>DBG: CSV[<xsl:value-of select="$csv"/>][<xsl:value-of select="$line"/>][<xsl:value-of select="."/>]</xsl:message>
                        <r l="{$line}">
                            <xsl:variable name="lineItems" select="csv:getTokens(.)" as="xs:string+"/>
                            <xsl:if test="count($lineItems)!=count($elemNames)">
                                <xsl:message terminate="yes">ERR: CSV[<xsl:value-of select="$csv"/>] line[<xsl:value-of select="$line"/>] has [<xsl:value-of select="count($lineItems)"/>] cells, but the header indicates that [<xsl:value-of select="count($elemNames)"/>] cells are expected!</xsl:message>
                            </xsl:if>
                            <xsl:for-each select="$elemNames">
                                <xsl:variable name="col" select="position()"/>
                                <c n="{.}">
                                    <xsl:value-of select="$lineItems[$col]"/>
                                </c>
                            </xsl:for-each>
                        </r>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message terminate="yes">ERR: couldn't load CSV[<xsl:value-of select="$csv"/>]!</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </csv>
    </xsl:template>
    
</xsl:stylesheet>