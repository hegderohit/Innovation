<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
    
    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    
    <!-- Template for Database 
    Takes the P(X,Y) , H , W , ID and name as the input parameters
        Calls Text Template to create the text component.
        Output of this template is Database Model in SVG form.-->
    <xsl:template name="database">
        
        <xsl:param name="px"/>
        <xsl:param name="py"/>
        <xsl:param name="w"/>
        <xsl:param name="h"/>
        <xsl:param name="name"/>
        <xsl:param name="description"/>
        <xsl:param name="id"/>
        
        
        <xsl:variable name="Id" select="concat('db_',$id)"/>
        
        <xsl:variable name="curve_ht" select="$h div 3"/>
        
        <line x1="{$px}" y1="{$py}" x2="{$px + $w}" y2="{$py}" stroke-width="1" stroke="black"
            fill="none"/>
        
        <line x1="{$px}" y1="{$py + $h}" x2="{$px + $w}" y2="{$py + $h}" stroke-width="1"
            stroke="black" fill="none"/>
        
        <path
            d="M{$px} {$py} C {$px -40} {$py + $curve_ht}, {$px - 40} {$py +(2 * $curve_ht)}, {$px} {$py + $h}"
            stroke="black" fill="transparent"/>
        
      
        
        <ellipse ry="{$h div 2}" rx="20" cx="{$px + $w}"
            cy="{$py + ($h div 2)}" stroke-width="1" stroke="black" fill="none" id="{$Id}"/>
        
        <xsl:call-template name="database_text">
            <xsl:with-param name="id1" select="concat('db_Name',$id)"/>
            <xsl:with-param name="id2" select="concat('db_Hidden_',$id)"/>
            <xsl:with-param name="x" select="($px)"/>
            <xsl:with-param name="y" select="($py + 30)"/>
            <xsl:with-param name="w" select="$w"/>
            <xsl:with-param name="h" select="$h"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="description" select="$description"/>
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="database_text">
        
        <xsl:param name="id1"/>
        <xsl:param name="id2"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="h"/>
        <xsl:param name="w"/>
        <xsl:param name="description"/>
        <xsl:param name="name"/>
        
        <xsl:variable name="tempx" select="$x + ($w div 4)"></xsl:variable>
        <text id="{$id1}" style="font-size:20;font-style:normal;fill:#000000;"
            onmouseover="show(evt, '{$id2}')" onmouseout="hide(evt, '{$id2}')" x="{$tempx}"
            y="{$y}">
            Database
        </text>
        <g id="{$id2}" visibility="hidden">
            
            <text x="{$tempx - 10}" y="{$y+5}" font-size="12" font-family="Arial" fill="black">
                <xsl:value-of select="$description"/>
            </text>
        </g>
        
    </xsl:template>
    
</xsl:stylesheet>