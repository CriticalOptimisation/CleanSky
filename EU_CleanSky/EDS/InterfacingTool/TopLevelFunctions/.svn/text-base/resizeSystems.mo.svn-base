within EU_CleanSky.EDS.InterfacingTool.TopLevelFunctions;
function resizeSystems
  "Function called to resize systems for a given airframe size, a file named singleSizing.xml will be created in optimizationFolder"
//VS Architecture
input String vsArchitectureFile= "VSArchitecture.xml"
    "XML file containing the VS architecture initial sizing" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input String equipmentList= "equipments.xml"
    "XML file containing the details on equipments used in the architecture" annotation(Dialog(group="VS Architecture",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
//EMM
input String modelicaFile = "C:/Temp/eu.mo" annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="Modelica files (*.mo;*.moe)")));
input String modelicaModel = "eu.cleansky.EDS.EMM.TestRig.BenchModels.VehicleInterfaceDesign.testBench" annotation(Dialog(group="EMM",__Dymola_translatedModel));
input String emmExperimentsParameters= "emmExperimentsParameters.xml" annotation(Dialog(group="EMM",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//Sizing tab
input String airframeSizings = "airframeSizings.xml"
    "map of different possible airframe sizings"                                                  annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input Integer sizingNumber "Sizing to consider in airframe sizings file" annotation(Dialog(tab="Sizing"));
input String sizingIndex "Id of considered sizing" annotation(Dialog(tab="Sizing"));

input String sizingPoints = "sizingPoints.xml"
    "Mission Points used for systems' sizing"                                            annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));
input String sizingExperiments = "sizingExperiments.xml"
    "Manually defined experiments used for resizing"                                                      annotation(Dialog(tab="Sizing",
                         __Dymola_loadSelector(filter="XML files (*.xml)")));

//technical settings tab
input String XSLTProcessor = "C:\Temp/saxon/Transform.exe" annotation(Dialog(tab = "settings", group="XSLT Processor",
                         __Dymola_loadSelector(filter="Executable files (*.exe; *.bat)")));
input String optimizationFolder = "C:/Temp/Test Bench 1808/"
    "Folder where simulation data is generated" annotation(Dialog(tab = "settings", group="Workspace",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String statusFile = "statusResize.txt"
    "File ontaining the status of the current systems' resizing" annotation(Dialog(tab="settings"));

output Boolean success;

protected
String optimizationFolderTemp;

algorithm
  (optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
  cd(optimizationFolderTemp);

  //Create mission points file for given sizing
  success := InterfacingTool.BaseFunctions.replaceSizing(
        missionPoints=sizingPoints,
        sizingIterations=airframeSizings,
        sizingNumber=sizingNumber,
        optimizationFolder=optimizationFolder,
        XSLTProcessor=XSLTProcessor);
  //generate experiments for this sizing
  success := InterfacingTool.BaseFunctions.experimentsGen(
        emmExperimentsParameters=emmExperimentsParameters,
        experiments="sizingExperiments.xml",
        sizingIteration=optimizationFolderTemp + "sizingMission.xml",
        optimizationFolder=optimizationFolder,
        XSLTProcessor=XSLTProcessor);

  //Generate simulation script
  success := InterfacingTool.BaseFunctions.scriptGen(
        modelicaFile=modelicaFile,
        modelicaModel=modelicaModel,
        emmExperimentsParameters=emmExperimentsParameters,
        experiments=optimizationFolderTemp + "autoExperiments.xml",
        sizingIteration=optimizationFolderTemp + "sizingMission.xml",
        optimizationFolder=optimizationFolder,
        XSLTProcessor=XSLTProcessor,
        statusFile=statusFile);

  //Launch simulation of the generated script
  RunScript("simulateEMM.mos");

  //move result files
  Modelica.Utilities.Files.move("resultFiles","resultFilesResize_"+sizingIndex);

  //update systems' sizing for current airframe
  //Copy current sizing in a file containing a single sizing
  success := InterfacingTool.BaseFunctions.extractSizing(
        sizingIterations=airframeSizings,
        sizingNumber=sizingNumber,
        optimizationFolder=optimizationFolder,
        XSLTProcessor=XSLTProcessor);

  //add system sizings in the file
  for k in 1:size(result,2) loop
    //here, the name of the sizing parameter is the name of the sizing output without "Model" ending it
    success := InterfacingTool.BaseFunctions.updateSizing(
          singleSizing=optimizationFolderTemp + "singleSizing.xml",
          sizingName=Modelica.Utilities.Strings.substring(
            FinalNames[1, k],
            1,
            Modelica.Utilities.Strings.find(FinalNames[1, k], "Model") - 1),
          sizingValue=realString(max(result[:, k])),
          emmExperimentsParameters=emmExperimentsParameters,
          optimizationFolder=optimizationFolder,
          XSLTProcessor=XSLTProcessor);
  end for;

end resizeSystems;
