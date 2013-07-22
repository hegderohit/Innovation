<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
    
    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- 
        Global parameters 
        Contains parameters for the Ancor point for the Master Container (Container 1)
    -->
    <xsl:param name="component1_px" select="5"/>
    <xsl:param name="component1_py" select="5"/>
    <xsl:param name="component1_w" select="1000"/>
    <xsl:param name="component1_h" select="900"/>
    
    <!-- 
        Parametrs Defining the Upper limit for model size
    -->
    <xsl:param name="maxW" select="240"/>
    <xsl:param name="maxH" select="200"/>
    <xsl:param name="maxL" select="150"/>
    
    
    
    
    <xsl:template name="process_fsm" match="msd">
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="working_H">
            <xsl:value-of select="50"/>
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:value-of select="150"/>
        </xsl:variable>
        
        <xsl:for-each select="instance">
            
            <xsl:variable name="desc" select="@description"/>
            
            <xsl:call-template name="message">
                <xsl:with-param name="width" select="$width"/>
                <xsl:with-param name="h" select="$working_H"/>
                <xsl:with-param name="desc" select="$desc"/>
                <xsl:with-param name="x" select="10"/>
                <xsl:with-param name="y" select="10"/>
            </xsl:call-template>
            
            
        </xsl:for-each>
        </svg>
    </xsl:template>
    
    <xsl:template name="message">
        <xsl:param name="width"/>
        <xsl:param name="h" />
        <xsl:param name="desc"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        
        <rect width="{$width}" height="{$h}" x="{$x}"
            y="{$y}" stroke-width="1" stroke="black" fill="none"/>
        
        <text  style="font-size:20;font-style:normal;fill:#000000;"
            x="{$x + 10}" y="{$y + ($h div 2)}">  <xsl:value-of select="$desc"/> --<xsl:value-of select="string-length($desc)"/>
        </text>
        
    </xsl:template>
    
</xsl:stylesheet>