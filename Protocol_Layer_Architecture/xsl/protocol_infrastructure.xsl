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


    <!--   
        Template matches the input Protocol XML file and calls the template for each of the tags matched.
        P(X,Y) , Height , Width and ID are teh common variables for each of te template.
        Each template creats an SVG model or component that can be drawn on the screen.
    -->

    <xsl:template match="protocol">
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg">

            <!-- TODO [Add Stroke Variables] -->

            <!--  Calling System Component Template
                Draws the System component to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : System Component Model-->
            <xsl:call-template name="system_component">
                <xsl:with-param name="px" select="100"/>
                <xsl:with-param name="py" select="100"/>
                <xsl:with-param name="w" select="200"/>
                <xsl:with-param name="h" select="150"/>
                <xsl:with-param name="name" select="Name"/>
                <xsl:with-param name="description" select="description"/>
                <xsl:with-param name="id" select="1"/>
            </xsl:call-template>

            <!--  Calling Sap Template
                Draws the SAP to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : SAP Component Model-->
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


            <!--  Calling Component Link
                Draws the Link to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : Link Component Model-->
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


            <!--  Calling System Process
                Draws the Link to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : System process Component Model-->
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


            <!--  Calling Database
                Draws the Db to the Screen
                Input : P(x,y) , Height and Width 
                OutPut : Db Component Model-->
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


            <!--  Calling Model Interface
                Draws the Model Interface to the Screen
                Input : P(x,y) , Height and Width for the system Interface 
                and Saps to place on the Model
                OutPut : Interface Component Model-->
            <xsl:for-each select="interface">
                <xsl:variable name="id" select="@id"/>
                <xsl:variable name="px" select="@x"/>
                <xsl:variable name="py" select="@y"/>
                <xsl:variable name="h" select="@h"/>
                <xsl:variable name="w" select="@w"/>
                <xsl:variable name="name" select="@name"/>
                <xsl:variable name="description" select="@description"/>


                <!-- For each Interface all the saps are placed relative to the 
                    position of the P(X,Y) of The interface Model -->

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



</xsl:stylesheet>