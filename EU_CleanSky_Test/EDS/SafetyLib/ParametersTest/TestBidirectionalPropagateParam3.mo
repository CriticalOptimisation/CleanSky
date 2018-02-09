within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestBidirectionalPropagateParam3
  "Check class with non-default parameter settings. Test is OK if check is successful."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.BidirectionalPropagate(useInput=
        true, useStatus=false);
end TestBidirectionalPropagateParam3;
