within EU_CleanSky.EDS.InterfacingTool.TopLevelFunctions;
function emmLightGen "Function called to generate an EMM light for the APOM"

//VS Architecture
input String vsArchitectureFile= "VSArchitecture.xml"
    "XML file containing the VS architecture initial sizing" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input String equipmentList= "equipments.xml"
    "XML file containing the details on equipments used in the architecture" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//EMM
input String modelicaFile = "C:/Temp/eu.mo"
    "Modelica library containing the EMM model"                                         annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="Modelica files (*.mo;*.moe)")));
input String modelicaModel = "eu.cleansky.EDS.EMM.TestRig.BenchModels.VehicleInterfaceDesign.testBench"
    "Path to the EMM model in library"                                                                                                     annotation(Dialog(group="EMM",__Dymola_translatedModel));
input String emmExperimentsParameters= "emmExperimentsParameters.xml"
    "EMM related parameters file linking variables with the EAT and APOM"                                                                   annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//APOM
input String spotPoints = "spotPoints.xml"
    "Mission points covering the engine model spot points"                                        annotation(Dialog(tab="APOM",
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String airframeSizings = "airframeSizings.xml"
    "map of different possible airframe sizings"                                                  annotation(Dialog(tab="APOM",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input Boolean showStatus = true "true if a monitoring screen must be shown"           annotation(Dialog(tab="APOM"));

//Sizing tab
input String sizingPoints = "sizingPoints.xml"
    "Mission Points used for systems' sizing"                                            annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input String sizingExperiments = "sizingExperiments.xml"
    "Manually defined experiments used for resizing"                                                      annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//technical settings tab
input String XSLTProcessor = "L:/WRK/tools/saxon/Transform.exe" annotation(Dialog(tab = "settings", group="XSLT Processor",
                         __Dymola_loadSelector(filter="Executable files (*.exe; *.bat)")));
input String dymolaExe = "Dymola.exe" annotation(Dialog(tab = "settings", group="Dymola executable file",
                         __Dymola_loadSelector(filter="Executable files (*.exe; *.bat)")));
input String optimizationFolder = "C:/Temp/Test Bench 1808/"
    "Folder where simulation data is generated" annotation(Dialog(tab = "settings", group="Workspace",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String scanSizingsXSLT = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/scanSizings.xsl" annotation(Dialog(tab="settings",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String scanSizingIdXSLT = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/scanSizingId.xsl" annotation(Dialog(tab="settings",
                         __Dymola_loadSelector(filter="All files (*.*)")));

input String currentSizingFile = "currentSizing.txt"
    "File telling the current sizing number" annotation(Dialog(tab="settings"));
input String statusFile = "status.txt"
    "File ontaining the status of the current systems' resizing" annotation(Dialog(tab="settings"));

output Boolean success;

protected
String optimizationFolderTemp;
Integer sizingNumber;
String sizingIndex;

algorithm
  (optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
  cd(optimizationFolderTemp);
  //get the number of sizings to process
  success :=  system("\"" + XSLTProcessor + "\" \"" + airframeSizings + "\" \"" + scanSizingsXSLT + "\" > sizingNumber.txt");
  sizingNumber :=Modelica.Utilities.Strings.scanInteger(
    Modelica.Utilities.Streams.readLine("sizingNumber.txt", 1));

if showStatus then
  //Initialize status files
  system("echo Init > "+ currentSizingFile);
  system("echo Init > "+ statusFile);

  //Remove previous status monitoring page
  Modelica.Utilities.Streams.close("status.html");
  Modelica.Utilities.Files.removeFile("status.html");

  //Add monitoring page
  Modelica.Utilities.Streams.print("<html>
  <head>
  </head>
  <body onload=\"window.setTimeout ('history.go(0)',1000)\">
  <center><h3>Current Sizing:</h3></center>
  <center><IFRAME src=\"" + currentSizingFile + "\" width=150 height=50 align=middle></IFRAME><center>
  <center><h3>Simulation status for current sizing:</h3></center>
  <center><IFRAME src=\"" + statusFile + "\" width=150 height=70 align=middle></IFRAME><center>
  </body>
  </html>","status.html");

  //Open monitoring page
  success :=  system("start status.html");

end if;

for k in 1:sizingNumber loop

  if sizingNumber==1 then
    sizingIndex := "";
    system("echo Single Sizing > "+ currentSizingFile);
  else
    success :=  system("\"" + XSLTProcessor + "\" \"" + airframeSizings + "\" \"" + scanSizingIdXSLT + "\" \"sizingNumber\"=\"" + realString(k,0,0) + "\" > sizingId.txt");
    sizingIndex := Modelica.Utilities.Streams.readLine("sizingId.txt", 1);
    system("echo " + realString(k,0,0) + "/" + realString(sizingNumber,0,0) + " > "+ currentSizingFile);
  end if;

  //Resize systems
  system("echo Resizing > "+ statusFile);
    success := InterfacingTool.TopLevelFunctions.resizeSystems(
          modelicaFile=modelicaFile,
          modelicaModel=modelicaModel,
          emmExperimentsParameters=emmExperimentsParameters,
          airframeSizings=airframeSizings,
          sizingNumber=k,
          sizingIndex=sizingIndex,
          sizingExperiments=sizingExperiments,
          sizingPoints=sizingPoints,
          optimizationFolder=optimizationFolder,
          XSLTProcessor=XSLTProcessor);

  //Create mission points file from spot points and current sizing
    success := InterfacingTool.BaseFunctions.replaceSizing(
          missionPoints=spotPoints,
          sizingIterations=optimizationFolderTemp + "singleSizing.xml",
          sizingNumber=1,
          optimizationFolder=optimizationFolder,
          XSLTProcessor=XSLTProcessor);

  system("echo generate EMM > "+ statusFile);
  //Generate experiments (mission points + standard state) in autoExperiments.xml
    success := InterfacingTool.BaseFunctions.experimentsGen(
          emmExperimentsParameters=emmExperimentsParameters,
          experiments="experiments.xml",
          sizingIteration=optimizationFolderTemp + "sizingMission.xml",
          optimizationFolder=optimizationFolder,
          XSLTProcessor=XSLTProcessor);

  //Generate simulation script "simulateEMM.mos"
    success := InterfacingTool.BaseFunctions.scriptGen(
          modelicaFile=modelicaFile,
          modelicaModel=modelicaModel,
          emmExperimentsParameters=emmExperimentsParameters,
          experiments=optimizationFolderTemp + "autoExperiments.xml",
          sizingIteration=optimizationFolderTemp + "sizingMission.xml",
          optimizationFolder=optimizationFolder,
          XSLTProcessor=XSLTProcessor,
          statusFile=statusFile);

  //Launch simulation off script
  RunScript("simulateEMM.mos");

  //move result files
  Modelica.Utilities.Files.move("resultFiles","resultFiles_"+sizingIndex,true);

  //Post process to create OCAPI engine model
  DataFiles.writeCSVmatrix("emmLight"+sizingIndex+".txt",{"Régime(%)","Mach(-)","Altitude(m)","FN(daN)","CS(kg/daN/h)"},result[:,1:5],";");

end for;

end emmLightGen;
