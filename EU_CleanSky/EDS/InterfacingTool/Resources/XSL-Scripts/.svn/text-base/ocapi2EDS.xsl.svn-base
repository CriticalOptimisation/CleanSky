<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="engineFile" />		
    	<xsl:template match="/">
	<sizingIteration>
		<xsl:text>&#xa;</xsl:text>
        	<xsl:variable name="vLines"
         	select="tokenize(unparsed-text($engineFile),'(&#xD;)?&#xA;')"/>
        	<xsl:variable name="vHeaders"
         	select="tokenize($vLines[1],'&#9;')"/>
        	<missionPoints>
            	<xsl:for-each select="$vLines[position()!=1]">
			<xsl:text>&#xa;</xsl:text>
                	<missionPoint>
        	            	<xsl:variable name="vColumns" select="tokenize(.,'&#9;')"/>
	                    	<xsl:for-each select="$vColumns">
                        		<xsl:variable name="vPosition" select="position()"/>
                	        	<xsl:variable name="vHeader"
        	                	select="$vHeaders[$vPosition]"/>
	                	        <xsl:choose>
        	                		<xsl:when test="$vPosition &lt;= 3">
	                        	        	<parameter>
								<parameterName>
									<xsl:value-of select="$vHeader"/>
								</parameterName>
								<parameterValue>
									<xsl:value-of select="."/>
								</parameterValue>
								<variability>No</variability>
							</parameter>
				    		</xsl:when>
        	                	</xsl:choose>
	                    	</xsl:for-each>
				<id><xsl:value-of select="position()"/></id>
				<duration>1</duration>
                	</missionPoint>
            	</xsl:for-each>
		<xsl:text>&#xa;</xsl:text>
        	</missionPoints>
		<xsl:text>&#xa;</xsl:text>		
		<sizingParameters>	
		<xsl:text>&#xa;</xsl:text>
		</sizingParameters>
		<xsl:text>&#xa;</xsl:text>
		<outputs>
			<output>
				<parameterName>regime</parameterName>
				<missionWide>false</missionWide>
				<postProcessType></postProcessType>
			</output>
			<output>
				<parameterName>mach</parameterName>
				<missionWide>false</missionWide>
				<postProcessType></postProcessType>
			</output>
			<output>
				<parameterName>altitude</parameterName>
				<missionWide>false</missionWide>
				<postProcessType></postProcessType>
			</output>
			<output>
				<parameterName>FN</parameterName>
				<missionWide>false</missionWide>
				<postProcessType></postProcessType>
			</output>
			<output>
				<parameterName>CS</parameterName>
				<missionWide>false</missionWide>
				<postProcessType></postProcessType>
			</output>
		</outputs>
<xsl:text>&#xa;</xsl:text>
	</sizingIteration>
<xsl:text>&#xa;</xsl:text>
    	</xsl:template>
</xsl:stylesheet>
