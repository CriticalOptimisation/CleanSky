within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestPartialLogicPairDipoleParam3
  "Check that partial model is valid with all parameter settings."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.PartialLogicPairDipole(useInput=
        true, useStatus=false);
  // Additional equations to complete the partial model
equation
  n.NtoP = false;
  p.PtoN = false;
end TestPartialLogicPairDipoleParam3;
