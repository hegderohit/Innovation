<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs func"
    xmlns:gsfm="http://www.innovation3g.com/gsf/model">

    <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>

    <!-- Include all the Modules/ Components of the system -->
    <xsl:include href="system_component.xsl"/>
    <xsl:include href="system_module.xsl"/>
    <xsl:include href="system_process.xsl"/>
    <xsl:include href="system_interface.xsl"/>
    <xsl:include href="protocol_stack.xsl"/>
    <xsl:include href="protocol_layer.xsl"/>
    <xsl:include href="component_link.xsl"/>
    <xsl:include href="sap.xsl"/>
    <xsl:include href="database.xsl"/>
    <xsl:include href="system_flow.xsl"/>


    <xsl:param name="component1_px" select="0"/>
    <xsl:param name="component1_py" select="0"/>
    <xsl:param name="component1_w" select="500"/>
    <xsl:param name="component1_h" select="700"/>



    <xsl:function name="func:getPoints" as="item()*">
        <xsl:param name="working_Position"/>
        <xsl:param name="system_position"/>
        <xsl:param name="distance"/>


        <xsl:variable name="system_attributes">
            <rec>
                <xsl:attribute name="px">
                    <xsl:value-of select="$component1_px"/>
                </xsl:attribute>

                <xsl:attribute name="py">
                    <xsl:value-of
                        select="((($system_position - 1 ) * $working_Position) + ($working_Position div 2)) - (($working_Position div 2) - $distance)"
                    />
                </xsl:attribute>

                <!--<h>
                    <xsl:value-of select="($working_Position - (2 * $distance))"/>
                </h>
           
                <w>
                    <xsl:value-of select="($component1_w)"/>
                </w>
-->
            </rec>
        </xsl:variable>



        <xsl:sequence select="$system_attributes"/>

    </xsl:function>



    <!-- Main template
        Input: Match the Xml 
        output: Calls the protocol template -->
    <xsl:template name="main_template" match=".">
        <xsl:for-each select="/gsf">
            <xsl:call-template name="protocol">
                <xsl:with-param name="default_context" select="."/>
                <xsl:with-param name="component1_px" select="0"/>
                <xsl:with-param name="component1_py" select="0"/>
                <xsl:with-param name="component1_w" select="500"/>
                <xsl:with-param name="component1_h" select="700"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>



    <!--   
        Template matches the input Protocol XML file and calls the template for each of the tags matched.
        P(X,Y) , Height , Width and ID are teh common variables for each of te template.
        Each template creats an SVG model or component that can be drawn on the screen.
    -->

    <!-- New Logic try 1
    
    Read the Main system form the XML
 -> calculate the P(x,y) H and W 
	using the param for screen size
 
 -> Count the total number of sub systems

 -> Now find the locations to place the subs insid ethe Main system
	
	for each sub
	1) if( H > W )
		place the subs alon gthe height
		wh,
		y = H / Count
 
 	2) else
		place them along the width
		wh,
		x = W / count

		and, place the subs with centers

		center = [position - 1] * (Wh) + [Wh / 2] 
	Mainitian a distance of L between them.
    -->

    <xsl:template name="protocol">

        <xsl:param name="default_context"/>
        <xsl:param name="component1_px"/>
        <xsl:param name="component1_py"/>
        <xsl:param name="component1_w"/>
        <xsl:param name="component1_h"/>

        <svg version="1.1" xmlns="http://www.w3.org/2000/svg">

            <!-- TODO [Add Stroke Variables]
            H >W assumed -->

            <!-- Variable to count total number of system -->
            <xsl:variable name="system_count">
                <xsl:value-of
                    select="count($default_context/gsfComponent[contains(@scnm,'System')])"/>
            </xsl:variable>

            <xsl:message> system_count : <xsl:value-of select="$system_count"/>
            </xsl:message>

            <!-- Implementing Part 3 
            Assuming H  > W [TODO W > H]-->
            <xsl:variable name="working_Position">
                <xsl:if test="$component1_h > $component1_w">
                    <xsl:value-of select="($component1_h div $system_count)"/>
                </xsl:if>
            </xsl:variable>

            <xsl:variable name="distance" select="20"/>

            <!-- Consider the Systems -->
            <xsl:for-each select="$default_context/gsfComponent[contains(@scnm,'System')]">

                <!--  [TODO Function call]
                  
                  <xsl:variable name="system_attributes" select="func:getPoints($working_Position,position(),$distance)"/>
                 -->
                <xsl:variable name="sysmtem_id">
                    <xsl:value-of select="@scid"/>
                </xsl:variable>

                <xsl:variable name="system_name">
                    <xsl:value-of select="@scnm"/>
                </xsl:variable>


                <xsl:variable name="system_px">
                    <xsl:value-of select="$component1_px"/>
                </xsl:variable>

                <xsl:variable name="system_py">
                    <xsl:value-of
                        select="$component1_py + ((((position() - 1 ) * $working_Position) + ($working_Position div 2)) - (($working_Position div 2) - $distance))"
                    />
                </xsl:variable>

                <xsl:variable name="system_h">
                    <xsl:value-of select="($working_Position - (2 * $distance))"/>
                </xsl:variable>

                <xsl:variable name="system_w">
                    <xsl:value-of select="($component1_w)"/>
                </xsl:variable>

                <xsl:variable name="system_type" select="COMPONENT"/>




                <xsl:call-template name="system_component">
                    <xsl:with-param name="px" select="$system_px"/>
                    <xsl:with-param name="py" select="$system_py"/>
                    <xsl:with-param name="w" select="$system_w"/>
                    <xsl:with-param name="h" select="$system_h"/>
                    <xsl:with-param name="name" select="$system_name"/>
                    <xsl:with-param name="id" select="$sysmtem_id"/>
                </xsl:call-template>



                <!-- For each sub system in a given system.............................................. -->
                <xsl:variable name="subsystem_count">
                    <xsl:value-of select="count(SystemEntity)"/>
                </xsl:variable>

                <xsl:variable name="subworking_Position">
                    <xsl:if test="$system_h > $system_w">
                        <xsl:value-of select="($system_h div $subsystem_count)"/>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="subdistance" select="5"/>

                <xsl:message> subsystem_count : <xsl:value-of select="$subsystem_count"/>
                </xsl:message>



                <xsl:for-each select="SystemEntity">

                    <xsl:variable name="subsysmtem_id">
                        <xsl:value-of select="@sctind"/>
                    </xsl:variable>

                    <xsl:variable name="subsystem_name">
                        <xsl:value-of select="concat('Sub_',position())"/>
                    </xsl:variable>

                    <xsl:variable name="subsystem_px">
                        <xsl:value-of select="$system_px"/>
                    </xsl:variable>

                    <xsl:variable name="subsystem_py">
                        <xsl:value-of
                            select="$system_py + ((((position() - 1 ) * $subworking_Position) + ($subworking_Position div 2)) - (($subworking_Position div 2) - $subdistance))"
                        />
                    </xsl:variable>

                    <xsl:variable name="subsystem_h">
                        <xsl:value-of select="($subworking_Position - (2 * $subdistance))"/>
                    </xsl:variable>

                    <xsl:variable name="subsystem_w">
                        <xsl:value-of select="($system_w)"/>
                    </xsl:variable>

                    <xsl:variable name="subsystem_type" select="COMPONENT"/>




                    <!-- x="{$subsystem_px}" y="{$subsystem_py}"
                            w="{$subsystem_w }" h="{$subsystem_h}" u="em" id="{$subsysmtem_id}"
                            name="{$subsystem_name}" description=""-->
                    <!--<componentIdentityProperties cid="{$subsystem_name}"
                            ciid="{concat('SubsystemGroup_',$subsysmtem_id)}"
                            cns="http://www.innovation3g.com/gsf" ct="{$subsystem_type}" pcId=""
                            pcns="http://www.innovation3g.com/gsf"/>-->





                    <xsl:call-template name="system_component">
                        <xsl:with-param name="px" select="$subsystem_px"/>
                        <xsl:with-param name="py" select="$subsystem_py"/>
                        <xsl:with-param name="w" select="$subsystem_w"/>
                        <xsl:with-param name="h" select="$subsystem_h"/>
                        <xsl:with-param name="name" select="$subsystem_name"/>
                        <xsl:with-param name="id" select="$subsysmtem_id"/>

                        <!-- <xsl:with-param name="componentProperties" select="1"/>-->

                    </xsl:call-template>



                    <!--  Models inside the sub systems .........................................-->

                    <!-- Logic for placing the components inside a system,
                            
1) I have used a grid system.

Assuming H > W

Divide the width into 2 grids 
and Height based on the count of components (Basically combine 2 units in a row)

So,

Working_Width = total width of system / 2;
Working wodth = total Height / (Count div 2);

Now,

For each of the component in the subsystem, 
  	match the id with Id's of given components
	if found,
		Calcualte the PX and PY , H and W (ALL ODDS on coloumn 1 and evens on coloumn 2)
		Call template
		
end for
-->




                    <xsl:variable name="component_count">
                        <xsl:value-of select="count(gsfComponent)"/>
                    </xsl:variable>

                    <xsl:message> Model-Count : <xsl:value-of select="$component_count"/>
                    </xsl:message>

                    <xsl:variable name="componentworking_width">

                        <xsl:value-of select="($subsystem_w div 2)"/>

                    </xsl:variable>

                    <xsl:variable name="componentworking_height">

                        <xsl:value-of select="round($subsystem_h div round($component_count div 2))"/>

                    </xsl:variable>

                    <xsl:variable name="component_distane" select="5"/>

                    <!-- For each component-->
                    
                    <xsl:variable name="spacing" select="15"/>
                    
                    <xsl:variable name="subsystem_w"
                        select="($componentworking_width - (2 * $component_distane))"/>
                    <xsl:variable name="subsystem_h"
                        select="($componentworking_height - (2 * $component_distane))"/>
                    
                    <!-- 
                    This variables holds the container details for each component
                    1) ID
                    2) X 
                    3) Y
                    4) W
                    5) H
                    6) Name
                    7) Description
                    8) type
                    
                    Part 1 : Call the tepmlate to Draw these models
                    Part 2 : Call the template to draw the Link
                    -->
                        
                    
                    
                    <xsl:variable name="component_properties">
                        <xsl:for-each select="gsfComponent">
                            <xsl:variable name="component_scid" select="@scid"/>
                            <rec>
                                <xsl:attribute name="baseid">
                                    <xsl:value-of select="@scid"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat($subsysmtem_id,@scid)"/>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:for-each
                                        select="$default_context/gsfComponent[@scid=$component_scid]">
                                        <xsl:value-of select="@scnm"/>
                                    </xsl:for-each>
                                </xsl:attribute>
                                <xsl:attribute name="type">
                                    <xsl:for-each
                                        select="$default_context/gsfComponent[@scid=$component_scid]/*">
                                        <xsl:value-of select="@sctind"/>
                                    </xsl:for-each>
                                </xsl:attribute>
                                <xsl:attribute name="description">
                                    <xsl:for-each
                                        select="$default_context/gsfComponent[@scid=$component_scid]">
                                        <xsl:value-of select="@scd"/>
                                    </xsl:for-each>
                                </xsl:attribute>
                                <xsl:attribute name="x">
                                    <xsl:if test="(position() mod 2) = 0">
                                        <xsl:value-of
                                            select="$subsystem_px +  ((($componentworking_width div 2)) - (($componentworking_width div 2) - $component_distane))"
                                        />
                                    </xsl:if>

                                    <xsl:if test="(position() mod 2) = 1">
                                        <xsl:value-of
                                            select="$subsystem_px +  ((($componentworking_width div 2) + $componentworking_width) - (($componentworking_width div 2) - $component_distane))"
                                        />
                                    </xsl:if>
                                </xsl:attribute>
                                <xsl:attribute name="y">
                                    <xsl:if test="(position() mod 2) = 0">
                                        <xsl:value-of
                                            select="$subsystem_py + ((((position() - (round(position() div 2) + 1)) * $componentworking_height) + ($componentworking_height div 2)) - (($componentworking_height div 2) - $component_distane))"
                                        />
                                    </xsl:if>

                                    <xsl:if test="(position() mod 2) = 1">
                                        <xsl:value-of
                                            select="$subsystem_py + ((((position() - round(position() div 2) ) * $componentworking_height) + ($componentworking_height div 2)) - (($componentworking_height div 2) - $component_distane))"
                                        />
                                    </xsl:if>
                                </xsl:attribute>
                                <xsl:attribute name="w">
                                    <xsl:value-of select="($subsystem_w - (2 * $spacing))"/>
                                </xsl:attribute>
                                <xsl:attribute name="h">
                                    <xsl:value-of select="($subsystem_h - (2 * $spacing))"/>
                                </xsl:attribute>
                            </rec>

                        </xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:call-template name="draw_component">
                        <xsl:with-param name="component_properties" select="$component_properties"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="draw_link">
                        <xsl:with-param name="component_properties" select="$component_properties"/>
                        <xsl:with-param name="context" select="$default_context"></xsl:with-param>
                    </xsl:call-template>
   
                  <!--  <xsl:message>
                        
                        -\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-
                        
                        2nd option : 
                        <xsl:for-each select="$component_properties/*">
                        <xsl:value-of select="@x"></xsl:value-of>
                            <xsl:value-of select='111111111'/>
                        </xsl:for-each>
                        -\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-
                    </xsl:message>
-->
                </xsl:for-each>


            </xsl:for-each>

            <rect width="{$component1_w}" height="{$component1_h}" x="{$component1_px}"
                y="{$component1_py}" stroke-width="1" stroke="black" fill="none"/>

        </svg>

    </xsl:template>


<!-- Tmplate Name : Draw_Component 
     Input : component_properties 
     Output: Svg file with the modles placed
     Working : Thus template has all the positions P(X,Y)  H and W for each of the component in the subsystem....
     So, Call the specific template by using the Xsl:IF statements
    -->
    <xsl:template name="draw_component">
        <xsl:param name="component_properties"/>

        <!--  <xsl:variable name="component_scid" select="@scid"/>
        
                        <xsl:variable name="component_name">
                            <xsl:for-each
                                select="$default_context/gsfComponent[@scid=$component_scid]">
                                <xsl:value-of select="@scnm"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="component_type">
                            <xsl:for-each
                                select="$default_context/gsfComponent[@scid=$component_scid]/*">
                                <xsl:value-of select="@sctind"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="component_description">
                            <xsl:for-each
                                select="$default_context/gsfComponent[@scid=$component_scid]">
                                <xsl:value-of select="@scd"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:message> SCNM : <xsl:value-of select="$component_name"/> component_type
                            : <xsl:value-of select="$component_type"/>
                        </xsl:message>
                        
                        <xsl:variable name="component_px">
                        
                            <xsl:if test="(position() mod 2) = 0">
                                <xsl:value-of
                                    select="$subsystem_px +  ((($componentworking_width div 2)) - (($componentworking_width div 2) - $component_distane))"
                                />
                            </xsl:if>
                            
                            <xsl:if test="(position() mod 2) = 1">
                                <xsl:value-of
                                    select="$subsystem_px +  ((($componentworking_width div 2) + $componentworking_width) - (($componentworking_width div 2) - $component_distane))"
                                />
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="component_py">
                        
                            <xsl:if test="(position() mod 2) = 0">
                                <xsl:value-of
                                    select="$subsystem_py + ((((position() - (round(position() div 2) + 1)) * $componentworking_height) + ($componentworking_height div 2)) - (($componentworking_height div 2) - $component_distane))"
                                />
                            </xsl:if>
                            
                            <xsl:if test="(position() mod 2) = 1">
                                <xsl:value-of
                                    select="$subsystem_py + ((((position() - round(position() div 2) ) * $componentworking_height) + ($componentworking_height div 2)) - (($componentworking_height div 2) - $component_distane))"
                                />
                            </xsl:if>
                        </xsl:variable>
                        
                        <xsl:variable name="subsystem_w"
                            select="($componentworking_width - (2 * $component_distane))"/>
                        <xsl:variable name="subsystem_h"
                            select="($componentworking_height - (2 * $component_distane))"/>
                            
                            -->
        <!--
     [TODO SINGLE VARIABLE LOGIC GOES IN HERE]
                        <xsl:element name="containerModelProperties">
                           <!-\- <xsl:attribute name="x" select="$component_py"/>
                            <xsl:attribute name="y" select="$component_py"/>
                            <xsl:attribute name="w"
                                select="($componentworking_width - (2 * $component_distane))"/>
                            <xsl:attribute name="h"
                                select="($componentworking_height - (2 * $component_distane))"/>
                            <xsl:attribute name="u" select="em"/>
                            <xsl:attribute name="id" select="$component_scid"/>
                            <xsl:attribute name="name" select="$component_name"/>-\->
                            
                        </xsl:element>
                          
-->

        <!--[Draws the container / BOX for the Component]
            <xsl:call-template name="system_component">
                            <xsl:with-param name="px" select="$component_px"/>
                            <xsl:with-param name="py" select="$component_py"/>
                            <xsl:with-param name="w" select="$subsystem_w"/>
                            <xsl:with-param name="h" select="$subsystem_h"/>
                            <xsl:with-param name="name" select="$component_name"/>
                            <xsl:with-param name="id" select="$component_scid"/>
                            <xsl:with-param name="description" select="$component_description"/>
                        </xsl:call-template>-->
        
        <!--   [TODO THE single variable thingy]
            <xsl:variable name="componentProperties2">
            <containerModelProperties>
                <x>
                    <xsl:value-of select="100"/>
                </x>
                <y>
                    <xsl:value-of
                        select="(($component_py + ($subsystem_h div 2) )- (($subsystem_h div 2) - $spacing))"
                    />
                </y>
                <w>
                    <xsl:value-of select="($subsystem_w - (2 * $spacing))"/>
                </w>
                <h>
                    <xsl:value-of select="($subsystem_h - (2 * $spacing))"/>
                </h>
                <name>
                    <xsl:value-of select="$component_name"/>
                </name>
                <id>
                    <xsl:value-of select="$component_scid"/>
                </id>
            </containerModelProperties>
        </xsl:variable>
        
        -->                   
        

        <xsl:for-each select="$component_properties/*">
           
            <!-- Call system_process template if matched -->
            <xsl:if test="./@type='PROCESS'">
                <xsl:call-template name="system_process">
                    <xsl:with-param name="px" select="./@x"/>
                    <xsl:with-param name="py" select=" ./@y"/>
                    <xsl:with-param name="w" select="./@w"/>
                    <xsl:with-param name="h" select="./@h"/>
                    <xsl:with-param name="name" select="./@name"/>
                    <xsl:with-param name="id" select="./@id"/>
                </xsl:call-template>
            </xsl:if>
            
            <!-- Call database template if matched -->
            <xsl:if test="./@type='DATA_STORE'">
                <xsl:call-template name="database">
                    <xsl:with-param name="px" select="./@x"/>
                    <xsl:with-param name="py" select=" ./@y"/>
                    <xsl:with-param name="w" select="./@w"/>
                    <xsl:with-param name="h" select="./@h"/>
                    <xsl:with-param name="name" select="./@name"/>
                    <xsl:with-param name="id" select="./@id"/>
                </xsl:call-template>       
            </xsl:if>
            
        </xsl:for-each>

       
    </xsl:template>
   
   
   
   <xsl:template name="draw_link">
       <xsl:param name="component_properties"/>
       <xsl:param name="context"/>
       <xsl:variable name="link_count">
           <xsl:value-of select="count($context/gsfComponent[contains(@scd,'link')])"></xsl:value-of>
       </xsl:variable>
       
       <xsl:message>
           LINK ________ COunt : 
           <xsl:for-each select="$context/gsfComponent/SystemComponentLink[@sctind='LINK']">
               hii1
               hii2
               <xsl:variable name="src_id" select="./@srcCid"/>
               
               <xsl:variable name="sx">
                 
                   <xsl:for-each select="$component_properties/*">
                       <xsl:if test="(./@baseid=$src_id)">
                           hiii4
                           <xsl:value-of select="./@x"/>
                       </xsl:if>
                   </xsl:for-each>
               </xsl:variable>
               
               <!--<xsl:value-of select="$src_id"/>-->
               
           </xsl:for-each>
       </xsl:message>
       
       <xsl:for-each select="$context/gsfComponent/SystemComponentLink[@sctind='LINK']">
           <xsl:variable name="id" select="./@scid"/>
           <xsl:variable name="src_id" select="./@srcCid"/>
           <xsl:variable name="dest_id" select="./@dstCid"/>
           <xsl:variable name="name" select="./@scnm"/>
           <xsl:variable name="desc" select="./@scd"/>
           
           <xsl:variable name="sx">
               <xsl:for-each select="$component_properties/*">
                   <xsl:if test="./@baseid=$src_id">
                       <xsl:value-of select="./@x"/>
                   </xsl:if>
               </xsl:for-each>
           </xsl:variable>
           <xsl:variable name="ex">
               <xsl:for-each select="$component_properties/*">
                   <xsl:if test="./@baseid=$dest_id">
                       <xsl:value-of select="./@x"/>
                   </xsl:if>
               </xsl:for-each>
           </xsl:variable>
           
           <xsl:variable name="sy">
               <xsl:for-each select="$component_properties/*">
                   <xsl:if test="./@baseid=$src_id">
                       <xsl:value-of select="./@y"/>
                   </xsl:if>
               </xsl:for-each>
           </xsl:variable>
           <xsl:variable name="ey">
               <xsl:for-each select="$component_properties/*">
                   <xsl:if test="./@baseid=$dest_id">
                       <xsl:value-of select="./@y"/>
                   </xsl:if>
               </xsl:for-each>
           </xsl:variable>
           
           <xsl:call-template name="component_link">
               <xsl:with-param name="px" select="$sx"/>
               <xsl:with-param name="py" select="$sy" />
               <xsl:with-param name="w" select="$ex"/>
               <xsl:with-param name="h" select="$ey"/>
               <xsl:with-param name="name" select="$name"/>
               <xsl:with-param name="description" select="$desc"/>
               <xsl:with-param name="id" select="$id"/>
           </xsl:call-template>
           
           
       </xsl:for-each>
       
   </xsl:template>
   
   
</xsl:stylesheet>