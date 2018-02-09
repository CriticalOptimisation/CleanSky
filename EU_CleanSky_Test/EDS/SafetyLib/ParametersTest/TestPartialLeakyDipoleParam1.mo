within EU_CleanSky_Test.EDS.SafetyLib.ParametersTest;
model TestPartialLeakyDipoleParam1
  "Check that model is valid with any parameter value."
  import EU_CleanSky.EDS.SafetyLib;
  extends EU_CleanSky.EDS.SafetyLib.Internal.PartialLeakyDipole(useOpen=false,
      useLeak=false);
  // Additional equations to make partial model complete
equation
  highP.PtoN = false;
  highN.NtoP = false;
  lowP.PtoN = false;
  lowN.NtoP = false;
  or1.u1 = true;
end TestPartialLeakyDipoleParam1;
