within EU_CleanSky.EDS.SafetyLib.Interfaces;
connector LogicFlowM
  "Exchange of six pairs of Boolean signals representing a flow of power - Male connector"

  Internal.LogicPairM leak
    "Logic pair is true when power carrying medium leaks to the environment on P or N side.";
  Internal.LogicPairM open
    "Logic pair is true when power flow is blocked (either on P side or on N side of connector)";
  Internal.LogicPairM reverse "The medium flows from the P port.";
  Internal.LogicPairM high "Indicates high potential on the flow.";
  Internal.LogicPairM low "Indicates low potential on the flow.";
  Internal.LogicPairM ground
    "Indicates a flow at the same potential as the surrounding environment (no power).";
annotation(defaultComponentName="p",
  Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02), graphics={Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={255,0,255},
        fillPattern=FillPattern.Solid,
        fillColor={255,0,255})}),
  Diagram(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02)));

end LogicFlowM;
