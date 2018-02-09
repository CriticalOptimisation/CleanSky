within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestControlledBoosterParam2
  "Check that model is consistent for all values of parameters."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.ControlledBooster(useInput=false,
      useSinkInterface=true);
end TestControlledBoosterParam2;
