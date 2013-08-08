<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs func">
    
    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- 
        Global parameters 
        Contains parameters for the Ancor point for the Master Container (Container 1)
    -->
    <xsl:param name="component1_px" select="5"/>
    <xsl:param name="component1_py" select="5"/>
    <xsl:param name="component1_w" select="1500"/>
    <xsl:param name="component1_h" select="1200"/>
    
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
    
    
    
    
    <xsl:function name="func:display" as="item()*">
        <xsl:param name="ordinate"/>

        <xsl:variable name="sorted">
            <xsl:for-each select="$ordinate/rec/@value">
                <xsl:sort select="."/>
                <rec>
                    <xsl:attribute name="value">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </rec>
            </xsl:for-each>
        </xsl:variable>
                  
                  
        <xsl:variable name="output">
            <xsl:for-each select="$sorted/*">
                    <rec>
                        <value>
                        <xsl:value-of select="@value"/>
                        </value>
                </rec>
            </xsl:for-each>
        </xsl:variable>    
                  
                  
        <xsl:sequence select="$output"/>
              
    </xsl:function>
    
    
    
    <xsl:template name="process_fsm" match="msd">
        
		<xsl:param name="component1_px" />
		<xsl:param name="component1_py" />
		<xsl:param name="component1_w" />
		<xsl:param name="component1_h" />


		<!-- 
        Parametrs Defining the Upper limit for model size
    -->
		<xsl:param name="maxW" />
		<xsl:param name="maxH" />
		<xsl:param name="maxL" />
        <xsl:param name="start_filter"/>
        <xsl:param name="end_filter"/>

        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" >
			
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
            
            
            
            
            <!-- Auto Sizing Logic -->
            <xsl:variable name="perdiff_w">
                <xsl:if test="$component1_w >= 1200">
                    <xsl:value-of select="($component1_w - 1200) div 1200"/>
                </xsl:if>
                <xsl:if test="$component1_w &lt; 1200">
                    <xsl:value-of select="(1200 - $component1_w) div 1200"/>
                </xsl:if>              
            </xsl:variable>
            
            <xsl:variable name="perdiff_h">
                <xsl:if test="$component1_h >= 1000">
                    <xsl:value-of select="($component1_w - 1000) div 1000"/>
                </xsl:if>
                <xsl:if test="$component1_w &lt; 1000">
                    <xsl:value-of select="(1000 - $component1_w) div 1000"/>
                </xsl:if>               
            </xsl:variable>
            
 
			<!--
            Type : Variable
            Name : actualW
            Desc : Actuall width of the model with reference to the screen size
        -->
            <xsl:variable name="tempW">
                <xsl:if test="$component1_w >= 1200">
                    <xsl:value-of select="(140) + (140 * $perdiff_w)"/>
                </xsl:if>
                <xsl:if test="$component1_w &lt; 1200">
                    <xsl:value-of select="(140) - (140 * $perdiff_w)"/>
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
                <xsl:if test="$component1_h > 1000">
                    <xsl:value-of select="(100) + (100 * $perdiff_w)"/>
                </xsl:if>
                <xsl:if test="$component1_h &lt; 1000">
                    <xsl:value-of select="(100) - (100 * $perdiff_w)"/>
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
                <xsl:if test="$component1_w &gt; 1200">
                    <xsl:value-of select="50 + ($perdiff_w * 50)"/>
                </xsl:if>
                <xsl:if test="$component1_w &lt; 1200">
                    <xsl:value-of select="50 - ($perdiff_w * 50)"/>
                </xsl:if>               
            </xsl:variable>
            
            <xsl:variable name="actualL">
                <xsl:if test="$tempW >= 100">
                    <xsl:value-of select="100"/>
                </xsl:if>
                <xsl:if test="$tempW &lt; 100">
                    <xsl:value-of select="$tempL"/>
                </xsl:if>
            </xsl:variable>
            
			<xsl:variable name="instancecount">
			    <xsl:value-of select="count(msd/instance)"/>
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
		        <xsl:for-each select="msd/instance">
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
		                <xsl:attribute name="event_count">
		                    <xsl:value-of select="count(msd/event)"/>
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
                <xsl:value-of select="count(msd/event)"></xsl:value-of>
            </xsl:variable>
		    
		    <xsl:variable name="event_count">
		        <xsl:value-of select="count(msd/event)"></xsl:value-of>
		    </xsl:variable>
		    
		    <xsl:variable name="working_H">
		        <xsl:value-of select="($component1_h div 2) div ( $event_count +1)"></xsl:value-of>
		    </xsl:variable>
            
            
		<!--    TBR LTR
		    <xsl:for-each select="instance">
		        <xsl:variable name="stateid" select="@id"/>
		        <xsl:variable name="descrition" select="@description"/>
		        <xsl:variable name="end_mark" select="@end_mark"/>
		        
		        <xsl:for-each select="event">
		           <xsl:variable name="id">
		               <xsl:value-of select="$stateid"></xsl:value-of>
		           </xsl:variable> 
		           
		          <xsl:variable name="sx">
		            <xsl:for-each select="$model_coordinates/*">
		                <xsl:if test="@stateid=$stateid">
		                    <xsl:value-of select="@px + ($actualW div 2)"/>
		                </xsl:if>
		            </xsl:for-each>
		           </xsl:variable>
		            
		            <xsl:variable name="sy">
		                <xsl:for-each select="$model_coordinates/*">
		                    <xsl:if test="@stateid=$stateid">
		                        <xsl:value-of select="@py + ($actualH) + ($working_H * position())"/>
		                    </xsl:if>
		                </xsl:for-each>
		            </xsl:variable>
		            
		            <xsl:variable name="descritpion" select="@description"/>
		            
		            <xsl:variable name="marker" select="@end_mark"/>
		            
		            
		            
		            
		            
		            
		            
		            <xsl:call-template name="model_Event">
		                <xsl:with-param name="px" select="$sx"/>
		                <xsl:with-param name="py" select="$sy"/>
		                <xsl:with-param name="marker" select="$marker"/>
		                <xsl:with-param name="h" select="$working_H"/>
		                <xsl:with-param name="w" select="$workingW"/>
		                <xsl:with-param name="id" select="$id"/>
		            </xsl:call-template>
		            
		            
		            
		        </xsl:for-each>
		        
		        
		    </xsl:for-each>
            
          -->  
           
		  
            <!-- Testing new Logic uncomment later-->
            <xsl:for-each
                select="msd/event[ (@sequence_number &lt; $end_filter) and (@sequence_number &gt; $start_filter)]">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="Sid" select="@srcInstanceId"/>
                <xsl:variable name="Did" select="@dstInstanceId"/>
                <xsl:variable name="marker" select="@end_mark"/>
                <xsl:variable name="event_type" select="@eventType"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="descritpion" select="@description"/>
                <xsl:variable name="sequence" select="@sequence_number"/>

                <xsl:if test="($event_type='MESSAGE')">


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
                                    <xsl:value-of
                                        select="@py + ($actualH) + ($working_H * ($sequence))"/>
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
                            <xsl:with-param name="name" select="$name"/>
                            <xsl:with-param name="py" select="$sy"/>
                            <xsl:with-param name="w" select="$width"/>
                            <xsl:with-param name="h" select="($sy - $sy)"/>
                            <xsl:with-param name="marker" select="$marker"/>
                            <xsl:with-param name="id" select="concat('Message_',$id)"/>
                            <xsl:with-param name="seq_num" select="$sequence"/>
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
                                    <xsl:value-of
                                        select="@py + ($actualH) + ($working_H * ($sequence ))"/>
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
                            <xsl:with-param name="name" select="$name"/>
                            <xsl:with-param name="py" select="$sy"/>
                            <xsl:with-param name="w" select="$width"/>
                            <xsl:with-param name="h" select="($sy - $sy)"/>
                            <xsl:with-param name="marker" select="$marker"/>
                            <xsl:with-param name="id" select="concat('Message_',$id)"/>
                            <xsl:with-param name="seq_num" select="$sequence"/>
                        </xsl:call-template>

                    </xsl:if>

                    <xsl:if test="($ValidCount_Src = 0) and ($ValidCount_Dest > 0)">


                        <xsl:variable name="sy">
                            <xsl:for-each select="$model_coordinates/*">
                                <xsl:if test="@stateid=$Did">
                                    <xsl:value-of
                                        select="@py + ($actualH) + ($working_H * ($sequence))"/>
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
                            <xsl:with-param name="name" select="$name"/>
                            <xsl:with-param name="py" select="$sy"/>
                            <xsl:with-param name="w" select="$width"/>
                            <xsl:with-param name="h" select="($sy - $sy)"/>
                            <xsl:with-param name="marker" select="$marker"/>
                            <xsl:with-param name="id" select="concat('Message_',$id)"/>
                            <xsl:with-param name="seq_num" select="$sequence"/>
                        </xsl:call-template>

                    </xsl:if>

                </xsl:if>


                <xsl:if test="($event_type='INTERNAL_EVENT')">

                    <xsl:variable name="id">
                        <xsl:value-of select="$id"/>
                    </xsl:variable>

                    <xsl:variable name="Src_Inst_id">
                        <xsl:value-of select="$Sid"/>
                    </xsl:variable>

                    <xsl:variable name="sx">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Src_Inst_id">
                                <xsl:value-of select="@px + ($actualW div 2)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:variable name="sy">
                        <xsl:for-each select="$model_coordinates/*">
                            <xsl:if test="@stateid=$Src_Inst_id">
                                <xsl:value-of select="@py + ($actualH) + ($working_H * $sequence)"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:variable name="descritpion" select="@description"/>

                    <xsl:variable name="marker" select="@end_mark"/>


                    <xsl:call-template name="model_Event">
                        <xsl:with-param name="px" select="$sx"/>
                        <xsl:with-param name="py" select="$sy"/>
                        <xsl:with-param name="marker" select="$marker"/>
                        <xsl:with-param name="h" select="$working_H"/>
                        <xsl:with-param name="w" select="$workingW"/>
                        <xsl:with-param name="id" select="$id"/>
                        <xsl:with-param name="description" select="$descritpion"/>
                        <xsl:with-param name="seq_num" select="$sequence"/>
                        <xsl:with-param name="name" select="$name"/>
                    </xsl:call-template>

                </xsl:if>

            </xsl:for-each>
		    
		    
        
         <!--   <xsl:variable name="Sequence_sort">
                <xsl:for-each select="event">
                    <rec>
                        <xsl:attribute name="value">
                            <xsl:value-of select="@sequenceId"/>
                        </xsl:attribute>
                    </rec>
                </xsl:for-each>               
            </xsl:variable>

            <xsl:variable name="outputx" select="func:display($Sequence_sort)"/>
       
        
            <xsl:for-each select="$outputx/*">
               
                <xsl:variable name="seq_id" select="./rec/@value"/>
                
                <xsl:message> 
                Yahooo :<xsl:value-of select="$seq_id"></xsl:value-of>
                </xsl:message>
                
                <xsl:for-each select="event[@sequenceId=$seq_id]">
                    <xsl:message>
                        ID is : <xsl:value-of select="@id"/>
                    </xsl:message>
                </xsl:for-each>
                
            </xsl:for-each>
        -->
			
            
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
    
</xsl:stylesheet>