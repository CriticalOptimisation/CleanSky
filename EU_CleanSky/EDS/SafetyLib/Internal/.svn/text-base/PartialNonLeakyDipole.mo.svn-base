within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialNonLeakyDipole
  "Extends PartialDipole with equations describing a \" no local leak\" condition."
  extends EU_CleanSky.EDS.SafetyLib.Internal.PartialDipole;
equation
  // leak (no local leaks)
  graphics.leakOut = false;
  graphics.leakIn = false;
  graphics.leakProblem = (m.leak.FtoM or f.leak.MtoF) and semantics ==
    SafetyLib.Semantics.fluid;

end PartialNonLeakyDipole;
