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
   <!--mission points XML file-->
   <xsl:param name ="missionPoints"/>
   <!--sizings XML file from APOM-->
   <xsl:param name ="sizingIterations"/>
   <!--Sizing to consider-->
   <xsl:param name ="sizingNumber"/>	  

   <xsl:template match="/">
	<sizingIteration>
	<xsl:text>&#xa;	</xsl:text>
	<missionPoints>
	<xsl:copy>
		 <xsl:copy-of select ="document($missionPoints)//missionPoints/*"/>
       	</xsl:copy>
	</missionPoints>
	<xsl:text>&#xa;	</xsl:text>
	<outputs>
	<xsl:copy>
		 <xsl:copy-of select ="document($missionPoints)//outputs/*"/>
       	</xsl:copy>
	</outputs>
	<xsl:text>&#xa;	</xsl:text>
	
	<sizingParameters>
	<xsl:copy>
		 <xsl:copy-of select ="document($sizingIterations)//sizing[position() = $sizingNumber]/sizingParameters/*"/>
       	</xsl:copy>
	<xsl:text>&#xa;</xsl:text>
	</sizingParameters>


      	</sizingIteration>
  </xsl:template>  
  
</xsl:stylesheet>

