<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
     
    <xsl:output name="msd-format" method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:include href="msd_transformation.xsl"/>
    
    
    <!-- 
        This is the msd_main.xsl file.
        Input : Takes the screen size P(x,y) H and W 
                Maximum Size of Instance Model i.e, MaxH, MaxW and MaxL
                Filter Variable (Sequence filter / Instance Filter)
        Output: Creates Multiple SVG files which is either Sequence filtered or Instance
        Includes : msd_transforamtion.xsl
        
        Transformation Logic :
                1) Auto Sizing the modles
                    -> Based on the Screen Size, the size of instances are calculated
                    -> Variables actualL,actaulW and actualL is set.
                    -> Maximum Number of events that can be placed on the screen is fixed.
                    -> Variable containerEventsCount is set.
                2) Generating Multiple output files
                    -> Get the  MSD   context  
                    -> Define a output format name= "msd-format"
                    -> Determine the  maximum  number of  events  per  container  : $containerEventsCount 
                    -> Determine the number of events in the  MSD  : $msdEventsCount
                    -> Determine the number of  display  containers ( svg files ) : $countDisplayContainers
                    -> using the ref Spacing between the events
                         
                3) Calling the msd_transformation in a loop        
        		    -> now create  a loop, in each  loop  determine the start and  end  sequence number 
                    -> Create file name dynamicaaly every time. : $filename
                    
                        <xsl:result-document href="{$fileName}" format="msd-format">
				    		 for-each ( 1 to 	$countDisplayContainers) 
        			              
        			              startSeqeunce = ( position -1)*$containerEventsCount 
        			              endSeqeunce = $startSeqeunce + $containerEventsCount
        			              
        			              Call-template with the params
        			              
				    		  end for
				    	</xsl:result-document>
                                         		  
    -->
    
   
    <xsl:template match="msd">
        
        <xsl:param name="component1_px" select="5"/>
        <xsl:param name="component1_py" select="5"/>
        <xsl:param name="component1_w" select="500"/>
        <xsl:param name="component1_h" select="700"/>
        <xsl:param name="maxW" select="240"/>
        <xsl:param name="maxH" select="200"/>
        <xsl:param name="maxL" select="150"/>
        
        <xsl:variable name="event_spacing" select="25"/>
        <xsl:variable name="model_refL" select="100"/>
        <xsl:variable name="model_refW" select="140"/>
        <xsl:variable name="model_refH" select="50"/>
        <xsl:variable name="component_refW" select="1000"/>
        <xsl:variable name="component_refH" select="1000"/>
        
        <!-- Auto ResizeLogic -->
        <xsl:variable name="perdiff_w">
            <xsl:if test="$component1_w >= $component_refW">
                <xsl:value-of select="($component1_w - $component_refW) div $component_refW"/>
            </xsl:if>
            <xsl:if test="$component1_w &lt; $component_refW">
                <xsl:value-of select="($component_refW - $component1_w) div $component_refW"/>
            </xsl:if>              
        </xsl:variable>
        
        <xsl:variable name="perdiff_h">
            <xsl:if test="$component1_h >= $component_refH">
                <xsl:value-of select="($component1_h - $component_refH) div $component_refH"/>
            </xsl:if>
            <xsl:if test="$component1_h &lt; $component_refH">
                <xsl:value-of select="($component_refH - $component1_h) div $component_refH"/>
            </xsl:if>               
        </xsl:variable>
              
        <!--
            Type : Variable
            Name : actualW
            Desc : Actuall width of the model with reference to the screen size
        -->
        <xsl:variable name="tempW">
            <xsl:if test="$component1_w >= $component_refW">
                <xsl:value-of select="($model_refW) + ($model_refW * $perdiff_w)"/>
            </xsl:if>
            <xsl:if test="$component1_w &lt; $component_refW">
                <xsl:value-of select="($model_refW) - ($model_refW * $perdiff_w)"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="actualW">
            <xsl:if test="$tempW >= $maxW">
                <xsl:value-of select="$maxW"/>
            </xsl:if>
            <xsl:if test="$tempW &lt; $maxW">
                <xsl:value-of select="$tempW"/>
            </xsl:if>      
        </xsl:variable>
        
        <!--
            Type : Variable
            Name : actualH
            Desc : Actuall height of the model with reference to the screen size
        -->
        <xsl:variable name="temph">
            <xsl:if test="$component1_h > $component_refH">
                <xsl:value-of select="($model_refH) + ($model_refH * $perdiff_h)"/>
            </xsl:if>
            <xsl:if test="$component1_h &lt; $component_refH">
                <xsl:value-of select="($model_refH) - ($model_refH * $perdiff_h)"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="actualH">
            <xsl:if test="$temph >= $maxH">
                <xsl:value-of select="$maxH"/>
            </xsl:if>
            <xsl:if test="$temph &lt; $maxH">
                <xsl:value-of select="$temph"/>
            </xsl:if>   
        </xsl:variable>
        <!--
            Type : Variable
            Name : actualL
            Desc : Actuall Spacing between the model with reference to the screen size
        -->
        <xsl:variable name="tempL">
            <xsl:if test="$component1_w &gt; $component_refW">
                <xsl:value-of select="$model_refL + ($perdiff_w * $model_refL)"/>
            </xsl:if>
            <xsl:if test="$component1_w &lt; $component_refW">
                <xsl:value-of select="$model_refL - ($model_refL * $perdiff_w)"/>
            </xsl:if>               
        </xsl:variable>
        
        <xsl:variable name="actualL">
            <xsl:if test="$tempL >= $maxL">
                <xsl:value-of select="$maxL"/>
            </xsl:if>
            <xsl:if test="$tempL &lt; $maxL">
                <xsl:value-of select="$tempL"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="model_seq_length" select="($component1_h div 2)"/>
        
        
        <!-- Filter Variables decides on what factor the svg must be filtered -->
        <xsl:variable name="filter">
            <sequence enabled="true" start_sequence="1" end_sequence="5"/>
            <instance enabled="false">
                <instance id="rrc"/>
                <instance id="MAC"/>
                <instance id="enodeb"/>
            </instance>
        </xsl:variable>
           
        <!-- The Maximum number of EVents inside the container formuale goes in here -->  
        <xsl:variable name="containerEventsCount">
           <xsl:value-of select="$model_seq_length div $event_spacing"/>
        </xsl:variable>
        
        <xsl:variable name="msdEventsCount">
            <xsl:value-of select="count(event)"/>
        </xsl:variable>
        
        <xsl:variable name="countDisplayContainers">
            <xsl:value-of select="round($msdEventsCount div $containerEventsCount)"/>
        </xsl:variable>
        
        <xsl:variable name="currentMsd" select="."/>
        
        <!-- Loop to print out the models in different files.tere -->
        <xsl:for-each select="( 1 to $countDisplayContainers)">
            
            <xsl:variable name="filename" select="concat('msd_',position(),'.svg')"/>
            
            <xsl:result-document href="{$filename}" format="msd-format">           
                
                <xsl:variable name="startSeqeunce" select="(position() - 1) * $containerEventsCount "/>
                <xsl:variable name="endSeqeunce" select="$startSeqeunce + $containerEventsCount" />
                <xsl:call-template name="process_msd">
                    
                    <xsl:with-param name="component1_px" select="$component1_px"/>
                    <xsl:with-param name="component1_py" select="$component1_py"/>
                    <xsl:with-param name="component1_w" select="$component1_w"/>
                    <xsl:with-param name="component1_h" select="$component1_h"/>                 
                    <xsl:with-param name="actualL" select="$actualL"/>
                    <xsl:with-param name="actualH" select="$actualH"/>
                    <xsl:with-param name="actualW" select="$actualW"/>
                    <xsl:with-param name="start_filter" select="$startSeqeunce"/>
                    <xsl:with-param name="end_filter" select="$endSeqeunce"/>
                    <xsl:with-param name="param_msd" select="$currentMsd"/>
                </xsl:call-template>
                
            </xsl:result-document>
        </xsl:for-each>   
        
    </xsl:template>
    

</xsl:stylesheet>
