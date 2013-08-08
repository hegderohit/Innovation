<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
    
    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>

    <!-- Template for Component link -->
    <xsl:template name="component_link">
        <xsl:param name="px" />
        <xsl:param name="py"/>
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="name" />
        <xsl:param name="description" />
        <xsl:param name="id"/>
        

        <xsl:variable name="Id" select="concat('Link_',$id)"/>
        
        
        <!-- Marker Template -->
        
        <xsl:variable name="markerId" select="concat('marker_',$id)"/>     
        <xsl:variable name="stroke-width" select="@sw"> </xsl:variable>
        <xsl:variable name="stroke-format" select="@sf"> </xsl:variable>
        <xsl:variable name="stroke-color" select="@fillcolor"> </xsl:variable>      
        <xsl:variable name="fill-opacity" select="@transparency"> </xsl:variable>
        <xsl:variable name="fill" select="@fillcolor"> </xsl:variable>

        <xsl:call-template name="path_marker">
            <xsl:with-param name="id" select="$markerId"/>
            <xsl:with-param name="stroke-width" select="$stroke-width"/>
            <xsl:with-param name="stroke-format" select="$stroke-format"/>
            <xsl:with-param name="stroke-color" select="$stroke-color"/>
            <xsl:with-param name="fill-opacity" select="$fill-opacity"/>
            <xsl:with-param name="fill" select="$fill"/>
        </xsl:call-template>
        
        
        <line x1="{$px}" y1="{$py}" x2="{$px + $w}" y2="{$py}" stroke-width="1" stroke="black" fill="none" id="{$Id}" marker-end="url(#{$markerId})"/>
        
        
        
        
        <xsl:call-template name="component_link_text">
            <xsl:with-param name="id1" select="concat('LinkName_',$id)"/>
            <xsl:with-param name="id2" select="concat('LinkHidden_',$id)"/>
            <xsl:with-param name="x" select="($px)"/>
            <xsl:with-param name="y" select="($py + 20)"/>
            <xsl:with-param name="w" select="$w"/>
            <xsl:with-param name="h" select="$h"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="description" select="$description"/>
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="component_link_text">
        
        <xsl:param name="id1"/>
        <xsl:param name="id2"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="h"/>
        <xsl:param name="w"/>
        <xsl:param name="description"/>
        <xsl:param name="name"/>
        
        <xsl:variable name="tempx" select="$x + ($w div 2)"></xsl:variable>
        <text id="{$id1}" style="font-size:20;font-style:normal;fill:#000000;"
            onmouseover="show(evt, '{$id2}')" onmouseout="hide(evt, '{$id2}')" x="{$tempx}"
            y="{$y}">
            Link
        </text>
        <g id="{$id2}" visibility="hidden">
            
            <text x="{$tempx - 10}" y="{$y+5}" font-size="12" font-family="Arial" fill="black">
                <xsl:value-of select="$description"/>
            </text>
        </g>
        
    </xsl:template>
        
    <xsl:template name="path_marker">
        <xsl:param name="id"/>
        <xsl:param name="stroke-width"/>
        <xsl:param name="stroke-format"/>
        <xsl:param name="stroke-color"/>
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill"/>
        <marker orient="auto" id="{$id}" viewBox="-1 -4 10 8" markerWidth="20" markerHeight="10"
            color="{$stroke-color}">
            <path d="M 0 0 L -8 8 L -8 -8 Z" fill="black" stroke="black"
                stroke-width="1"/>
            
            
           <!-- <path d="M 0 0 L -8 8 L -8 -8 Z" fill="{$fill}" stroke="{$stroke-color}"
                stroke-width="{$stroke-width}"/>-->
        </marker>
        
        
    </xsl:template>
        
        
        
        
        
        
 
    
    
</xsl:stylesheet>