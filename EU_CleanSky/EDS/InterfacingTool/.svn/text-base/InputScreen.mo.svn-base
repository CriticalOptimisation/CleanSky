within EU_CleanSky.EDS.InterfacingTool;
function InputScreen

//VS Architecture
input String vsArchitectureFile= "VSArchitecture.xml"
    "XML file containing the VS architecture initial sizing" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)", caption="Open architecture file")));
input String equipmentList= "equipments.xml"
    "XML file containing the details on equipments used in the architecture" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)", caption="Open equipment database")));
//EMM
input String modelicaFile = "EMM.mo" annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="Modelica files (*.mo;*.moe)")));
input String modelicaModel = "EMM.emm" annotation(Dialog(group="EMM",__Dymola_translatedModel));
input String emmExperimentsParameters= "emmExperimentsParameters.xml" annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//Process selection
input String processSelection = "emmLightGen"
    "Select the process to be executed"                                           annotation(choices(
    choice="emmLightGen" "Generate EMM Light",
    choice="getEcolonomicParams" "Get ecolonomic parameters from EMM",
    choice="resizeSystems" "Resize systems for a given Architecture"),
    Dialog(group="Process selection"));

//APOM
input String spotPoints = "spotPoints.xml"
    "Mission points covering the engine model spot points"                                        annotation(Dialog(tab="APOM",
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String airframeSizings = "airframeSizings.xml"
    "map of different possible airframe sizings"                                                  annotation(Dialog(tab="APOM",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input Boolean showStatus = true "true if a monitoring screen must be shown"           annotation(Dialog(tab="APOM"));

//EAT
input String evaluationMissions = "evaluationMissions.xml"
    "Mission points used to perform the ecolonomic evaluation and aircraft optimization"
                                                                                                        annotation(Dialog(tab="EAT",
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input Boolean postProcessResults = false
    "true if a post process script shall be used"                                        annotation(Dialog(tab="EAT"));
input String postProcessFile = "postProcess.mos"
    "Dymola post process script used to extract relevant information from evaluation missions"
                                                                                                        annotation(Dialog(tab="EAT",
                         __Dymola_loadSelector(filter="All files (*.mos)")));

//Sizing tab
input String sizingPoints = "sizingPoints.xml"
    "Mission Points used for systems' sizing"                                            annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input String sizingExperiments = "sizingExperiments.xml"
    "Manually defined experiments used for resizing"                                                      annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input Boolean genVSArchitecture = false
    "true if the the sizing must be merged with the input Architecture"                                                      annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//technical settings tab
input String XSLTProcessor = "C:/Program Files/saxon/Transform.exe" annotation(Dialog(tab = "settings", group="XSLT Processor",
                         __Dymola_loadSelector(filter="Executable files (*.exe; *.bat)")));
input String dymolaExe = "Dymola.exe" annotation(Dialog(tab = "settings", group="Dymola executable file",
                         __Dymola_loadSelector(filter="Executable files (*.exe; *.bat)")));

input String optimizationFolder = "C:/Temp/"
    "Folder where simulation data is generated" annotation(Dialog(tab = "settings", group="Workspace",
                         __Dymola_loadSelector(filter="All files (*.*)")));

output Boolean success;

algorithm
  if processSelection == "emmLightGen" then
    success := InterfacingTool.TopLevelFunctions.emmLightGen(
      vsArchitectureFile=vsArchitectureFile,
      equipmentList=equipmentList,
      modelicaFile=modelicaFile,
      modelicaModel=modelicaModel,
      emmExperimentsParameters=emmExperimentsParameters,
      spotPoints=spotPoints,
      multipleSizings=multipleSizings,
      airframeSizings=airframeSizings,
      sizingPoints=sizingPoints,
      sizingExperiments=sizingExperiments,
      XSLTProcessor=XSLTProcessor,
      dymolaExe=dymolaExe,
      optimizationFolder=optimizationFolder);
  elseif processSelection == "getEcolonomicParams" then
    success := InterfacingTool.TopLevelFunctions.getEATParams();
  elseif processSelection == "resizeSystems" then
    success := InterfacingTool.TopLevelFunctions.resizeSystems(
      modelicaFile=modelicaFile,
      modelicaModel=modelicaModel,
      emmExperimentsParameters=emmExperimentsParameters,
      sizingExperiments=sizingExperiments,
      sizingPoints=sizingPoints,
      optimizationFolder=optimizationFolder,
      XSLTProcessor=XSLTProcessor);
  else
    success :=false;
  end if;

end InputScreen;
