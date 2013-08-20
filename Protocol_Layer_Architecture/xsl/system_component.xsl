<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gsfm="http://www.innovation3g.com/gsf/model"
    exclude-result-prefixes="xs func">
    
    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
   
    <!-- Template for System component 
        Takes the P(X,Y) , H , W , ID and name as the input parameters
        Calls Text Template to create the text component.
        Output of this template is System Component Model in SVG form.-->
 <!--   <xsl:template name="system_component">
       <!-\- <xsl:param name="componentProperties"/>-\->
        <xsl:param name="id"/>
        <xsl:param name="px" />
        <xsl:param name="py" />
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="name"/>
        <xsl:param name="description"/>

        <xsl:variable name="Id" select="concat('Sys_Comp',$id)"/>
        
        <rect width="{$w}" height="{$h}" x="{$px}"
            y="{$py}" stroke-width="1" stroke="black" stroke-dasharray="9, 5" fill="none" id="{$Id}"/>

     <!-\-   <xsl:variable name="Id"
            select="concat('Sys_Comp', $componentProperties/containerModelProperties/@id)"/>
        
        
        <g  gsfm:cid="{$componentProperties/componentIdentityProperties/@cid}"
            gsfm:ciid="{concat('SystemGroup_',$componentProperties/componentIdentityProperties/@ciid)}"
            gsfm:cns="{$componentProperties/componentIdentityProperties/@cns}"
            gsfm:ct="{$componentProperties/componentIdentityProperties/@ct}"
            gsfm:pcId="{$componentProperties/componentIdentityProperties/@pcId}"
            gsfm:pcns="{$componentProperties/componentIdentityProperties/@pcns}"
            >

        
        
        
        <rect width="{ $componentProperties/containerModelProperties/@w}"
            height="{ $componentProperties/containerModelProperties/@h}"
            x="{ $componentProperties/containerModelProperties/@x}"
            y="{ $componentProperties/containerModelProperties/@y}" stroke-width="1" stroke="black"
            fill="none" id="{$Id}"/>-\->


<g>

        <xsl:call-template name="Sys_Comp_text">
           <!-\- <xsl:with-param name="id1"
                select="concat('Sys_CompName_', $componentProperties/containerModelProperties/@id)"/>
            <xsl:with-param name="id2"
                select="concat('Sys_CompHidden_', $componentProperties/containerModelProperties/@id)"/>
            <xsl:with-param name="x"
                select="( $componentProperties/containerModelProperties/@x + 35)"/>
            <xsl:with-param name="y"
                select="( $componentProperties/containerModelProperties/@y + 30)"/>
            <xsl:with-param name="w" select="200"/>
            <xsl:with-param name="h" select="150"/>
            <xsl:with-param name="name"
                select=" $componentProperties/containerModelProperties/@name"/>
            <xsl:with-param name="description"
                select=" $componentProperties/containerModelProperties/@description"/>-\->
            
            
        </xsl:call-template>
            
        </g>
    </xsl:template>
    
   -->
    
    <xsl:template name="system_component">
        <xsl:param name="id"/>
        <xsl:param name="px" />
        <xsl:param name="py" />
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="name"/>
        <xsl:param name="description"/>
        
        
        <xsl:variable name="Id" select="concat('Sys_Comp',$id)"/>
        
        
        
        
        
        
        <g gsfm:cid="{$name}" gsfm:ciid="{concat('SystemGroup_',$id)}"
            gsfm:cns="http://www.innovation3g.com/gsf" gsfm:ct="{$name}" gsfm:pcId=""
            gsfm:pcns="http://www.innovation3g.com/gsf">

            <rect width="{$w}" height="{$h}" x="{$px}" y="{$py}" stroke-width="1" stroke="black"
                fill="none" id="{$Id}"/>


            <xsl:call-template name="Sys_Comp_text">
                <xsl:with-param name="id1" select="concat('Sys_CompName_',$id)"/>
                <xsl:with-param name="id2" select="concat('Sys_CompHidden_',$id)"/>
                <xsl:with-param name="x" select="($px + 35)"/>
                <xsl:with-param name="y" select="($py + 30)"/>
                <xsl:with-param name="w" select="200"/>
                <xsl:with-param name="h" select="150"/>
                <xsl:with-param name="name" select="$name"/>
                <xsl:with-param name="description" select="$description"/>
            </xsl:call-template>
            
        </g>
    </xsl:template>
    
    <xsl:template name="Sys_Comp_text">
        
        <xsl:param name="id1"/>
        <xsl:param name="id2"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="h"/>
        <xsl:param name="w"/>
        <xsl:param name="description"/>
        <xsl:param name="name"/>
        
        
        <text id="{$id1}" style="font-size:20;font-style:normal;fill:#000000;"
            onmouseover="show(evt, '{$id2}')" onmouseout="hide(evt, '{$id2}')" x="{$x}"
            y="{$y}">
            <xsl:value-of select="$name"/>
        </text>
        <g id="{$id2}" visibility="hidden">
            
            <text x="{$x + 10}" y="{$y+5}" font-size="12" font-family="Arial" fill="black">
                <xsl:value-of select="$description"/>
            </text>
        </g>
        
    </xsl:template>
    
    
</xsl:stylesheet>