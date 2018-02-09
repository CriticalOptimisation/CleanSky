<?xml version="1.0" encoding="windows-1250"?>
<!--Cleansky EDS: Generation of Dymola Script for AC Optimization-->
<!--Copyright Dassault Aviation-->
<!--Version: 0.16-->
<!--Date: 22/06/2012-->
<!--Modifier: Charles Mehaignerie - Altran Technologies-->
<!--Modifications:  -change statusFile update-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

   <xsl:output method = "text" encoding="ISO-8859-1"/>
   <xsl:strip-space elements = "*"/>
   <!--Parametrization of the Modelica file-->
   <xsl:param name = "modelicaFile"/>
   <!--Parametrization of the Modelica model-->
   <xsl:param name = "modelicaModel"/>
   <!--Parametrization of the EMM Experiment Parameters XML file-->
   <xsl:param name ="emmExperimentsParameters"/>
   <!--Parametrization of the experiments XML file-->
   <xsl:param name ="experiments"/>
   <!--Parametrization of the sizing iteration XML file-->
   <xsl:param name ="sizingIteration"/>
   <!--Folder Containing the simulation results-->
   <xsl:param name ="workingDirectory"/>
   <!--Folder Containing the simulation results-->
   <xsl:param name ="statusFile"/>
     
    
   <xsl:template match="/">
      <!--Main template-->
      <xsl:text>//Modelica script automatically generated</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Copyright Dassault Aviation</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//August 2011</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Initialize the status file</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>statusFile="</xsl:text>
      <xsl:value-of select = "$statusFile"/>
      <xsl:text>";</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Look for the model and open the Modelica file if not loaded</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>modelLoaded = checkModel("</xsl:text>
      <xsl:value-of select = "$modelicaModel"/>
      <xsl:text>");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>if not(modelLoaded) then</xsl:text>
      <xsl:text>&#xa;  </xsl:text>
      <xsl:text>openModel("</xsl:text>
      <!--Look for the Modelica model-->
      <xsl:value-of select = "$modelicaFile"/>
      <xsl:text>");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>end if;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--Change the working Directory-->
      <xsl:text>//Change the working Directory</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>cd("</xsl:text>
      <xsl:value-of select = "$workingDirectory"/>
      <xsl:text>");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--List mission points-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the IDs of each mission point</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>MissionPointsTable =</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>["</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//missionPoint" mode = "missionPointId"/>
      <xsl:text>&#xa;</xsl:text>
      <!--List experiments-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the IDs of each experiment</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>ExperimentsTable =</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates select = "document($experiments)//experiment" mode = "experimentsID"/>
      <xsl:text>&#xa;</xsl:text>
      <!--<h1>sizing parameters</h1>-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Sizing Parameters</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>modifier =</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>"</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//sizingParameters/parameter" mode = "sizingParameters"/>
      <xsl:text>";</xsl:text> 
      <xsl:text>&#xa;</xsl:text>
      <!--Look for initial parameters names for each experiment-->
      <!--<h1>initial Names</h1>-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Vector of the initial parameters names for each experiment</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:apply-templates select = "document($experiments)//experiment" mode = "initialNames"/>
      <!--Look for initial parameters values for each experiment-->
      <!--<h1>initial Value</h1>-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Vector of the initial parameters values for each experiment</xsl:text>
      <xsl:text>&#xa;</xsl:text> 
      <xsl:apply-templates select = "document($experiments)//experiment" mode = "initialValues"/>
      <!--Look for initial results names for each experiment-->
      <!--<h1>final Names</h1>-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the outputs which has a mission wide</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>SizingOutputs = [realString(zeros(0,2))</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//output[missionWide = 'true']" mode = "finalNames"/>
      <xsl:text>];</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the outputs which has no mission wide</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>MissionPointsOutputs = [realString(zeros(0,2))</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//output[missionWide = 'false']" mode = "finalNames"/>
      <xsl:text>];</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the concatenation of the two tables of outputs</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>FinalNames = [realString(zeros(0));SizingOutputs[:,1];MissionPointsOutputs[:,1]];</xsl:text>
      <!--Look for the duration of each experiment-->
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>//Table of the duration of each experiment</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>StopTime =</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates select = "document($experiments)//experiment/duration" mode = "stopTime">
      </xsl:apply-templates>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--Initialize the table containing the results-->
      <xsl:text>//Initialization of the results table with zeros</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>result = zeros(size(ExperimentsTable,1),size(FinalNames,1));</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--Tanslate the model with standard initial values-->
      <xsl:text>//Tanslate the model with standard initial values, the input file is saved as dsinitial.txt</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>translateModel("</xsl:text>
      <xsl:value-of select = "$modelicaModel"/>
      <xsl:text>(" + modifier + ")");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>Modelica.Utilities.Files.copy("dsin.txt","dsinitial.txt",true);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>Modelica.Utilities.Files.createDirectory("resultFiles")</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--Simulate each experiment-->
      <xsl:apply-templates select = "document($experiments)//experiment" mode = "simulate"/>
   </xsl:template>  
  
  
   <xsl:template match="missionPoint" mode = "missionPointId">
      <!--Look for the ids of the different missionPoints in sizingIteration//missionPoint-->
      <xsl:value-of select="id"/>
      <!--Test to know if we have to put a "];" if it is the last one or only a ";" if there are other ids in the table "MissionPointsTable"-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>";</xsl:text>
            <xsl:text>&#xa; </xsl:text>
            <xsl:text>"</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>"];</xsl:text>
         </xsl:otherwise>  
      </xsl:choose>  
   </xsl:template>
   
        
   <xsl:template match="experiment" mode = "experimentsID">
      <!--Look for the ids of the different experiments in experiments//experiment-->
      <xsl:text>"</xsl:text>
      <!--Look for the mission points ids-->
      <xsl:value-of select="missionPointId"/>
      <xsl:text>", "</xsl:text>
      <!--Look for the state points ids-->
      <xsl:value-of select="stateId"/>
      <xsl:text>"</xsl:text>
      <!--Test to know if we have to put a "];" if it is the last one or only a ";" if there are other ids in the table "ExperimentsTable"-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>; </xsl:text>
            <xsl:text>&#xa; </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>];</xsl:text>
         </xsl:otherwise>  
      </xsl:choose>  
   </xsl:template>
   
    
   <xsl:template match="parameter" mode = "sizingParameters">
      <!--Use of the variable paramName that contains the name of the sizing parameter in emmExperimentsParameters/parameter-->
      <xsl:variable name = "paramName"><xsl:value-of select="parameterName"/></xsl:variable>
      <!--Look for the modelica path + name of the parameter whose value is "paramName" in emmExperimentsParameters//parameter-->
      <xsl:value-of select = "document($emmExperimentsParameters)//parameter[source='sizingParameters' and value=$paramName]/modelicaName"/>
      <xsl:text>=</xsl:text>
      <!--Look for the value of the parameter in sizingIteration//sizingParameters/parameter-->
      <xsl:value-of select = "parameterValue"/>
      <!--Test to know if we have to put a ";" if it is the last one or only a "," if there are other sizing parameters in the modifier-->    
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>,</xsl:text>
            <xsl:text>&#xa; </xsl:text>
         </xsl:when>  
      </xsl:choose>  
   </xsl:template>

   
   <xsl:template match="experiment" mode = "initialNames">
      <!--Use of the parameter missionId that contains the mission point Id for this experiment-->
      <xsl:variable name = "missionId"><xsl:value-of select="missionPointId"/></xsl:variable>
      <!--Use of the parameter stateId that contains the state point Id for this experiment-->
      <xsl:variable name = "stateId"><xsl:value-of select="stateId"/></xsl:variable>
      <!--Look for the parameters of the missionPoint whose id is "missionId" in sizingIteration/missionPoints-->
      <xsl:text>InitialNames</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>= {</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//missionPoints/missionPoint[id=$missionId]/parameter" mode="missionParameters"/>
      <!--Look for the parameter of the state whose id is "stateId" in stateParameters-->
      <xsl:apply-templates select = "document($emmExperimentsParameters)//state[id=$stateId]/parameter" mode = "stateParameters"/>
      <xsl:text>}; </xsl:text>
      <xsl:text>&#xa;</xsl:text>
   </xsl:template>
   
   <!--This template adapts the Dymola simulation command to the given experiment-->
   <xsl:template match="experiment" mode = "simulate">
      <xsl:text>resultFile="result_"+ExperimentsTable[</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>,1]+"_"+ExperimentsTable[</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text> ,2];</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--import the standard initial conditions for the loop-->
      <xsl:text>importInitial("dsinitial.txt");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <!--put the results in the correct line-->
      <xsl:text>(,result[</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>,:]) = </xsl:text>
      <!--simulte the given model-->
      <xsl:text>simulateExtendedModel("</xsl:text>
      <xsl:value-of select = "$modelicaModel"/>
      <!--set the models sizing as a modifier of the model-->
      <xsl:text>(" + modifier + ")", </xsl:text>
      <!--set the correct experiment vector-->
      <xsl:text>initialNames = InitialNames</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>, initialValues = InitialValues</xsl:text>
      <xsl:value-of select="position()"/>
      <!--precise the results wanted as output-->
      <xsl:text>, finalNames = FinalNames[:,1], </xsl:text>
      <!--set the experiment duration-->
      <xsl:text>startTime = 0, stopTime = StopTime[</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>,1], </xsl:text>
      <!--set the experiment result file-->
      <xsl:text>resultFile=resultFile);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>DataFiles.writeCSVmatrix(statusFile,{"current","total"},[</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="last()"/>
      <xsl:text>],"/");</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>Modelica.Utilities.Files.move(resultFile+".mat","resultFiles/"+resultFile+".mat",true);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
   </xsl:template>
   
   <!--This template looks for the modelica path and name of a given state or mission point parameter-->
   <xsl:template match="parameter" mode = "missionParameters">
      <!--Use of the variable paramName that contains the parameterName in sizingIteration/missionPoints/missionPoint/parameter-->
      <xsl:variable name = "paramName"><xsl:value-of select="parameterName"/></xsl:variable>
      <!--Look for the modelicaName of the parameter whose value is "paramName" in emmExperimentsParameters//parameter-->
      <xsl:text>"</xsl:text>
      <xsl:value-of select = "document($emmExperimentsParameters)//parameter[source='missionPoints' and value=$paramName]/modelicaName"/>
      <!--Test to know if we have to put a """ if it is the last one or only a ""," if there are other mission parameters-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>", </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>"</xsl:text>
         </xsl:otherwise>  
      </xsl:choose>
   </xsl:template>
   
   
   <!--This template looks for the modelica path and name of a given state or mission point parameter-->
   <xsl:template match="parameter" mode = "stateParameters">
      <!--Use of the variable paramName that contains the parameterName in emmExperimentsParameters/stateParameters/state/parameter-->
      <xsl:variable name = "paramName"><xsl:value-of select="parameterName"/></xsl:variable>
      <!--Test to know if we have to put a "; ["" if it is the first output in SizingOutputs or in MissionPointsOutputs-->
      <xsl:if test= "position() = 1">
         <xsl:text>, </xsl:text>
      </xsl:if>
      <!--Look for the modelicaName of the parameter whose value is "paramName" in emmExperimentsParameters//parameter-->
      <xsl:text>"</xsl:text>
      <xsl:value-of select = "document($emmExperimentsParameters)//parameter[source='stateParameters' and value=$paramName]/modelicaName"/>
      <!--Test to know if we have to put a """ if it is the last one or only a ""," if there are other state parameters-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>", </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>"</xsl:text>
         </xsl:otherwise>  
      </xsl:choose>
   </xsl:template>
   
   
   <xsl:template match="experiment" mode = "initialValues">
      <!--Use of the parameter missionId that contains the mission point Id for this experiment-->
      <xsl:variable name = "missionId"><xsl:value-of select="missionPointId"/></xsl:variable>
      <!--Use of the parameter stateId that contains the state point Id for this experiment-->
      <xsl:variable name = "stateId"><xsl:value-of select="stateId"/></xsl:variable>
      <!--Look for the parameterValue of the parameter of the missionPoint whose id is "missionId" in sizingIteration-->
      <xsl:text>InitialValues</xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>= {</xsl:text>
      <xsl:apply-templates select = "document($sizingIteration)//missionPoints/missionPoint[id=$missionId]/parameter/parameterValue" mode="initialMissionValues"/>
      <!--Look for the parameterValue of the parameter of the state whose id is "stateId" in stateParameters-->
      <xsl:apply-templates select = "document($emmExperimentsParameters)//state[id=$stateId]/parameter/parameterValue" mode="initialStateValues"/>
      <!--Test to know if we have top put a "];" (for the last one) or only a ";"-->
      <xsl:text>}; </xsl:text>
      <xsl:text>&#xa;</xsl:text>
   </xsl:template>
   
   <xsl:template match="parameterValue" mode="initialMissionValues">
      <!--Returns the value of the parameter for this sizing-->
      <xsl:value-of select="."/>
      <!--Test to know if we have to put nothing if it is the last initial value or a "," if there are other initial values-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>, </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text></xsl:text>
         </xsl:otherwise>  
      </xsl:choose>
   </xsl:template>
   
   
   <xsl:template match="parameterValue" mode="initialStateValues">
      <!--Returns the value of the parameter for this sizing-->
      <xsl:if test= "position() = 1">
         <xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:value-of select="."/>
      <!--Test to know if we have to put nothing if it is the last initial value or a "," if there are other initial values-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>, </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text></xsl:text>
         </xsl:otherwise>  
      </xsl:choose>
   </xsl:template>
   
   
   <xsl:template match="output" mode = "finalNames">
      <!--Use of the variable paramName that contains the parameterName in sizingIteration/outputs/output-->
      <xsl:variable name = "paramName"><xsl:value-of select="parameterName"/></xsl:variable>
      <!--Test to know if we have to put a "; ["" if it is the first output in SizingOutputs or in MissionPointsOutputs-->
      <xsl:choose>
         <xsl:when test= "position() = 1">
            <xsl:text>; ["</xsl:text>
         </xsl:when>
      </xsl:choose> 
      <!--Look for the modelicaName of the parameter whose source is "output" and value is "paramName" in emmExperimentsParameters/modelicaParameters/parameter-->
      <xsl:value-of select = "document($emmExperimentsParameters)//parameter[source='outputs' and value = $paramName]/modelicaName"/>
      <xsl:text>", "</xsl:text>
      <!--Look for the type of the postProcess for each output in sizingIteration/outputs/output-->
      <xsl:value-of select = "postProcessType"/>
      <!--Test to know if we have to put a ""]" if it is the last one or only a "";" if there are other outputs in SizingOutputs or in MissionPointsOutputs-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>"; </xsl:text>
            <xsl:text>&#xa; </xsl:text>
            <xsl:text>"</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>"]</xsl:text>
         </xsl:otherwise>  
      </xsl:choose> 
   </xsl:template>
   
   
   <xsl:template match="duration" mode = "stopTime">
      <!--Look for the duration of each experiment in experiments/experiment-->
      <xsl:value-of select="."/>
      <!--Test to know if we have to put a "];" if it is the last one or only a ";" if there are other durations in StopTime-->
      <xsl:choose>
         <xsl:when test= "position() != last()">
            <xsl:text>; </xsl:text>
            <xsl:text>&#xa; </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>];</xsl:text>
         </xsl:otherwise>  
      </xsl:choose>  
   </xsl:template>


</xsl:stylesheet>

