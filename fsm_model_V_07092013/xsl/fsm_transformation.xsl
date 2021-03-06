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

	<!-- Functions -->
	<xsl:param name="delimiter" select="','"/>

	<xsl:function name="func:getSize" as="item()*">
		<xsl:param name="component1_w"/>
		<xsl:param name="component1_h"/>
		
		
		<xsl:variable name="refwidth" select="800"/>
		<xsl:variable name="refheight" select="600"/>
		<xsl:variable name="refmodelheight" select="140"/>
		<xsl:variable name="refmodelwidth" select="180"/>
		
		<xsl:variable name="perentage_diff">
			<xsl:if test="($component1_w &gt; $refwidth )">
			<xsl:value-of select="(($component1_w - $refwidth) div ($refwidth))"/>
			</xsl:if>
			<xsl:if test="($component1_w &lt; $refwidth )">
				<xsl:value-of select="(($component1_w - $refwidth) div ($refwidth))"/>
			</xsl:if>
			
		</xsl:variable>
		
		<xsl:message>
			--------------------------------------------------------------------------------
			Perc Diff: <xsl:value-of select="$perentage_diff"/>
			--------------------------------------------------------------------------------
		</xsl:message>
		
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
			<rec>
				<value>
					<xsl:value-of select="$sorted/rec[1]/@value"/>
				</value>
			</rec>
			<rec>
				<value>
					<xsl:value-of select="$sorted/rec[last()]/@value"/>
				</value>
			</rec>
		</xsl:variable>

		<xsl:sequence select="$output"/>


	</xsl:function>


	<xsl:function name="func:getRecord" as="item()*">
		<xsl:param name="states"/>
		<xsl:param name="transitions"/>
		<xsl:param name="state_ordinates"/>
		<xsl:param name="actualH"/>
		<xsl:param name="actualW"/>

		<xsl:for-each select="$transitions/*">
			<xsl:message>
				Position() : <xsl:value-of select="position()"></xsl:value-of>
				
			</xsl:message>
		</xsl:for-each>

		<xsl:for-each select="$state_ordinates/*">


			<!-- 4basic variables needed for each state -->
			<xsl:variable name="id" select="@stateid"/>
			<xsl:variable name="linecount"
				select="count(($transitions[@Source=$id])|($transitions[@Destination=$id]))"/>
			<xsl:variable name="workingH">
				<xsl:value-of select="($actualH div ($linecount + 1))"/>
			</xsl:variable>
			<xsl:variable name="position" select="position()"/>
			<xsl:variable name="rank" select="@rank"/>
			<xsl:variable name="side" select="@side"></xsl:variable>
			
			
			<xsl:variable name="px" select="@px"/>
			
			<xsl:variable name="py" select="@py"/>
			
			<xsl:variable name="line_count">
				<xsl:value-of select="($transitions[@Source=$id]) and (($transitions[@Destination=./$state_ordinates/rec[@stateid]]) and ./$state_ordinates/rec[@side=$side])"/>
				
			</xsl:variable>

			<xsl:message> 
				Nodess : <xsl:value-of select="@stateid"/>
				Count :<xsl:value-of select="$linecount"/>
				Working H:<xsl:value-of select="$workingH"/>
				line_count)(::: <xsl:value-of select="$line_count"/>
			</xsl:message>

			
			
			<xsl:variable name="output">
				<!-- [TODO later] -->
				<!-- Transitions with destination on the state  
			<for each line>
						[condition : dest=state_id]
							<rec>
							Attributes : 
							<x>
							<y>
							<type = 1>
							<t_id>
							</rec>
						</for each>
			-->
				<!--<xsl:for-each select="(($transitions[@Destination=$id])|($transitions[@Destination=$id]))">
				<rec>
					<xsl:attribute name="state_id" select="$id"/>
					<xsl:attribute name="transition_id" select="@id"/>
					<xsl:attribute name="type" select="1"/>
					<xsl:attribute name="x">
						<xsl:if test="$side=1">
							<xsl:value-of select="($px + $actualW)"/>
						</xsl:if>
						<xsl:if test="$side=2">
							<xsl:value-of select="($px)"/>
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="y" select="($py)+($workingH * position())"/>
				</rec>
			</xsl:for-each>
				
				
				<!-\- Transitions with source on the state  
			<for each line>
						[condition : SRC=state_id]
							<rec>
							Attributes : 
							<x>
							<y>
							<type = 1>
							<t_id>
							</rec>
						</for each>
			-\->
				<xsl:for-each select="$transitions[@Source=$id]">
					<rec>
						<xsl:attribute name="state_id" select="$id"/>
						<xsl:attribute name="transition_id" select="@id"/>
						<xsl:attribute name="type" select="0"/>
						<xsl:attribute name="x">
							<xsl:if test="$side=1">
								<xsl:value-of select="($px + $actualW)"/>
							</xsl:if>
							<xsl:if test="$side=2">
								<xsl:value-of select="($px)"/>
							</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="y" select="($py)+($workingH * $position)"/>
					</rec>
				</xsl:for-each>

-->
				
				<xsl:for-each select="(($transitions[@Destination=$id])|($transitions[@Source=$id]))">
					<xsl:if test="$transitions[@Destination=$id]">
					<rec>
					<xsl:attribute name="state_id" select="$id"/>
					<xsl:attribute name="transition_id" select="@id"/>
					<xsl:attribute name="type" select="1"/>
					<xsl:attribute name="x">
						<xsl:if test="$side=1">
							<xsl:value-of select="($px + $actualW)"/>
						</xsl:if>
						<xsl:if test="$side=2">
							<xsl:value-of select="($px)"/>
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="y" select="($py)+($workingH * position())"/>
				</rec>
				</xsl:if>
				
				
				<!-- Transitions with source on the state  
			<for each line>
						[condition : SRC=state_id]
							<rec>
							Attributes : 
							<x>
							<y>
							<type = 1>
							<t_id>
							</rec>
						</for each>
			-->
					<xsl:if test="$transitions[@Source=$id]">
					<rec>
						<xsl:attribute name="state_id" select="$id"/>
						<xsl:attribute name="transition_id" select="@id"/>
						<xsl:attribute name="type" select="0"/>
						<xsl:attribute name="x">
							<xsl:if test="$side=1">
								<xsl:value-of select="($px + $actualW)"/>
							</xsl:if>
							<xsl:if test="$side=2">
								<xsl:value-of select="($px)"/>
							</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="y" select="($py)+($workingH * position())"/>
					</rec>
					</xsl:if>
				</xsl:for-each>			
			</xsl:variable>
			
			<!-- Retrun Value -->
			<xsl:sequence select="$output"/>
			
		</xsl:for-each>
	</xsl:function>




	<xsl:template name="fsm_model">

		<!-- New CODE goes in here-->

		<xsl:variable name="listx">
			<xsl:for-each select="state">
				<rec>
					<xsl:attribute name="value">
						<xsl:value-of select="@x"/>
					</xsl:attribute>
				</rec>
			</xsl:for-each>
			<xsl:for-each select="state">
				<rec>
					<xsl:attribute name="value">
						<xsl:value-of select="@x + @w"/>
					</xsl:attribute>
				</rec>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="listy">
			<xsl:for-each select="state">
				<rec>
					<xsl:attribute name="value">
						<xsl:value-of select="@y"/>
					</xsl:attribute>
				</rec>
			</xsl:for-each>
			<xsl:for-each select="state">
				<rec>
					<xsl:attribute name="value">
						<xsl:value-of select="@y + @h"/>
					</xsl:attribute>
				</rec>
			</xsl:for-each>
		</xsl:variable>


		<xsl:variable name="outputx" select="func:display($listx)"/>
		<xsl:variable name="outputy" select="func:display($listy)"/>


		<xsl:variable name="minx" select="$outputx/rec[1]/value"/>
		<xsl:variable name="maxx" select="$outputx/rec[2]/value"/>

		<xsl:variable name="miny" select="$outputy/rec[1]/value"/>
		<xsl:variable name="maxy" select="$outputy/rec[2]/value"/>

		<xsl:message> Min X : <xsl:value-of select="$minx"/>
		</xsl:message>




		<!-- Old Code-->
		<xsl:for-each select="./state">



			<xsl:variable name="width" select="@w"> </xsl:variable>
			<xsl:variable name="height" select="@h"> </xsl:variable>
			<xsl:variable name="px" select="@x"> </xsl:variable>
			<xsl:variable name="py" select="@y"> </xsl:variable>

			<xsl:variable name="stroke-width" select="@sw"> </xsl:variable>
			<xsl:variable name="stroke-format" select="@sf"> </xsl:variable>
			<xsl:variable name="stroke-color" select="@sc"> </xsl:variable>

			<xsl:variable name="fill-opacity" select="@transparency"> </xsl:variable>
			<xsl:variable name="fill" select="@fillcolor"> </xsl:variable>


			<!-- center x is x value of reference point P + width/2 -->
			<xsl:variable name="cx" select="$px + ($width div 2)"> </xsl:variable>

			<!-- center y is y value of reference point P + width/2 -->
			<xsl:variable name="cy" select="$py + ($height div 2)"> </xsl:variable>

			<xsl:variable name="rx" select="($width div 2)"> </xsl:variable>

			<xsl:variable name="ry" select="($height div 2)"> </xsl:variable>
			<xsl:variable name="id" select="@id"> </xsl:variable>

			<xsl:call-template name="ellpse">
				<xsl:with-param name="px" select="$px"/>
				<xsl:with-param name="py" select="$py"/>
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
				<xsl:with-param name="cx" select="$cx"/>
				<xsl:with-param name="cy" select="$cy"/>
				<xsl:with-param name="rx" select="$rx"/>
				<xsl:with-param name="ry" select="$ry"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="stroke-width" select="$stroke-width"/>
				<xsl:with-param name="stroke-format" select="$stroke-format"/>
				<xsl:with-param name="stroke-color" select="$stroke-color"/>
				<xsl:with-param name="fill-opacity" select="$fill-opacity"/>
				<xsl:with-param name="fill" select="$fill"/>

			</xsl:call-template>

			<xsl:for-each select="./description">
				<xsl:variable name="id1" select="@id"> </xsl:variable>

				<xsl:variable name="tempx" select="./parent::state/@cx"> </xsl:variable>
				<xsl:variable name="tempy" select="./parent::state/@cy"> </xsl:variable>

				<xsl:variable name="rx1" select="./parent::state/@r"> </xsl:variable>
				<xsl:variable name="ry1" select="($rx1 - 20)"> </xsl:variable>


				<xsl:variable name="x" select="(($tempx)-($rx1)+20)"> </xsl:variable>
				<xsl:variable name="y" select="($tempy)"> </xsl:variable>

				<xsl:call-template name="text">

					<xsl:with-param name="x" select="$x"/>
					<xsl:with-param name="y" select="$y"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>


		<xsl:for-each select="./transition">
			<xsl:variable name="id2" select="@id"> </xsl:variable>
			<xsl:variable name="Source" select="@Source"> </xsl:variable>
			<xsl:variable name="Destination" select="@Destination"> </xsl:variable>
			<xsl:variable name="stroke-width" select="@sw"> </xsl:variable>
			<xsl:variable name="stroke-format" select="@sf"> </xsl:variable>
			<xsl:variable name="stroke-color" select="@sc"> </xsl:variable>
			<xsl:variable name="fill-opacity" select="@transparency"> </xsl:variable>
			<xsl:variable name="fill" select="@fillcolor"> </xsl:variable>

			<xsl:variable name="px">
				<xsl:value-of select="./parent::fsm/state[@id=$Source]/@x"/>
			</xsl:variable>
			<xsl:variable name="py">
				<xsl:value-of select="./parent::fsm/state[@id=$Source]/@y"/>
			</xsl:variable>
			<xsl:variable name="height">
				<xsl:value-of select="./parent::fsm/state[@id=$Source]/@h"/>
			</xsl:variable>
			<xsl:variable name="width">
				<xsl:value-of select="./parent::fsm/state[@id=$Source]/@w"/>
			</xsl:variable>

			<xsl:variable name="cx" select="$px + ($width div 2)"> </xsl:variable>
			<!-- center y is y value of reference point P + width/2 -->
			<xsl:variable name="cy" select="$py + ($height div 2)"> </xsl:variable>
			<xsl:variable name="rx" select="($width div 2)"> </xsl:variable>
			<xsl:variable name="ry" select="($height div 2)"> </xsl:variable>





			<xsl:variable name="pxd">
				<xsl:value-of select="./parent::fsm/state[@id=$Destination]/@x"/>
			</xsl:variable>
			<xsl:variable name="pyd">
				<xsl:value-of select="./parent::fsm/state[@id=$Destination]/@y"/>
			</xsl:variable>
			<xsl:variable name="heightd">
				<xsl:value-of select="./parent::fsm/state[@id=$Destination]/@h"/>
			</xsl:variable>
			<xsl:variable name="widthd">
				<xsl:value-of select="./parent::fsm/state[@id=$Destination]/@w"/>
			</xsl:variable>


			<xsl:variable name="cxd" select="$pxd + ($widthd div 2)"> </xsl:variable>
			<!-- center y is y value of reference point P + width/2 -->
			<xsl:variable name="cyd" select="$pyd + ($heightd div 2)"> </xsl:variable>
			<xsl:variable name="rxd" select="($widthd div 2)"> </xsl:variable>
			<xsl:variable name="ryd" select="($heightd div 2)"> </xsl:variable>


			<xsl:variable name="markerid" select="@link"> </xsl:variable>



			<xsl:variable name="sx" select="($cx + $rx)"> </xsl:variable>
			<xsl:variable name="sy" select="($cy)"> </xsl:variable>
			<xsl:variable name="ex" select="($cxd - $rxd - 2)"> </xsl:variable>
			<xsl:variable name="ey" select="($cyd)"> </xsl:variable>

			<xsl:variable name="Width">
				<xsl:value-of select="($ex - $sx)"/>
			</xsl:variable>

			<xsl:variable name="Height">
				<xsl:value-of select="($ey - $sy)"/>
			</xsl:variable>


			<xsl:call-template name="liner">
				<xsl:with-param name="id" select="$id2"/>
				<xsl:with-param name="sx" select="$sx"/>
				<xsl:with-param name="ex" select="$ex"/>
				<xsl:with-param name="sy" select="$sy"/>
				<xsl:with-param name="ey" select="$ey"/>
				<xsl:with-param name="marker" select="$markerid"/>
				<xsl:with-param name="Width" select="$Width"/>
				<xsl:with-param name="Height" select="$Height"/>
				<xsl:with-param name="stroke-width" select="$stroke-width"/>
				<xsl:with-param name="stroke-format" select="$stroke-format"/>
				<xsl:with-param name="stroke-color" select="$stroke-color"/>
				<xsl:with-param name="fill-opacity" select="$fill-opacity"/>
				<xsl:with-param name="fill" select="$fill"/>

			</xsl:call-template>

			<xsl:for-each select="./description">
				<xsl:variable name="id3" select="@id"> </xsl:variable>
				<xsl:variable name="x">
					<xsl:value-of select="$sx+140"/>
				</xsl:variable>
				<xsl:variable name="y">
					<xsl:value-of select="$sy - 50"/>
				</xsl:variable>

				<xsl:call-template name="text_path">
					<xsl:with-param name="id3" select="$id3"/>
					<xsl:with-param name="x" select="$x"/>
					<xsl:with-param name="y" select="$y"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>

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



		<rect width="{$maxx - $minx}" height="{$maxy - $miny}" x="{$minx}" y="{$miny}"
			stroke-width="1" stroke="black" fill="none"/>


	</xsl:template>










	<xsl:template name="ellpse">
		<xsl:param name="cx"/>
		<xsl:param name="cy"/>
		<xsl:param name="rx"/>
		<xsl:param name="ry"/>
		<xsl:param name="id"/>
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
			stroke="black" fill="white"/>
		<ellipse cx="{$cx}" cy="{$cy}" rx="{$rx}" ry="{$ry}" id="{$id}" fill="{$fill}"
			stroke="{$stroke-color}" stroke-width="{$stroke-width}"/>
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
		<xsl:param name="decription"/>
		
		
		<text style="font-size:20;font-style:normal;fill:#000000;"
			onmouseover="show(evt, {$id2})" onmouseout="hide(evt, {$id2})" id="{$id1}">
			<tspan x="{$x + 10}" y="{$y}">
				<xsl:value-of select="$decription"/>
			</tspan>
		</text>
		<!--<text id="{$id2}" visibility="hidden" x="{$x}" y="{$y + 20}" text-anchor="middle"
			style="font-size:15;font-style:normal;fill:#000000;"> hidden text </text>-->
	</xsl:template>

	<xsl:template name="liner">
		<xsl:param name="id"/>
		<xsl:param name="sx"/>
		<xsl:param name="ex"/>
		<xsl:param name="sy"/>
		<xsl:param name="ey"/>
		<xsl:param name="marker"/>
		<xsl:param name="Width"/>
		<xsl:param name="Height"/>
		<xsl:param name="stroke-width"/>
		<xsl:param name="stroke-format"/>
		<xsl:param name="stroke-color"/>
		<xsl:param name="fill-opacity"/>
		<xsl:param name="fill"/>

		
		<line x1="{$sx}" y1="{$sy}" x2="{$ex}" y2="{$ey}" stroke="{$stroke-color}"
			marker-end="url(#{$marker})" id="{$id}" />
	</xsl:template>

	<xsl:template name="text_path">
		<xsl:param name="id3"/>
		<xsl:param name="x"/>
		<xsl:param name="y"/>

		<text style="font-size:30px;font-style:normal;fill:#000000;" id="{$id3}">
			<tspan x="{$x}" y="{$y}" id="{$id3}">
				<xsl:value-of select="."/>
			</tspan>
		</text>

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
			<path d="M 0 0 L -5 5 L -5 -5 Z" fill="currentColor" stroke="currentColor"
				stroke-width="{$stroke-width}"/>
		</marker>


	</xsl:template>
	<!--New COde ............................................................ -->


	<!--
        name: master
        Desc: Master Template.
        
        
        
        
    -->
	<!--<xsl:template name="master">

		<xsl:call-template name="process_fsm"/>

	</xsl:template>-->

	<!--
        name: FSM
        Desc: Template that matches and process 'fsm' tag from the document
    -->
	<xsl:template name="process_fsm" match="fsm">
		
		
		
		<xsl:param name="component1_px" select="5"/>
		<xsl:param name="component1_py" select="5"/>
		<xsl:param name="component1_w" select="800"/>
		<xsl:param name="component1_h" select="600"/>


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
			
			
			<xsl:variable name="auto_size" select="func:getSize($component1_w,$component1_h)"/>
			
			
			
			<!--
            Type : Variable
            Name : actualW
            Desc : Actuall width of the model with reference to the screen size
        -->
			<xsl:variable name="actualW">
				<xsl:value-of select="180"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : actualH
            Desc : Actuall height of the model with reference to the screen size
        -->
			<xsl:variable name="actualH">
				<xsl:value-of select="140"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : actualL
            Desc : Actuall Spacing between the model with reference to the screen size
        -->
			<xsl:variable name="actualL">
				<xsl:value-of select="100"/>
			</xsl:variable>
			
			<xsl:variable name="actualLh">
				<xsl:value-of select="40"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : P0
            Desc : Reference Point (Points to the Middle of the Screen)
        -->
			<xsl:variable name="P0">
				<xsl:value-of select="$component1_w div 2"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : P1
            Desc : Axis 1 (reference axis to place the model)
            Contains Coordinates with x and y as attributes.
        -->
			<xsl:variable name="P1">
				<xsl:value-of select="($P0 - (($actualL + $actualW) div 2))"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : P2
            Desc : Axis 2 (reference axis to place the model)
            Contains Coordinates with x and y as attributes.
        -->
			<xsl:variable name="P2">
				<xsl:value-of select="($P0 + (($actualL + $actualW) div 2))"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name : statecount
            Desc : Counts the total number of models in the input that needs to be placed in the container
        -->
			<xsl:variable name="statecount">
				<xsl:value-of select="count(state)"/>
			</xsl:variable>
			
			<!--
            Type : Variable
            Name : leftcount
            Desc : Counts the total number of models to be placed on left axis
        -->
			<xsl:variable name="leftcount">
				<xsl:value-of select="round($statecount div 2)"/>
			</xsl:variable>
			<!--
            Type : Variable
            Name :rightcount
            Desc : Counts the total number of models to be placed on right axis
        -->
			<xsl:variable name="rightcount">
				<xsl:value-of select="($statecount - $leftcount)"/>
			</xsl:variable>
			
			
			<xsl:message>
				Total COunt :<xsl:value-of select="$statecount"></xsl:value-of>
				Left COunt :<xsl:value-of select="$leftcount"></xsl:value-of>
				Right COunt :<xsl:value-of select="$rightcount"></xsl:value-of>
			</xsl:message>
			<!--
            Type : Variable
            Name : workingH
            Desc : Working Height of the axis on which models are placed
        -->
			<xsl:variable name="workingH">
				<xsl:value-of select="($component1_h div (($leftcount) + 1)) "/>
			</xsl:variable> 
			<!-- 
                
                Logic in here :
                
                For each state , 
                    for first leftcount number of models, set the coordinates for center
                  
                    for next right count number of models, set the coordinates for center 
                    
                    (Use of recurssion is what i am thinking) 
                    
                    
                    Then i can build the box with reference to this center and finding the anchor point
            -->
			<!-- Y value for the models on left side-->
			<!--<xsl:variable name="model_centersl">
				<xsl:for-each select="1 to $leftcount">
					<xsl:message>
						Counter xxxxxxxxx: <xsl:value-of select="position()"></xsl:value-of>
					</xsl:message>
					<y>
						<xsl:attribute name="value">
							<xsl:value-of select="($workingH * position())"/>
						</xsl:attribute>
					</y>
				</xsl:for-each>
			</xsl:variable>
			<!-\- Y value for the models on right side-\->
			<xsl:variable name="model_centersr">
				<xsl:for-each select="1 to $rightcount">
					<y>
						<xsl:attribute name="value">
							<xsl:value-of select="($workingH * position())"/>
						</xsl:attribute>
					</y>
				</xsl:for-each>
			</xsl:variable>
-->
		<!--	<xsl:message> 3: <xsl:value-of select="$model_centersr/*"/>
			</xsl:message>

-->
			<!--  step 1   : get  states  -->
			<xsl:variable name="statesl" select="./state[position()&lt; ($leftcount+1)]"/>
			<xsl:variable name="statesr" select="./state[position()&gt; ($rightcount+1)]"/>
			<!-- steep 2 : loop  throuhg   states  -->
			<!--  assign x -->
			<!--  assign y  -->
			<xsl:message>
				<xsl:for-each select="$statesr"> 
					testr: <xsl:value-of select="./@id"/>
				</xsl:for-each>
				
				<xsl:for-each select="$statesl"> 
					testl: <xsl:value-of select="./@id"/>
				</xsl:for-each>
			</xsl:message>
			
			
			<!-- [Todo] testing -->
			<xsl:variable name="state_model_ordinates">
				<xsl:for-each select="$statesl">
					<rec>
						<xsl:attribute name="rank">
							<xsl:value-of select="position()"/>
						</xsl:attribute>
						<xsl:attribute name="side">
							<xsl:value-of select="1"/>
						</xsl:attribute>
						<xsl:attribute name="text_description">
							<xsl:value-of select="@description"/>
						</xsl:attribute>
						<xsl:attribute name="text_id">
							<xsl:value-of select="@descriptionid"/>
						</xsl:attribute>
						<xsl:attribute name="stateid_1">
							<xsl:value-of select="@id1"/>
						</xsl:attribute>
						<xsl:attribute name="stateid">
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<xsl:attribute name="strokecolor">
							<xsl:value-of select="@sc"/>
						</xsl:attribute>
						<xsl:attribute name="strokewidth">
							<xsl:value-of select="@sw"/>
						</xsl:attribute>
						<xsl:attribute name="px">
							<xsl:value-of select="$P1 - ($actualW div 2)"/>
						</xsl:attribute>
						<xsl:attribute name="py">
							<xsl:if test="position() = 1">	
								<xsl:value-of select="(($workingH * position()) - ($actualH div 2))"/>
							</xsl:if>
							<xsl:if test="position()&gt; 1">	
								<xsl:value-of select="((($workingH * position())+($actualLh * (position() - 1)) )  - ($actualH div 2))"/>
							</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="h">
							<xsl:value-of select="$actualH"/>
						</xsl:attribute>
						<xsl:attribute name="w">
							<xsl:value-of select="$actualW"/>
						</xsl:attribute>
					</rec>
				</xsl:for-each>
				<xsl:for-each select="$statesr">
					<rec>
						<xsl:attribute name="stateid_1">
							<xsl:value-of select="@id1"/>
						</xsl:attribute>
						<xsl:attribute name="rank">
							<xsl:value-of select="position()"/>
						</xsl:attribute>
						<xsl:attribute name="side">
							<xsl:value-of select="2"/>
						</xsl:attribute>
						<xsl:attribute name="text_description">
							<xsl:value-of select="@description"/>
						</xsl:attribute>
						<xsl:attribute name="text_id">
							<xsl:value-of select="@descriptionid"/>
						</xsl:attribute>
						<xsl:attribute name="stateid">
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<xsl:attribute name="strokecolor">
							<xsl:value-of select="@sc"/>
						</xsl:attribute>
						<xsl:attribute name="strokewidth">
							<xsl:value-of select="@sw"/>
						</xsl:attribute>
						<xsl:attribute name="px">
							<xsl:value-of select="$P2 - ($actualW div 2)"/>
						</xsl:attribute>
						<xsl:attribute name="py">
							<xsl:if test="position() = 1">	
								<xsl:value-of select="(($workingH * position()) - ($actualH div 2))"/>
							</xsl:if>
							<xsl:if test="position()&gt; 1">	
								<xsl:value-of select="((($workingH * position())+($actualLh * (position() - 1)) )  - ($actualH div 2))"/>
							</xsl:if>
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

			
			
			

			<!-- Consists of those states to be placed on right side-->
			<xsl:for-each select="$state_model_ordinates/*">
				<xsl:variable name="STATEID1" select="./@stateid_1"/>
				<xsl:variable name="STATEID2" select="State_"/>
				<xsl:variable name="stateId" select="concat('State_',$STATEID1)"/>

				<xsl:call-template name="model_state">
					<xsl:with-param name="text_description" select="./@text_description"/>
					<xsl:with-param name="text_id" select="concat('Text_',./@stateid)"/>
					<xsl:with-param name="px" select="./@px"/>
					<xsl:with-param name="py" select="./@py"/>
					<xsl:with-param name="width" select="./@w"/>
					<xsl:with-param name="height" select="./@h"/>
					<xsl:with-param name="stateid" select="concat('State_',./@stateid)"/>
					<xsl:with-param name="stroke-width" select="2"/>
					<xsl:with-param name="stroke-format" select="1"/>
					<xsl:with-param name="stroke-color" select="./@strokecolor"/>
					<xsl:with-param name="fill-opacity" select="0"/>
					<xsl:with-param name="fill" select="none"/>
					
				</xsl:call-template>
			</xsl:for-each>



			<xsl:message> State l : <xsl:value-of select="$statesl"/>
				<!--P0 :<xsl:value-of select="$P0"/> 
				P1: <xsl:value-of select="($P1)"/> 
				P2:<xsl:value-of select="($P2)"/> 
				Count : <xsl:value-of select="$statecount"/> 
				leftCount : <xsl:value-of select="$leftcount"/> 
				rightCount : <xsl:value-of select="$rightcount"/> 
				WorkingH :<xsl:value-of select="$workingH"/>
				model_centers: <xsl:value-of select="($model_centersl/x)"/>-->
			</xsl:message>

			<!--
				Drawing transition from models...
				Logic:
				* For each state count all the incoming and outgoing transitions.
				* find the axis on which the transitions meet(it will be the point x)
				* find the working height -> (actualH /(line_count + 1))
				* assign the ancor point for each line (x,(working height * position) )
				-->





			<xsl:variable name="context1" select="./state"/>
			<xsl:variable name="context2" select="./transition"/>

			<xsl:variable name="line_points"
				select="func:getRecord($context1,$context2,$state_model_ordinates,$actualH,$actualW)"/>



<!--
			<xsl:message> aaaaaaaaaaaaa:<xsl:value-of select="$line_points"/>
			</xsl:message>

			<xsl:for-each select="$line_points/*"> aaaaaaaaaaaaa:
				<xsl:copy-of select="."/>
			</xsl:for-each>
-->
			
			
		
		<xsl:call-template name="model_tranition">
			<xsl:with-param name="coordinates" select="$line_points"/>
		</xsl:call-template>
		
			
	<!--<!-\- Draw transition template call -\->		
			<xsl:for-each select="./transition">
				<xsl:variable name="t_id" select="@id"/>
					
				
				<!-\- get  start point 
				  xpath  :  search by  transaction ID  AND   type = start
				  $line_points/rec[(@transition_id=$t_id) and (@type=0) ]
				-\->
				
				<!-\- get  endpoint point
					
					xpath  :  search by  transaction ID  AND   type = start
				$line_points/rec[(@transition_id=$t_id) and (@type=1) ]
			   -\-> 
			
				<!-\-draw transition-\->
				<xsl:variable name="sx">
					<xsl:for-each select="$line_points/*"> 
						<xsl:if test="(@transition_id=$t_id) and(@type=0)">
							<xsl:value-of select="@x"/>
						</xsl:if>		
					</xsl:for-each>					
				</xsl:variable>
				
				<xsl:variable name="sy">
					<xsl:for-each select="$line_points/*"> 
						<xsl:if test="(@transition_id=$t_id) and(@type=0)">
							<xsl:value-of select="@y"/>
						</xsl:if>		
					</xsl:for-each>					
				</xsl:variable>
				
				
				<xsl:variable name="ex">
					<xsl:for-each select="$line_points/*"> 
						<xsl:if test="(@transition_id=$t_id) and(@type=1)">
							<xsl:value-of select="@x"/>
						</xsl:if>		
					</xsl:for-each>					
				</xsl:variable>
				
				<xsl:variable name="ey">
					<xsl:for-each select="$line_points/*"> 
						<xsl:if test="(@transition_id=$t_id) and(@type=1)">
							<xsl:value-of select="@y"/>
						</xsl:if>		
					</xsl:for-each>					
				</xsl:variable>
				

				<xsl:call-template name="temp_liner">
					<xsl:with-param name="sx" select="$sx"/>
					<xsl:with-param name="sy" select="$sy"/>
					<xsl:with-param name="ex" select="$ex"/>
					<xsl:with-param name="ey" select="$ey"/>
				</xsl:call-template>	
				
			</xsl:for-each>-->

			
<!-- [TODO later] -->
			<!--<xsl:for-each select="state">
				<!-\- [TODO] DEBUG -\->
				<!-\-<xsl:call-template name="liner">
					<xsl:with-param name="id2" select="@id"/>
					<xsl:with-param name="sx" select="100"/>
					<xsl:with-param name="ex" select="200"/>
					<xsl:with-param name="sy" select="100"/>
					<xsl:with-param name="ey" select="200"/>
					<xsl:with-param name="marker" select="marker"/>
					<xsl:with-param name="Width" select="100"/>
					<xsl:with-param name="Height" select="0"/>
					<xsl:with-param name="stroke-width" select="1"/>
					<xsl:with-param name="stroke-format" select="0"/>
					<xsl:with-param name="stroke-color" select="black"/>
					<xsl:with-param name="fill-opacity" select="0"/>
					<xsl:with-param name="fill" select="white"/>
				</xsl:call-template>-\->
				<xsl:variable name="state_id" select="@id"/>
				<xsl:variable name="linecount">
					<xsl:value-of
						select="count((./parent::fsm/transition[@Source=$state_id])|(./parent::fsm/transition[@Destination=$state_id]))"
					/>
				</xsl:variable>
				<xsl:variable name="model_working_H">
					<xsl:value-of select="($actualH div ($linecount + 1))"/>
				</xsl:variable>
				<xsl:variable name="model_line_ordinates">
					<xsl:for-each select="./parent::fsm/transition">
						<rec>
							<xsl:attribute name="transition_id">
								<xsl:value-of select="./@id"/>
							</xsl:attribute> <xsl:attribute name="marker_id">
								<xsl:value-of select="./@link"/>
							</xsl:attribute> <xsl:choose>
								<xsl:when test="(@Source=$state_id)">
									<xsl:attribute name="sx">
										<!-\- Include for each of state model to check the matching one -\->
										<xsl:for-each select="$state_model_ordinates/*">
											<xsl:if test="@stateid=$state_id">
												<xsl:value-of select="@px"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:attribute>
									<xsl:attribute name="sy">
										<xsl:for-each select="$state_model_ordinates/*">
											<xsl:if test="@stateid=$state_id">
												<xsl:value-of
												select="(@py)+($model_working_H * position())"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="ex">
										<xsl:for-each select="$state_model_ordinates/*">
											<xsl:if test="@stateid=$state_id">
												<xsl:value-of select="@px"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:attribute> <xsl:attribute name="ey">
										<xsl:for-each select="$state_model_ordinates/*">
											<xsl:if test="@stateid=$state_id">
												<xsl:value-of
												select="(@py)+($model_working_H * position())"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</rec>
					</xsl:for-each>
				</xsl:variable>
				
				<!-\-[TODO] Trying a new logic -\->
				
				
				<xsl:variable name="transition_ordinates">
					<xsl:for-each select="./parent::fsm/transition">
						<rec>
							<xsl:attribute name="id">
								<xsl:value-of select="@id"/>
							</xsl:attribute>
							
							
							<xsl:attribute name="sx">
								<xsl:for-each select="$model_line_ordinates/*">
									<xsl:if test="@transition_id=./parent/@id">
									<xsl:value-of select="@sx"/>
								</xsl:if>
								</xsl:for-each>
							</xsl:attribute>
							
						</rec>
						
					</xsl:for-each>
				</xsl:variable>
				
				
						6666666666666666666666666 end lines66666666666666 
						<xsl:for-each select="$transition_ordinates/*"> 
							position: <xsl:value-of select="position()"/> 
							Line vales : <xsl:copy-of select="."/>
						</xsl:for-each> 
						6666666666666666666666666 lines666666666666666666
				
				
				
				<!-\-<xsl:call-template name="model_tranition">
					<xsl:with-param name="coordinates" select="$model_line_ordinates"/>
				</xsl:call-template>-\->
				
				
				
			</xsl:for-each>
			
			-->


			<rect width="{$component1_w}" height="{$component1_h}" x="{$component1_px}"
				y="{$component1_py}" stroke-width="1" stroke="black" fill="none"/>
		</svg>

	</xsl:template>

	<!-- Template that takes state values with text-->
	<xsl:template name="model_state">
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

		<xsl:variable name="id_temp1">
			<xsl:value-of select="t_text"/>
		</xsl:variable>
		<xsl:variable name="id_temp2">
			<xsl:value-of select="t_text1"/>
		</xsl:variable>
		<xsl:call-template name="text">
			<xsl:with-param name="id1" select="$text_id"/>
			<xsl:with-param name="id2" select="$id_temp2"/>
			<xsl:with-param name="x" select="$px + 5"/>
			<xsl:with-param name="y" select="$py + ($height div 2)"/>
			<xsl:with-param name="decription" select="$text_description"/>
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="model_tranition">
		<xsl:param name="coordinates"/>

		<!--<xsl:for-each select="./parent::fsm/transition">
			<xsl:if test="@id=$coordinates/transition_id">
				<xsl:call-template name="liner">
					<xsl:with-param name="id2" select="@id"/>
					<xsl:with-param name="sx" select="$coordinates/sx"/>
					<xsl:with-param name="ex" select="$coordinates/ex"/>
					<xsl:with-param name="sy" select="$coordinates/sy"/>
					<xsl:with-param name="ey" select="$coordinates/ey"/>
					<xsl:with-param name="marker" select="@link"/>
					<xsl:with-param name="Width" select="($coordinates/ex - $coordinates/sx)"/>
					<xsl:with-param name="Height" select="($coordinates/ey - $coordinates/sy)"/>
					<xsl:with-param name="stroke-width" select="1"/>
					<xsl:with-param name="stroke-format" select="0"/>
					<xsl:with-param name="stroke-color" select="black"/>
					<xsl:with-param name="fill-opacity" select="0"/>
					<xsl:with-param name="fill" select="white"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>-->
		
		<!-- Draw transition template call -->		
		<xsl:for-each select="./transition">
			<xsl:variable name="t_id" select="@id"/>
			
			
			<!-- get  start point 
				  xpath  :  search by  transaction ID  AND   type = start
				  $line_points/rec[(@transition_id=$t_id) and (@type=0) ]
				-->
			
			<!-- get  endpoint point
					
					xpath  :  search by  transaction ID  AND   type = start
				$line_points/rec[(@transition_id=$t_id) and (@type=1) ]
			   --> 
			
			<!--draw transition-->
			<xsl:variable name="sx">
				<xsl:for-each select="$coordinates/*"> 
					<xsl:if test="(@transition_id=$t_id) and(@type=0)">
						<xsl:value-of select="@x"/>
					</xsl:if>		
				</xsl:for-each>					
			</xsl:variable>
			
			<xsl:variable name="sy">
				<xsl:for-each select="$coordinates/*"> 
					<xsl:if test="(@transition_id=$t_id) and(@type=0)">
						<xsl:value-of select="@y"/>
					</xsl:if>		
				</xsl:for-each>					
			</xsl:variable>
			
			
			<xsl:variable name="ex">
				<xsl:for-each select="$coordinates/*"> 
					<xsl:if test="(@transition_id=$t_id) and(@type=1)">
						<xsl:value-of select="@x"/>
					</xsl:if>		
				</xsl:for-each>					
			</xsl:variable>
			
			<xsl:variable name="ey">
				<xsl:for-each select="$coordinates/*"> 
					<xsl:if test="(@transition_id=$t_id) and(@type=1)">
						<xsl:value-of select="@y"/>
					</xsl:if>		
				</xsl:for-each>					
			</xsl:variable>
			
			
		
			
			<xsl:call-template name="liner">
				<xsl:with-param name="id" select="concat('Line_',$t_id)"/>
				<xsl:with-param name="sx" select="$sx"/>
				<xsl:with-param name="sy" select="$sy"/>
				<xsl:with-param name="ex" select="$ex"/>
				<xsl:with-param name="ey" select="$ey"/>
				<xsl:with-param name="marker" select="@link"/>
				<xsl:with-param name="Width" select="($ex - $sx)"/>
				<xsl:with-param name="Height" select="($ey - $sy)"/>
				<xsl:with-param name="stroke-width" select="1"/>
				<xsl:with-param name="stroke-format" select="0"/>
				<xsl:with-param name="stroke-color" select="@sc"/>
				<xsl:with-param name="fill-opacity" select="@transparency"/>
				<xsl:with-param name="fill" select="@fillcolor"/>
			</xsl:call-template>
			
			
		</xsl:for-each>

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
	</xsl:template>


<xsl:template name="temp_liner">
	
		<xsl:param name="sx"/>
		<xsl:param name="sy"/>
		<xsl:param name="ex"/>
		<xsl:param name="ey"/>
	
	<line x1="{$sx}" y1="{$sy}" x2="{$ex}" y2="{$ey}"/>
	
</xsl:template>



</xsl:stylesheet>