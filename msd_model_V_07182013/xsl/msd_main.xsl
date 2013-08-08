<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
    
   
    <xsl:output name="msd-format" method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
        
    
    <xsl:include href="msd_transformation.xsl"/>
        
    <xsl:template match="msd">
        
        <xsl:variable name="maxEvent" select="2"/>
        
        <xsl:variable name="event_count">
            <xsl:value-of select="count(event)"/>
        </xsl:variable>
        
        <xsl:variable name="working_filterH">
            <xsl:value-of select="round($event_count div $maxEvent)"/>
        </xsl:variable>
        
        <xsl:result-document href="msd_1.svg" format="msd-format">
            <xsl:call-template name="process_fsm">    
                <xsl:with-param name="component1_px" select="5"/>
                <xsl:with-param name="component1_py" select="5"/>
                <xsl:with-param name="component1_w" select="1500"/>
                <xsl:with-param name="component1_h" select="1200"/>
                <!-- 
                    Parametrs Defining the Upper limit for model size
                -->
                <xsl:with-param name="maxW" select="240"/>
                <xsl:with-param name="maxH" select="200"/>
                <xsl:with-param name="maxL" select="150"/>
                <xsl:with-param name="start_filter" select="0"/>
                <xsl:with-param name="end_filter" select="$working_filterH + 1"/>
            </xsl:call-template>
            
        </xsl:result-document>
        
        
        
        
       <!-- <xsl:for-each select="msd">
        <xsl:if test="position() &lt; 3 ">
        <xsl:variable name="fileName" select="concat('msd_',position() + 1,'.svg')"/>
       --> 
        <xsl:result-document href="msd_3.svg" format="msd-format">
            <xsl:call-template name="process_fsm">
                
                <xsl:with-param name="component1_px" select="5"/>
                <xsl:with-param name="component1_py" select="5"/>
                <xsl:with-param name="component1_w" select="1500"/>
                <xsl:with-param name="component1_h" select="1200"/>
                <!--
                    Parametrs Defining the Upper limit for model size
                -->
                <xsl:with-param name="maxW" select="240"/>
                <xsl:with-param name="maxH" select="200"/>
                <xsl:with-param name="maxL" select="150"/>
                <xsl:with-param name="start_filter" select="3"/>
                <xsl:with-param name="end_filter" select="6"/>
            </xsl:call-template>
            
        </xsl:result-document>
       <!-- </xsl:if>
        </xsl:for-each>
    --></xsl:template>
    
    
   <!-- <xsl:template name="model_state">
        <xsl:param name="name"/>
        <xsl:param name="text_description"/>
        <xsl:param name="text_id" />
        <xsl:param name="px"/>
        <xsl:param name="py"/>
        <xsl:param name="width"/>
        <xsl:param name="height"/>
        <xsl:param name="stateid"/>
        <xsl:param name="stroke-width"/>
        <xsl:param name="stroke-format"/>
        <xsl:param name="stroke-color"/>
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill"/>
        
        
        <xsl:call-template name="rect">
            
            <xsl:with-param name="px" select="$px"/>
            <xsl:with-param name="py" select="$py"/>
            <xsl:with-param name="width" select="$width"/>
            <xsl:with-param name="height" select="$height"/>
            <xsl:with-param name="stateid" select="$stateid"/>
            <xsl:with-param name="stroke-width" select="$stroke-width"/>
            <xsl:with-param name="stroke-format" select="$stroke-format"/>
            <xsl:with-param name="stroke-color" select="$stroke-color"/>
            <xsl:with-param name="fill-opacity" select="$fill-opacity"/>
            <xsl:with-param name="fill" select="$fill-opacity"/>
            
            
        </xsl:call-template>
        
        
        <xsl:call-template name="text">
            <xsl:with-param name="id1" select="concat('Desc_',$stateid)"/>
            <xsl:with-param name="id2" select="concat('DescHide_',$stateid)"/>
            <xsl:with-param name="x" select="$px + 15"/>
            <xsl:with-param name="y" select="$py + ($height div 2)"/>
            <xsl:with-param name="name" select="$name"/>
            
            <xsl:with-param name="h" select="0.5 * $height"/>
            <xsl:with-param name="w" select=" $width - 10"/>
        </xsl:call-template>
        
        
        <xsl:call-template name="text">
            <xsl:with-param name="id1" select="concat('Name_',$stateid)"/>
            <xsl:with-param name="id2" select="concat('NameHide_',$stateid)"/>
            <xsl:with-param name="x" select="$px + 10"/>
            <xsl:with-param name="y" select="$py + (($height * 3) div 4)"/>
            <xsl:with-param name="h" select="0.5 * $height"/>
            <xsl:with-param name="w" select=" $width - 10"/>
            <xsl:with-param name="decription" select="$text_description"/>
            
        </xsl:call-template>
        
    </xsl:template>
    
    
    
    <xsl:template name="rect">
        
        <xsl:param name="stateid"/>
        <xsl:param name="stroke-width"/>
        <xsl:param name="stroke-format"/>
        <xsl:param name="stroke-color"/>
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill"/>
        <xsl:param name="px"/>
        <xsl:param name="py"/>
        <xsl:param name="width"/>
        <xsl:param name="height"/>
        
        <rect width="{$width}" height="{$height}" x="{$px}" y="{$py}" stroke-width="1"
            stroke="{$stroke-color}" fill="none" id="{$stateid}" />
        
        
        
    </xsl:template>
    
    
    <xsl:template name="text">
        
        <xsl:param name="id1"/>
        <xsl:param name="id2"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="h"/>
        <xsl:param name="w"/>
        <xsl:param name="decription"/>
        <xsl:param name="seq_num"/>
        <xsl:param name="name"/>
        
        <xsl:variable name="temp_name" select="concat($seq_num,'.')"/>
        <text id="{$id1}" style="font-size:20;font-style:normal;fill:#000000;"
            onmouseover="show(evt, '{$id2}')" onmouseout="hide(evt, '{$id2}')" x="{$x + 10}" y="{$y}">  <xsl:value-of select="concat($temp_name,$name)"/>
        </text>
        <g id="{$id2}" visibility="hidden" >
            
            <text x="{$x + 10}" y="{$y+5}" font-size="12" font-family="Arial" fill="black">Hidden Text....</text>
        </g>
        
    </xsl:template>
    
    
    
    <xsl:template name="model_Sequence">
        <xsl:param name="line_id" />
        <xsl:param name="px" />
        <xsl:param name="py" />
        <xsl:param name="width"/>
        <xsl:param name="height" />
        <xsl:param name="length" />
        <xsl:param name="stroke-width" />
        <xsl:param name="stroke-format" />
        <xsl:param name="stroke-color" />
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill" />
        
        
        <xsl:variable name="sx">
            <xsl:value-of select="$px"/>		
        </xsl:variable>
        
        <xsl:variable name="sy">
            <xsl:value-of select="$py"/>   					
        </xsl:variable>
        
        <xsl:variable name="ex">
            <xsl:value-of select="($px)"/>
        </xsl:variable>
        
        <xsl:variable name="ey">
            <xsl:value-of select="($py + ($length div 2))"/>			
        </xsl:variable>
        
        <line x1="{$sx}" y1="{$sy}" x2="{$ex}" y2="{$ey}" stroke="{$stroke-color}"
            id="{$line_id}" />
        
    </xsl:template>
    
    <xsl:template name="model_Message">
        <xsl:param name="description"/>
        <xsl:param name="px" />
        <xsl:param name="py" />
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="id" />
        <xsl:param name="marker"/>
        <xsl:param name="name"/>
        <xsl:param name="seq_num"/>
        
        
        
        <xsl:variable name="sx">
            <xsl:value-of select="$px"/>
        </xsl:variable>
        
        <xsl:variable name="ex">
            <xsl:value-of select="$w + $px"/>
        </xsl:variable>
        
        <line x1="{$sx}" y1="{$py}" x2="{$ex}" y2="{$py}" id="{$id}" stroke="black" marker-end="url(#{$marker})"/>
        
        <xsl:variable name="tempx">
            <xsl:choose>
                <xsl:when test="$ex &gt; $sx">
                    <xsl:value-of select="$sx + (($ex - $sx) div 4)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$sx - ((($sx - $ex) div 2))"/>
                </xsl:otherwise>
            </xsl:choose>
            
            
        </xsl:variable>
        
        <xsl:call-template name="text">
            <xsl:with-param name="id1" select="concat('MessDesc_',$id)"/>
            <xsl:with-param name="id2" select="concat('MessDescHide_',$id)"/>
            <xsl:with-param name="x" select="$tempx"/>
            <xsl:with-param name="y" select="$py - 5"/>
            <xsl:with-param name="decription" select="$description"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="seq_num" select="$seq_num"/>
            
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="path_marker">
        <xsl:param name="id4"/>
        <xsl:param name="stroke-width"/>
        <xsl:param name="stroke-format"/>
        <xsl:param name="stroke-color"/>
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill"/>
        <marker orient="auto" id="{$id4}" viewBox="-1 -4 10 8" markerWidth="20" markerHeight="10"
            color="{$stroke-color}">
            <path d="M 0 0 L -8 8 L -8 -8 Z" fill="{$fill}" stroke="{$stroke-color}"
                stroke-width="{$stroke-width}"/>
        </marker>
        
        
    </xsl:template>
    
    <xsl:template name="model_Event">
        <xsl:param name="px" />
        <xsl:param name="py" />
        <xsl:param name="marker"/>
        <xsl:param name="h" />
        <xsl:param name="w" />
        <xsl:param name="id" />
        <xsl:param name="description"/>
        <xsl:param name="name"/>
        <xsl:param name="seq_num"/>
        
        <xsl:variable name="tempx">
            <xsl:value-of select="$px + 3"/>      
        </xsl:variable>
        
        <xsl:call-template name="text">
            <xsl:with-param name="id1" select="concat('MessDesc_',$id)"/>
            <xsl:with-param name="id2" select="concat('MessDescHide_',$id)"/>
            <xsl:with-param name="x" select="$tempx"/>
            <xsl:with-param name="y" select="$py - 5"/>
            <xsl:with-param name="decription" select="$description"/>
            <xsl:with-param name="seq_num" select="$seq_num"/>
            <xsl:with-param name="name" select="$name"/>
        </xsl:call-template>
        
        
        <xsl:call-template name="line">
            <xsl:with-param name="px" select="$px"/>
            <xsl:with-param name="py" select="$py"/>
            <xsl:with-param name="w" select="($w div 2)"/>
            <xsl:with-param name="h" select="0"/>
            <xsl:with-param name="id" select="concat('Event1_',$id)"/>
        </xsl:call-template>
        
        <xsl:call-template name="line">
            <xsl:with-param name="px" select="$px + ($w div 2)"/>
            <xsl:with-param name="py" select="$py"/>
            <xsl:with-param name="w" select="0"/>
            <xsl:with-param name="h" select="(0.6 * $h)"/>
            <xsl:with-param name="id" select="concat('Event2_',$id)"/>
        </xsl:call-template>
        
        <xsl:call-template name="line">
            <xsl:with-param name="px" select="$px + ($w div 2)"/>
            <xsl:with-param name="py" select="$py + (0.6 * $h)"/>
            <xsl:with-param name="w" select="0 - ($w div 4)"/>
            <xsl:with-param name="h" select="0"/>
            <xsl:with-param name="marker" select="$marker"/>
            <xsl:with-param name="id" select="concat('Event3_',$id)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="line">
        <xsl:param name="px"/>
        <xsl:param name="py" />
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="id" />
        <xsl:param name="marker"/>
        
        <line x1="{$px}" y1="{$py}" x2="{$px + $w}" y2="{$py + $h}" id="{$id}" stroke="black" marker-end="url(#{$marker})"/>
        
    </xsl:template>
    -->
    
    
    
    
    
        
    </xsl:stylesheet>
