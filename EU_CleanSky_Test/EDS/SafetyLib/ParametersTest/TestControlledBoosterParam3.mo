within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestControlledBoosterParam3
  "Check that model is consistent for all values of parameters."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.ControlledBooster(useInput=true,
      useSinkInterface=false);
end TestControlledBoosterParam3;
