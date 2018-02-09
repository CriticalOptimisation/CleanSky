<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Generation of Dymola Script for AC Optimization-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.1-->
<!--Date: 21/12/2011-->
<!--Modifier: Charles Mehaignerie - Altran Technologies-->
<!--Modification: Split the generation of experiments from the generation of scripts.
    scriptGenAutoExp.xsl becomes scriptGen.xsl and experimentsGen.xsl-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

   <xsl:output method = "xml" encoding="ISO-8859-1"/>
   <xsl:strip-space elements = "*"/>
   <!--Parametrization of the EMM Experiment Parameters XML file-->
   <xsl:param name ="emmExperimentsParameters"/>
   <!--Parametrization of the experiments XML file-->
   <xsl:param name ="experiments"/>
   <!--Parametrization of the sizing iteration XML file-->
   <xsl:param name ="sizingIteration"/>
	  
  <xsl:template match="/">
	  <experiments>
		  <xsl:text>&#xa;</xsl:text>
		 <xsl:copy>
			 <xsl:copy-of select ="document($experiments)/*/*"/>
         </xsl:copy>
		 <xsl:apply-templates select = "document($sizingIteration)//missionPoint" mode = "experimentsDefinition"/>
	  <xsl:text>&#xa;</xsl:text>
      </experiments>
  </xsl:template>  
  
  <!--For each mission point, add required states to experiment-->
  <xsl:template match="missionPoint" mode = "experimentsDefinition">
      <!--Check the parametered states to see if they need to be simulated for the given mission point-->
      <xsl:apply-templates select = "document($emmExperimentsParameters)//experimentsDefinition/experiment" mode = "experimentsDefinition">
        <xsl:with-param name="missionPointId" select="id"/>
      </xsl:apply-templates>
   </xsl:template>
   
   <xsl:template match="experiment" mode = "experimentsDefinition">
      <xsl:param name="missionPointId"/>
      <xsl:variable name="statePointId">
        <xsl:value-of select = "stateId"/>
      </xsl:variable>
      <!--The variable isEqual is null if all the conditions for the state simulation are fulfilled-->
      <xsl:variable name="exists">
        <xsl:if test = "boolean(document($experiments)//experiment[missionPointId=$missionPointId and stateId=$statePointId])">
          <xsl:text>1</xsl:text>
        </xsl:if>  
      </xsl:variable>
      <!--The variable isEqual is null if all the conditions for the state simulation 
      are fulfilled and if the state is not already simulated for this mission point-->
      <xsl:variable name="isEqual">
        <xsl:choose>
          <xsl:when test = "$exists= ''">
              <xsl:apply-templates select = "parameterSet" mode = "experimentsDefinition">
				  <xsl:with-param name="missionPointId" select="$missionPointId"/>
			  </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>1</xsl:text>
          </xsl:otherwise>  
      </xsl:choose>
      </xsl:variable>
      <!--if isEqual is null, add the corresponding experiment definition-->
      <xsl:if test = "$isEqual = ''">
		<xsl:text>&#xa;</xsl:text>
        <experiment>
        <xsl:text>&#xa;</xsl:text>
              <missionPointId><xsl:value-of select = "$missionPointId"/></missionPointId>
              <xsl:text>&#xa;</xsl:text>
              <stateId><xsl:value-of select = "$statePointId"/></stateId>
              <xsl:text>&#xa;</xsl:text>
              <duration>
                <xsl:choose>
                    <xsl:when test = "number(document($sizingIteration)//missionPoints/missionPoint[id=$missionPointId]/duration) &lt; number(document($emmExperimentsParameters)//state[id=$statePointId]/duration)">
                      <xsl:value-of select = "document($emmExperimentsParameters)//state[id=$statePointId]/duration"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select = "document($sizingIteration)//missionPoints/missionPoint[id=$missionPointId]/duration"/>
                    </xsl:otherwise>  
                </xsl:choose>
              </duration>
              <xsl:text>&#xa;</xsl:text>
              <userDefined>false</userDefined>
              <xsl:text>&#xa;</xsl:text>
          </experiment>
      </xsl:if>
   </xsl:template>
   
   <xsl:template match = "parameterSet" mode = "experimentsDefinition">
	  <xsl:param name="parameterName" select="parameterName"/>
      <xsl:param name="missionPointId"/>
      <!--if a parameter value in the missionPoint definition is not equal to the corresponding parameter in the experiment definition, "1" is written-->
      <xsl:choose>
         <!--test if the criteria is a spread or a fixed value-->
         <xsl:when test= 'substring(value,1,1) = "["'>
            <xsl:variable name = "spread" select = "translate(value,'[] ','')"/>
            <!--test if the parameter is lower than the lowest possible value-->
            <xsl:if test = "number(document($sizingIteration)//missionPoints/missionPoint[id=$missionPointId]/parameter[parameterName=$parameterName]/parameterValue) &lt; number(substring-before($spread,';'))">
              <xsl:text>1</xsl:text>
            </xsl:if>
            <!--test if the parameter is greater than the greatest possible value-->
            <xsl:if test = "number(document($sizingIteration)//missionPoints/missionPoint[id=$missionPointId]/parameter[parameterName=$parameterName]/parameterValue) &gt; number(substring-after($spread,';'))">
              <xsl:text>1</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <!--test if the parameter is different from the value-->
            <xsl:if test = "document($sizingIteration)//missionPoints/missionPoint[id=$missionPointId]/parameter[parameterName=$parameterName]/parameterValue != value">
              <xsl:text>1</xsl:text>
            </xsl:if>
         </xsl:otherwise>  
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>

