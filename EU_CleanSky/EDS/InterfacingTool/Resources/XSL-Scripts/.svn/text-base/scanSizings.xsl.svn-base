<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Resturns the number of sizings in a multiple sizings file-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.1-->
<!--Date: 21/06/2012-->
<!--Modifier: Charles Mehaignerie - Altran Technologies-->
<!--Creation: -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="ISO-8859-1" /> 
<xsl:strip-space elements = "*"/>
  	  

<xsl:template match="/">
	<xsl:apply-templates select ="//sizing">
	</xsl:apply-templates>		
</xsl:template>  

<xsl:template match='sizing'>
	<xsl:if test="position()=last()">
		<xsl:value-of select="position()" />
	</xsl:if>
</xsl:template>
	
</xsl:stylesheet>

