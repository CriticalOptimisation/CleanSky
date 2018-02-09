within EU_CleanSky.EDS.SafetyLib.Internal;
connector LogicPairM "Exchange of a pair of Boolean signals - Male connector"

  Modelica.Blocks.Interfaces.BooleanInput FtoM;
  Modelica.Blocks.Interfaces.BooleanOutput MtoF;
annotation(defaultComponentName="p",
  Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02), graphics={Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={255,0,255},
        fillPattern=FillPattern.Solid,
        fillColor={255,0,255}), Text(
          extent={{-120,282},{530,90}},
          lineColor={255,0,255},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
  Diagram(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      initialScale=0.02)));
end LogicPairM;
