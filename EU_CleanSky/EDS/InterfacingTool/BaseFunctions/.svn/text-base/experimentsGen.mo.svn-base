within EU_CleanSky.EDS.InterfacingTool.BaseFunctions;
function experimentsGen
  "Automatically generates experiments for a given set of mission points and EMM related parameters file"

input String emmExperimentsParameters= "emmExperimentsParameters.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String experiments = "experiments.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String sizingIteration = "sizingIteration.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
//due to current Dymola limitation, instead of choosing a folder, a file in the folder must be selected via the GUI
input String optimizationFolder = "" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTProcessor = "C:\Temp/saxon/Transform.exe" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTScript = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/experimentsGen.xsl" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));

output Boolean success;

//internal variable containing the path name of the working directory
protected
String optimizationFolderTemp;

algorithm
  (optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
  cd(optimizationFolderTemp);
  success :=  system("\"" + XSLTProcessor + "\" \"" + XSLTScript + "\" \"" + XSLTScript + "\" emmExperimentsParameters=\"" + emmExperimentsParameters + "\" experiments=\"" + experiments + "\" sizingIteration=\"" + sizingIteration + "\" > autoExperiments.xml");

end experimentsGen;
