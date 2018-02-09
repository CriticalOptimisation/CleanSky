within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestBlockNtoPParam2
  "Check that model is consistent for all parameter values."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.BlockNtoP(useInput=false,
      useStatus=true);
end TestBlockNtoPParam2;
