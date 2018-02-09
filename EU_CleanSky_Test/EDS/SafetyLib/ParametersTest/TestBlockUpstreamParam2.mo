within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestBlockUpstreamParam2
  "Check that model is consistent for any value of parameters."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.BlockUpstream(useInput=false,
      useStatus=true);
end TestBlockUpstreamParam2;
