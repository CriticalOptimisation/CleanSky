within EU_CleanSky.EDS.InterfacingTool.BaseFunctions;
function extractSizing "Extracts a sizing from a multiple sizings file"

input String sizingIterations = "sizingIterations.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
//due to current Dymola limitation, instead of choosing a folder, a file in the folder must be selected via the GUI
input String optimizationFolder = "" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTProcessor = "C:\Temp/saxon/Transform.exe" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String extractSizingXSLT = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/extractSizing.xsl" annotation(Dialog(tab = "parameters",
                         __Dymola_loadSelector(filter="XSL/XSLT files (*.xsl; *.xslt)")));
input Integer sizingNumber "Sizing to consider in airframe sizings file";

output Boolean success;

//internal variable containing the path name of the working directory
protected
String optimizationFolderTemp;

algorithm
  (optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
  cd(optimizationFolderTemp);

  success :=  system("\"" + XSLTProcessor + "\" \"" + extractSizingXSLT + "\" \"" + extractSizingXSLT + "\" sizingIterations=\"" + sizingIterations + "\" sizingNumber=" + realString(sizingNumber,0,0) + " > singleSizing.xml");

end extractSizing;
