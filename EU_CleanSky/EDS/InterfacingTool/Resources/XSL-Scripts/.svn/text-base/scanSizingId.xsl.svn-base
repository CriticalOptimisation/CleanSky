<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Resturns the id of a sizing given its position in the file-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.1-->
<!--Date: 21/06/2012-->
<!--Modifier: Charles Mehaignerie - Altran Technologies-->
<!--Creation: -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="ISO-8859-1" /> 
<xsl:strip-space elements = "*"/>
<!-- Sizing to consider--> 
<xsl:param name="sizingNumber" />   	  

<xsl:template match="/">
	<xsl:apply-templates select ="//sizing[position()=$sizingNumber]">
	</xsl:apply-templates>		
</xsl:template>  

<xsl:template match='sizing'>
	<xsl:value-of select="id" />
</xsl:template>
	
</xsl:stylesheet>

