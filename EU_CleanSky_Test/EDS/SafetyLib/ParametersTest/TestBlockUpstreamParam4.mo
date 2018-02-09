within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestBlockUpstreamParam4
  "Check that model is consistent for any value of parameters."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.BlockUpstream(useInput=true,
      useStatus=true);
end TestBlockUpstreamParam4;
