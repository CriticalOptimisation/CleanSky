within EU_CleanSky.EDS.SafetyLib.Interfaces;
connector LogicFlowF
  "Exchange of six pairs of Boolean signals representing a flow of power - Female connector"

  Internal.LogicPairF leak
    "Logic pair is true when power carrying medium leaks to the environment (on P or N side)";
  Internal.LogicPairF open
    "Logic pair is true when the flow of power carrying medium is blocked (on P or N side)";
  Internal.LogicPairF reverse "The medium flows into the N port.";
  Internal.LogicPairF high "The flow has a high potential.";
  Internal.LogicPairF low "The flow has a low potential.";
  Internal.LogicPairF ground
    "The flow has the same potential as the environment (does not carry power).";
annotation(defaultComponentName="n",
  Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02), graphics={Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={255,0,255},
        fillPattern=FillPattern.Solid,
        fillColor={255,255,255})}),
  Diagram(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02)));
end LogicFlowF;
