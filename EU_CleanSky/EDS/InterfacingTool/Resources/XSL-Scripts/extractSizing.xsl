<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Copies a sizing in a single file-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.1-->
<!--Date: 21/06/2012-->
<!--Modifier: -->
<!--Creation: Charles Mehaignerie - Altran Technologies-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

   <xsl:output method = "xml" encoding="ISO-8859-1"/>
   <xsl:strip-space elements = "*"/>
   <!--sizings XML file from APOM-->
   <xsl:param name ="sizingIterations"/>
   <!--Sizing to consider-->
   <xsl:param name ="sizingNumber"/>
   	  	  

   <xsl:template match="/">
	<sizingsParameters>
		<xsl:text>&#xa;	</xsl:text>
		<sizing>
		<xsl:text>&#xa;		</xsl:text>
		<xsl:copy>
			 <xsl:copy-of select ="document($sizingIterations)//sizing[position()=$sizingNumber]/*"/>
       		</xsl:copy>
		<xsl:text>&#xa;	</xsl:text>
		</sizing>
		<xsl:text>&#xa;</xsl:text>
      	</sizingsParameters>
  </xsl:template>  
  
</xsl:stylesheet>

