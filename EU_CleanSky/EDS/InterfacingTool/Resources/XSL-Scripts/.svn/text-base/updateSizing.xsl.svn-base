<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Generation of Dymola Script for systems sizing-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.1-->
<!--Date: 21/12/2011-->
<!--Modifier: Charles Mehaignerie - Altran Technologies-->
<!--Creation: -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

   <xsl:output method = "xml" encoding="ISO-8859-1"/>
   <xsl:strip-space elements = "*"/>
   <!--sizings XML file from APOM-->
   <xsl:param name ="singleSizing"/>
   <!--Sizing to consider-->
   <xsl:param name ="sizingNumber"/>
   <!--Name of sizing to add-->
   <xsl:param name ="sizingName"/>	  
   <!--Value of sizing to add-->
   <xsl:param name ="sizingValue"/>
   <!--EMM related parameters files-->
   <xsl:param name ="emmExperimentsParameters"/>	  	  

   <xsl:template match="/">
	<sizingsParameters>
		<xsl:text>&#xa;</xsl:text>
		<sizing>
			<xsl:text>&#xa;</xsl:text>
			<id>
			<xsl:text>&#xa;</xsl:text>
			<xsl:value-of select ="document($singleSizing)//sizing/id" />
			<xsl:text>&#xa;</xsl:text>
			</id>
			<xsl:text>&#xa;</xsl:text>
			<sizingParameters>
				<xsl:text>&#xa;</xsl:text>
				<xsl:copy-of select ="document($singleSizing)//sizing/sizingParameters/*" />
				<xsl:text>&#xa;</xsl:text>
				<parameter>
				<xsl:text>&#xa;	</xsl:text>
					<parameterName><xsl:value-of select = "document($emmExperimentsParameters)//parameter[source='sizingParameters' and modelicaName=$sizingName]/value"/></parameterName>
				<xsl:text>&#xa;	</xsl:text>
					<parameterValue><xsl:value-of select="$sizingValue" /></parameterValue>
					<xsl:text>&#xa;</xsl:text>
				</parameter>
				<xsl:text>&#xa;</xsl:text>
			</sizingParameters>
			<xsl:text>&#xa;</xsl:text>
		</sizing>
		<xsl:text>&#xa;</xsl:text>
      	</sizingsParameters>
  </xsl:template>  
  
</xsl:stylesheet>

