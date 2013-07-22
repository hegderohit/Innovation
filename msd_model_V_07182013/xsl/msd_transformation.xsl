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
    
    
    
    
    
    
    <xsl:function name="func:getRecord" as="item()*">
        <xsl:param name="states"/>
        <xsl:param name="transitions"/>
        <xsl:param name="state_ordinates"/>
        <xsl:param name="actualH"/>
        <xsl:param name="actualW"/>
        
        
        
        
        
        
        <xsl:for-each select="$state_ordinates/*">
            
            
            <!-- 4basic variables needed for each state -->
            <xsl:variable name="id" select="@stateid"/>
           
           
            <xsl:variable name="position" select="position()"/>
            <xsl:variable name="rank" select="@rank"/>

            <xsl:variable name="px" select="@px"/>         
            <xsl:variable name="py" select="@py"/>

            
            <xsl:variable name="output">
                
                <xsl:for-each select="(($transitions[@end_mark=$id]))">
                        <rec>                         
                           
                            <xsl:attribute name="state_id" select="$id"/>
                            <xsl:attribute name="transition_id" select="@id"/>
                           
                            <xsl:attribute name="x">
                                    <xsl:value-of select="($px + ($actualW div 2))"/>
                            </xsl:attribute>
                            <xsl:attribute name="y" select="($py) + ($actualH)"/>
                        </rec>
                    
                </xsl:for-each>
                
             
            </xsl:variable>
            
            <!-- Retrun Value -->
            <xsl:sequence select="$output"/>
        </xsl:for-each>
        
    </xsl:function>
    
    
    
    
    <xsl:template name="process_fsm" match="msd">
        
		<xsl:param name="component1_px" select="5"/>
		<xsl:param name="component1_py" select="5"/>
		<xsl:param name="component1_w" select="1000"/>
		<xsl:param name="component1_h" select="1000"/>


		<!-- 
        Parametrs Defining the Upper limit for model size
    -->
		<xsl:param name="maxW" select="240"/>
		<xsl:param name="maxH" select="200"/>
		<xsl:param name="maxL" select="150"/>

		<svg version="1.1" xmlns="http://www.w3.org/2000/svg">
			
		<script type="text/javascript">
				
		function show(evt, node)
		{
        var svgdoc = evt.target.ownerDocument;
        var obj = svgdoc.getElementById(node);
        obj.setAttribute("visibility", "visible");
		}

		function hide(evt, node)
		{
        var svgdoc = evt.target.ownerDocument;
        var obj = svgdoc.getElementById(node);
        obj.setAttribute("visibility" , "hidden");
		}
		</script>
			<!--
            Type : Variable
            Name : actualW
            Desc : Actuall width of the model with reference to the screen size
        -->
			<xsl:variable name="actualW">
				<xsl:value-of select="140"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : actualH
            Desc : Actuall height of the model with reference to the screen size
        -->
			<xsl:variable name="actualH">
				<xsl:value-of select="100"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : actualL
            Desc : Actuall Spacing between the model with reference to the screen size
        -->
			<xsl:variable name="actualL">
				<xsl:value-of select="50"/>
			</xsl:variable>
			
			<xsl:variable name="instancecount">
			    <xsl:value-of select="count(instance)"/>
			</xsl:variable>
			 
			 <!--
			     Design: 
			     
			     Model:
			     1) Count number of Instances from the XML
			     2) Fix a Y coordinate for Axis on which models will center (1/3rd of H)
			     3) Divide the axis to place all the instances with some distace L between them
			     4) Calculate the anchor Points for each model
			     
			     Transition:
			     1) Use the Model and for each of that find the Point to place the line on which messages reside.
			                   
			                   
			 -->

		    <xsl:variable name="workingW">
		        <xsl:value-of select="( $component1_w div ($instancecount + 1) )"/>
		    </xsl:variable>
		    
		    
		    <!-- Distance between 2 instances -->
		    
		    <xsl:variable name="distance">
		        <xsl:value-of select="$actualL + ($actualW)"></xsl:value-of>
		        
		    </xsl:variable>
		    
		    <xsl:variable name="model_coordinates">
		        <xsl:for-each select="instance">
		            <rec>
		                <xsl:attribute name="stateid">
		                    <xsl:value-of select="@id"/>
		                </xsl:attribute>
		                <xsl:attribute name="py">
		                    <xsl:value-of select="($component1_h div 8) + ($actualH div 2)"/>
		                </xsl:attribute>
		                <xsl:attribute name="px">
		                    <xsl:value-of select="(($workingW * position()) - ($actualW div 2))"/>
		                </xsl:attribute>
		                <xsl:attribute name="name">
		                    <xsl:value-of select="@name"/>
		                </xsl:attribute>
		                <xsl:attribute name="text_description">
		                    <xsl:value-of select="@description"/>
		                </xsl:attribute>
		                <xsl:attribute name="strokecolor">
		                    <xsl:value-of select="@sc"/>
		                </xsl:attribute>
		                <xsl:attribute name="strokewidth">
		                    <xsl:value-of select="@sw"/>
		                </xsl:attribute>
		                <xsl:attribute name="h">
		                    <xsl:value-of select="$actualH"/>
		                </xsl:attribute>
		                <xsl:attribute name="w">
		                    <xsl:value-of select="$actualW"/>
		                </xsl:attribute>
		            </rec>	            
		        </xsl:for-each>
		    </xsl:variable>
            
            
            
            <!-- Debug -->
            <xsl:message>
                Count :  <xsl:value-of select="$instancecount"/>
                Working Height : <xsl:value-of select="$workingW"/>  
            </xsl:message>
            
            <!-- Calling template to draw the instanses -->
		    <xsl:for-each select="$model_coordinates/*">  
		    <xsl:call-template name="model_state">
		        <xsl:with-param name="name" select="./@name"/>
		        <xsl:with-param name="text_description" select="./@text_description"/>
		        <xsl:with-param name="text_id" select="concat('Text_',./@stateid)"/>
		        <xsl:with-param name="px" select="./@px"/>		    
		        <xsl:with-param name="py" select="./@py"/>
		        <xsl:with-param name="width" select="./@w"/>
		        <xsl:with-param name="height" select="./@h"/>
		        <xsl:with-param name="stateid" select="concat('State_',./@stateid)"/>
		        <xsl:with-param name="stroke-width" select="./@strokewidth"/>
		        <xsl:with-param name="stroke-format" select="1"/>
		        <xsl:with-param name="stroke-color" select="./@strokecolor"/>
		        <xsl:with-param name="fill-opacity" select="0"/>
		        <xsl:with-param name="fill" select="none"/>
		     </xsl:call-template>
		    </xsl:for-each>
        
        
        <!-- Calling Line -->
		    <xsl:for-each select="$model_coordinates/*">  
		        <xsl:call-template name="model_Sequence">
		           
		            <xsl:with-param name="line_id" select="concat('Line_',./@stateid)"/>
		          
		            <xsl:with-param name="px" select="./@px + ($actualW div 2)"/>
		            <xsl:with-param name="py" select="./@py + ($actualH)"/>
		            <xsl:with-param name="width" select="./@w"/>
		            <xsl:with-param name="height" select="./@h"/>
		            <xsl:with-param name="length" select="$component1_h"/>
		            <xsl:with-param name="stroke-width" select="./@strokewidth"/>
		            <xsl:with-param name="stroke-format" select="1"/>
		            <xsl:with-param name="stroke-color" select="./@strokecolor"/>
		            <xsl:with-param name="fill-opacity" select="0"/>
		            <xsl:with-param name="fill" select="none"/>
		        </xsl:call-template>
		    </xsl:for-each>
		    
        <!-- Marker -->
		    <xsl:for-each select="./marker">
		        <xsl:variable name="id4" select="@id"> </xsl:variable>
		        
		        <xsl:variable name="stroke-width" select="@sw"> </xsl:variable>
		        <xsl:variable name="stroke-format" select="@sf"> </xsl:variable>
		        <xsl:variable name="stroke-color" select="@fillcolor"> </xsl:variable>
		        
		        <xsl:variable name="fill-opacity" select="@transparency"> </xsl:variable>
		        <xsl:variable name="fill" select="@fillcolor"> </xsl:variable>
		        
		        
		        <xsl:call-template name="path_marker">
		            <xsl:with-param name="id4" select="$id4"/>
		            <xsl:with-param name="stroke-width" select="$stroke-width"/>
		            <xsl:with-param name="stroke-format" select="$stroke-format"/>
		            <xsl:with-param name="stroke-color" select="$stroke-color"/>
		            <xsl:with-param name="fill-opacity" select="$fill-opacity"/>
		            <xsl:with-param name="fill" select="$fill"/>
		        </xsl:call-template>
		    </xsl:for-each>
        
            <!-- Messages -->
            <xsl:variable name="message_count">
                <xsl:value-of select="count(message)"></xsl:value-of>
            </xsl:variable>
		    
		    <xsl:variable name="working_H">
		        <xsl:value-of select="($component1_h div 2) div ($message_count +1)"></xsl:value-of>
		    </xsl:variable>
            
            
         
            
            <xsl:for-each select="message">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="Sid" select="@Sid"/>
                <xsl:variable name="Did" select="@Did"/>
                <xsl:variable name="marker" select="@end_mark"/>
                <xsl:variable name="counter" select="position()"/>
                <xsl:variable name="descritpion" select="@description"/>
                <xsl:variable name="sequence" select="@sequence"/>

                <xsl:variable name="ValidCount_Dest">
                    <xsl:value-of select="count(./parent::msd/instance[@id=$Did])"/>
                </xsl:variable>
                
                <xsl:variable name="ValidCount_Src">
                    <xsl:value-of select="count(./parent::msd/instance[@id=$Sid])"/>
                </xsl:variable>


                <xsl:if test="($ValidCount_Dest > 0) and ($ValidCount_Src > 0)">
                    <xsl:variable name="sx">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Sid">
                                <xsl:value-of select="@px + ($actualW div 2)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:variable name="sy">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Sid">
                                <xsl:value-of select="@py + ($actualH) + ($working_H * $sequence)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:variable name="ex">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Did">
                                <xsl:value-of select="@px + ($actualW div 2)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:variable name="width">
                        <xsl:value-of select="$ex - $sx"/>
                    </xsl:variable>


                    <xsl:call-template name="model_Message">
                        <xsl:with-param name="description" select="$descritpion"/>
                        <xsl:with-param name="px" select="$sx"/>
                        <xsl:with-param name="py" select="$sy"/>
                        <xsl:with-param name="w" select="$width"/>
                        <xsl:with-param name="h" select="($sy - $sy)"/>
                        <xsl:with-param name="marker" select="$marker"/>
                        <xsl:with-param name="id" select="concat('Message_',$id)"/>
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="($ValidCount_Dest = 0) and ($ValidCount_Src > 0)"> 
                    
                    <xsl:variable name="sx">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Sid">
                                <xsl:value-of select="@px + ($actualW div 2)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="sy">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Sid">
                                <xsl:value-of select="@py + ($actualH) + ($working_H * $sequence)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="ex">                      
                         <xsl:value-of select="$sx + ($distance div 2)"/>
                    </xsl:variable>
                    
                    <xsl:variable name="width">
                        <xsl:value-of select="$ex - $sx"/>
                    </xsl:variable>
                    
                    
                    <xsl:call-template name="model_Message">
                        <xsl:with-param name="description" select="$descritpion"/>
                        <xsl:with-param name="px" select="$sx"/>
                        <xsl:with-param name="py" select="$sy"/>
                        <xsl:with-param name="w" select="$width"/>
                        <xsl:with-param name="h" select="($sy - $sy)"/>
                        <xsl:with-param name="marker" select="$marker"/>
                        <xsl:with-param name="id" select="concat('Message_',$id)"/>
                    </xsl:call-template>
                    
                </xsl:if>

                <xsl:if test="($ValidCount_Src = 0) and ($ValidCount_Dest > 0)"> 

                    
                    <xsl:variable name="sy">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Did">
                                <xsl:value-of select="@py + ($actualH) + ($working_H * $sequence)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="ex">                      
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Did">
                                <xsl:value-of select="@px + ($actualW div 2)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="sx">
                            <xsl:value-of select="$ex - ($distance div 2)"/>
                    </xsl:variable>
                    
                    <xsl:variable name="width">
                        <xsl:value-of select="$ex - $sx"/>
                    </xsl:variable>
                    
                    
                    <xsl:call-template name="model_Message">
                        <xsl:with-param name="description" select="$descritpion"/>
                        <xsl:with-param name="px" select="$sx"/>
                        <xsl:with-param name="py" select="$sy"/>
                        <xsl:with-param name="w" select="$width"/>
                        <xsl:with-param name="h" select="($sy - $sy)"/>
                        <xsl:with-param name="marker" select="$marker"/>
                        <xsl:with-param name="id" select="concat('Message_',$id)"/>
                    </xsl:call-template>
                    
                </xsl:if>
                
            </xsl:for-each>
		    
		    
        
			<rect width="{$component1_w}" height="{$component1_h}" x="{$component1_px}"
				y="{$component1_py}" stroke-width="1" stroke="black" fill="none"/>
		</svg>

	</xsl:template>





    <xsl:template name="model_state">
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
            <xsl:with-param name="decription" select="$name"/>
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


        
        <text id="{$id1}" style="font-size:20;font-style:normal;fill:#000000;"
            onmouseover="show(evt, '{$id2}')" onmouseout="hide(evt, '{$id2}')" x="{$x + 10}" y="{$y}">  <xsl:value-of select="$decription"/>
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
        
       
        
        
        <xsl:variable name="sx">
            <xsl:value-of select="$px"/>
        </xsl:variable>
        
        <xsl:variable name="ex">
            <xsl:value-of select="$w + $px"/>
        </xsl:variable>
        
        <line x1="{$sx}" y1="{$py}" x2="{$ex}" y2="{$py}" id="{$id}" stroke="black" marker-end="url(#{$marker})"/>
        
        <xsl:variable name="tempx">
            <xsl:if test="$sx > $ex">
                <xsl:value-of select="$ex + (($sx - $ex) div 2)"/>
            </xsl:if>
            <xsl:if test="$ex > $sx">
                <xsl:value-of select="$sx + 3"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:call-template name="text">
            <xsl:with-param name="id1" select="concat('MessDesc_',$id)"/>
            <xsl:with-param name="id2" select="concat('MessDescHide_',$id)"/>
            <xsl:with-param name="x" select="$tempx"/>
            <xsl:with-param name="y" select="$py - 5"/>
            <xsl:with-param name="decription" select="$description"/>
            
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="path_marker">
        <xsl:param name="id4"/>
        <xsl:param name="stroke-width"/>
        <xsl:param name="stroke-format"/>
        <xsl:param name="stroke-color"/>
        <xsl:param name="fill-opacity"/>
        <xsl:param name="fill"/>
        <marker orient="auto" id="{$id4}" viewBox="-1 -4 10 8" markerWidth="10" markerHeight="8"
            color="{$stroke-color}">
            <path d="M 0 0 L -8 8 L -8 -8 Z" fill="{$fill}" stroke="{$stroke-color}"
                stroke-width="{$stroke-width}"/>
        </marker>
        
        
    </xsl:template>
    
</xsl:stylesheet>