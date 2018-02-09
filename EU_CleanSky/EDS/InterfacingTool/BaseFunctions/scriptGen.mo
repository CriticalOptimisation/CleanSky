within EU_CleanSky.EDS.InterfacingTool.BaseFunctions;
function scriptGen
  "generates a modelica script for a given list of experiments, returns simulateEMM.mos"

//functionnal inputs
input String modelicaFile = "U:/CleanSky/WIP/Interfacing Tool/Validation/EMM.mo"
                                           annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String modelicaModel = "EMM.Emm";
input String emmExperimentsParameters= "emmExperimentsParameters.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String experiments = "C:/Temp/test/autoExperiments.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));
input String sizingIteration = "sizingIteration.xml" annotation(Dialog(
                         __Dymola_loadSelector(filter="All files (*.xml)")));

//parametring inputs
input String optimizationFolder = "" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTProcessor = "C:\Temp/saxon/Transform.exe" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String XSLTScript = "U:/CleanSky/WIP/Interfacing Tool/Tool parts/scriptGen.xsl" annotation(Dialog(tab="Parameters",
                         __Dymola_loadSelector(filter="All files (*.*)")));
input String statusFile = "status.txt"
    "File ontaining the status of the current systems' resizing" annotation(Dialog(tab="Parameters"));

output Boolean success;

//internal variable containing the path name of the working directory
protected
String optimizationFolderTemp;

algorithm
(optimizationFolderTemp,,):= Modelica.Utilities.Files.splitPathName(optimizationFolder);
cd(optimizationFolderTemp);
success :=  system("\"" + XSLTProcessor + "\" \"" + XSLTScript + "\" \"" + XSLTScript + "\" modelicaFile=\"" + modelicaFile +"\" modelicaModel=\"" + modelicaModel + "\" emmExperimentsParameters=\"" + emmExperimentsParameters + "\" experiments=\"" + experiments + "\" sizingIteration=\"" + sizingIteration + "\" workingDirectory=\"" + optimizationFolderTemp + "\" statusFile=\"" + statusFile + "\" > simulateEMM.mos");

end scriptGen;
