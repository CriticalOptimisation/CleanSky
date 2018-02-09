within EU_CleanSky.EDS.InterfacingTool.BaseFunctions;
function updateSizing "Adds a sizing parameter in a given single sizing file"

input String emmExperimentsParameters= "emmExperimentsParameters.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));

input String singleSizing = "singleSizing.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
//due to current Dymola limitation, instead of choosing a folder, a file in the folder must be selected via the GUI
input String optimizationFolder = "" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTProcessor = "C:\Temp/saxon/Transform.exe" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String updateSizingXSLT = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/updateSizing.xsl" annotation(Dialog(tab = "parameters",
                         __Dymola_loadSelector(filter="XSL/XSLT files (*.xsl; *.xslt)")));
input String sizingName "name of sizing parameter to add";
input String sizingValue "value of sizing parameter";

output Boolean success;

//internal variable containing the path name of the working directory
protected
String optimizationFolderTemp;

algorithm
  (optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
  cd(optimizationFolderTemp);

  success := system("\"" + XSLTProcessor + "\" \"" + updateSizingXSLT + "\" \"" + updateSizingXSLT + "\" singleSizing=\"" + singleSizing + "\" sizingName=\"" + sizingName + "\" sizingValue=\"" + sizingValue + "\" emmExperimentsParameters=\"" + emmExperimentsParameters + "\" > \"" + singleSizing +".tmp\"");
  Modelica.Utilities.Files.move(singleSizing +".tmp",singleSizing,true);
end updateSizing;
