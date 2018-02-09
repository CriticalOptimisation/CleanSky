within EU_CleanSky.EDS.SafetyLib.Internal;
record Graphics "Variables dedicated to graphical animation"
  final constant Real shape[15,2]={{-48,14},{-48,-14},{-24,0},{-24,-14},{0,
    0},{0,-14},{24,0},{24,-14},{48,0},{24,14},{24,0},{0,14},{0,0},{-24,14},
    {-24,0}};
  Real pointsM[15,2]=(if reversedM then -shape else shape);
  Real pointsF[15,2]=(if reversedF then -shape else shape);
   Boolean problem=leakProblem or blockageProblem
    "Element is affected by leak or blockage";
   // These parameters control object appearance, and must be defined by the application
  Boolean stillM "Indicates absence of flow on M side";
  Boolean stillF "Indicates absence of flow on F side";
  Boolean reversedM "Indicates flow out from M side";
  Boolean reversedF "Indicates flow into F side";
   Boolean leakIn "Leak lets power carrying medium or surrounding fluid in";
   Boolean leakOut
    "Leak lets power carrying medium escape into surrounding environment";
   Boolean leakProblem(start = false) "Element is affected by leak";
   Boolean blockageProblem(start = false)
    "Element is affected by flow restriction or blockage";
   Real background[3];
end Graphics;
