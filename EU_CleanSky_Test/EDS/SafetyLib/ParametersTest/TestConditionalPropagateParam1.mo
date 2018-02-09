within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestConditionalPropagateParam1
  "Check that class remains valid with all possible parameter values."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.ConditionalPropagate(useInput=
        false, useStatus=false);
end TestConditionalPropagateParam1;
