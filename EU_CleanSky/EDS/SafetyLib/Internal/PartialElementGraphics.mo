within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialElementGraphics
  "Defines the graphical conventions of the library elements."
  parameter Semantics semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical
    "Define power flow semantics. Defaults to electrical for backwards compatibility. Set by circuit specific library skins."
    annotation (Evaluate=true,HideResult=true);
public
  Graphics graphics "Graphical information";
equation
  // Set background according to semantics
  graphics.background = if graphics.problem then {255,135,0} elseif semantics
     == SafetyLib.Semantics.electrical then {135,135,170} else {170,135,135};

  annotation (Documentation(info="<html>
<p>To make a complete component, derivative models must add equations which define eight parameters in Graphics. </p>
<p>Four parameters are the same on the Male side and on the Female side:</p>
<p><ul>
<li>stillM, stillF indicate the absence of flow in a circuit branch.</li>
<li>reversedM, reversedF indicate flow from to N pin to the P pin for dipoles, and must be set to false for other components.</li>
</ul></p>
<p><br/>Two parameters control the leak indicators:</p>
<p><ul>
<li>leakIn indicates surrounding environment medium (or electrical current) leaks into the circuit.</li>
<li>leakOut indicates that circuit medium (or electrical current) leaks into the surrounding environment.</li>
</ul></p>
<p>Note that small leaks which pollute the environment but do not significantly affect operation of the circuit should be treated as failure modes of other components susceptible to contamination by circuit medium. Leaks modelled by safetyLib have an impact on circuit operation by definition.</p>
<p><br/>Two parameters control problem indication (orange background):</p>
<p><ul>
<li>leakProblem indicates that the component is affected by a nearby leak.</li>
<li>blockageProblem indicates that flow is blocked somewhere in this branch of the circuit.</li>
</ul></p>
<p>For standard dipole rectangular components, 5 suitable equations are included in Internal.PartialDipole : stillX, reversedX and blockageProblem.</p>
<p>Round shaped single pole components derive from Internal.PartialLogicFlowSourceOrSink, and source &QUOT;battery&QUOT; shaped rectangular components derive from Interfaces.PowerSources (Tracker 10839)</p>
<p>These partial models also defines how the standard icons show various conditions defined here:</p>
<p><ul>
<li>On the M and F sides (independently) triangular arrows during simulation dynamically show flow direction (or absence of flow) based on stillX and reversedX. The arrows are dark green.</li>
<li>A blockage or a leak affecting the component (problem condition are propagated) turns the component background orange.</li>
<li>Components have a customisable background color when they operate normally. This parameter can be used by skins. Default is two different shades of gray denoting electrical vs. fluid semantics. Electrical semantics make the background slightly bluish. In comparison fluid semantics make the background slightly greenish.</li>
</ul></p>
</html>"));
end PartialElementGraphics;
