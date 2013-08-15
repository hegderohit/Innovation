<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg" xmlns:func="http://innovation3g.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs func">

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
-->            </rec>
        </xsl:variable>

        
        
        <xsl:sequence select="$system_attributes"/>

    </xsl:function>
    
    










    <!--   
        Template matches the input Protocol XML file and calls the template for each of the tags matched.
        P(X,Y) , Height , Width and ID are teh common variables for each of te template.
        Each template creats an SVG model or component that can be drawn on the screen.
    -->
<!--
    <xsl:template match="protocol">
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg">

            <!-\- TODO [Add Stroke Variables] -\->

            <!-\-  Calling System Component Template
                Draws the System component to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : System Component Model-\->
            <xsl:call-template name="system_component">
                <xsl:with-param name="px" select="100"/>
                <xsl:with-param name="py" select="100"/>
                <xsl:with-param name="w" select="200"/>
                <xsl:with-param name="h" select="150"/>
                <xsl:with-param name="name" select="Name"/>
                <xsl:with-param name="description" select="description"/>
                <xsl:with-param name="id" select="1"/>
            </xsl:call-template>

            <!-\-  Calling Sap Template
                Draws the SAP to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : SAP Component Model-\->
            <xsl:for-each select="sap">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>

                <xsl:call-template name="sap">
                    <xsl:with-param name="px" select="$px"/>
                    <xsl:with-param name="py" select="$py"/>
                    <xsl:with-param name="w" select="$w"/>
                    <xsl:with-param name="h" select="$h"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="description" select="$description"/>
                    <xsl:with-param name="id" select="$id"/>
                </xsl:call-template>
            </xsl:for-each>


            <!-\-  Calling Component Link
                Draws the Link to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : Link Component Model-\->
            <xsl:for-each select="link">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>

                <xsl:call-template name="component_link">
                    <xsl:with-param name="px" select="$px"/>
                    <xsl:with-param name="py" select="$py"/>
                    <xsl:with-param name="w" select="$w"/>
                    <xsl:with-param name="h" select="$h"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="description" select="$description"/>
                    <xsl:with-param name="id" select="$id"/>
                </xsl:call-template>
            </xsl:for-each>


            <!-\-  Calling System Process
                Draws the Link to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : System process Component Model-\->
            <xsl:for-each select="process">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>

                <xsl:call-template name="system_process">
                    <xsl:with-param name="px" select="$px"/>
                    <xsl:with-param name="py" select="$py"/>
                    <xsl:with-param name="w" select="$w"/>
                    <xsl:with-param name="h" select="$h"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="description" select="$description"/>
                    <xsl:with-param name="id" select="$id"/>
                </xsl:call-template>
            </xsl:for-each>


            <!-\-  Calling Database
                Draws the Db to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : Db Component Model-\->
            <xsl:for-each select="database">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>

                <xsl:call-template name="database">
                    <xsl:with-param name="px" select="$px"/>
                    <xsl:with-param name="py" select="$py"/>
                    <xsl:with-param name="w" select="$w"/>
                    <xsl:with-param name="h" select="$h"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="description" select="$description"/>
                    <xsl:with-param name="id" select="$id"/>
                </xsl:call-template>
            </xsl:for-each>


            <!-\-  Calling Model Interface
                Draws the Model Interface to the Screen
                Input : P(x,y) , Height and Width for the system Interface 
                and Saps to place on the Model
                OutPut : Interface Component Model-\->
            <xsl:for-each select="interface">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>


                <!-\- For each Interface all the saps are placed relative to the 
                    position of the P(X,Y) of The interface Model -\->

                <xsl:call-template name="system_interface">
                    <xsl:with-param name="px" select="$px"/>
                    <xsl:with-param name="py" select="$py"/>
                    <xsl:with-param name="w" select="$w"/>
                    <xsl:with-param name="h" select="$h"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="description" select="$description"/>
                    <xsl:with-param name="id" select="$id"/>
                </xsl:call-template>

                <xsl:call-template name="sap">
                    <xsl:with-param name="px" select="($px + ($w div 2) - (40))"/>
                    <xsl:with-param name="py" select="380"/>
                    <xsl:with-param name="w" select="80"/>
                    <xsl:with-param name="h" select="40"/>
                    <xsl:with-param name="name" select="Name1"/>
                    <xsl:with-param name="description" select="Description1"/>
                    <xsl:with-param name="id" select="2"/>
                </xsl:call-template>
                <xsl:call-template name="sap">
                    <xsl:with-param name="px" select="910"/>
                    <xsl:with-param name="py" select="580"/>
                    <xsl:with-param name="w" select="80"/>
                    <xsl:with-param name="h" select="40"/>
                    <xsl:with-param name="name" select="Name1"/>
                    <xsl:with-param name="description" select="Description1"/>
                    <xsl:with-param name="id" select="3"/>
                </xsl:call-template>

                <xsl:call-template name="sap">
                    <xsl:with-param name="px" select="780"/>
                    <xsl:with-param name="py" select="460"/>
                    <xsl:with-param name="w" select="40"/>
                    <xsl:with-param name="h" select="80"/>
                    <xsl:with-param name="name" select="Name1"/>
                    <xsl:with-param name="description" select="Description1"/>
                    <xsl:with-param name="id" select="4"/>
                </xsl:call-template>

                <xsl:call-template name="sap">
                    <xsl:with-param name="px" select="1080"/>
                    <xsl:with-param name="py" select="460"/>
                    <xsl:with-param name="w" select="40"/>
                    <xsl:with-param name="h" select="80"/>
                    <xsl:with-param name="name" select="Name1"/>
                    <xsl:with-param name="description" select="Description1"/>
                    <xsl:with-param name="id" select="5"/>
                </xsl:call-template>

            </xsl:for-each>

        </svg>

    </xsl:template>

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
    
    <xsl:template match="gsf">
        
        <xsl:param name="component1_px" select="5"/>
        <xsl:param name="component1_py" select="5"/>
        <xsl:param name="component1_w" select="500"/>
        <xsl:param name="component1_h" select="700"/>
        
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg">
            
            <!-- TODO [Add Stroke Variables] -->
            
            <xsl:variable name="system_count">
                <xsl:value-of select="count(gsfComponent[contains(@scnm,'System')])"/>
            </xsl:variable>
             
            <xsl:message>
                system_count : <xsl:value-of select="$system_count"/>
            </xsl:message>
            
            <!-- Implementing Part 3 
            Assuming H  > W [TODO W > H]-->
            <xsl:variable name="working_Position">
                <xsl:if test="$component1_h > $component1_w"> 
                    <xsl:value-of select="($component1_h div $system_count)"></xsl:value-of>
                </xsl:if>     
            </xsl:variable>
            
            <xsl:variable name="distance" select="20"/>

            <!-- Consider the Systems -->
            <xsl:for-each select="gsfComponent[contains(@scnm,'System')]">

              <!--  <xsl:variable name="system_attributes" select="func:getPoints($working_Position,position(),$distance)"/>
                 -->                             
                            
              <!--  <xsl:message>
                    sysmtem_px :
                        <xsl:value-of select="tokenize($system_attributes,'2')"/>
                    
                   
                </xsl:message>                         
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
                             
                <xsl:call-template name="system_component">
                    <xsl:with-param name="px" select="$system_px"/>
                    <xsl:with-param name="py" select="$system_py"/>
                    <xsl:with-param name="w" select="$system_w"/>
                    <xsl:with-param name="h" select="$system_h"/>
                    <xsl:with-param name="name" select="$system_name"/>
                    <xsl:with-param name="id" select="$sysmtem_id"/>                   
                </xsl:call-template>

    
                <!-- For each sub system in a given system -->
                <xsl:variable name="subsystem_count">
                    <xsl:value-of select="count(SystemEntity)"/>
                </xsl:variable>

                <xsl:variable name="subworking_Position">
                    <xsl:if test="$system_h > $system_w"> 
                        <xsl:value-of select="($system_h div $subsystem_count)"/>
                    </xsl:if>     
                </xsl:variable>
                
                <xsl:variable name="subdistance" select="5"/>
                
                <xsl:message> 
                    subsystem_count : <xsl:value-of select="$subsystem_count"/>
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
                    
                    <xsl:call-template name="system_component">
                        <xsl:with-param name="px" select="$subsystem_px"/>
                        <xsl:with-param name="py" select="$subsystem_py"/>
                        <xsl:with-param name="w" select="$subsystem_w"/>
                        <xsl:with-param name="h" select="$subsystem_h"/>
                        <xsl:with-param name="name" select="$subsystem_name"/>
                        <xsl:with-param name="id" select="$subsysmtem_id"/>                   
                    </xsl:call-template>
                    

                    <xsl:variable name="model_count">
                        <xsl:value-of select="count(gsfComponent)"/>
                    </xsl:variable>
                    
                    <xsl:message> Model-Count : <xsl:value-of select="$model_count"/>
                    </xsl:message>

                </xsl:for-each>


            </xsl:for-each>
                      
            <rect width="{$component1_w}" height="{$component1_h}" x="{$component1_px}"
                y="{$component1_py}" stroke-width="1" stroke="black" fill="none"/>
        
        </svg>
        
    </xsl:template>
    
    


</xsl:stylesheet>