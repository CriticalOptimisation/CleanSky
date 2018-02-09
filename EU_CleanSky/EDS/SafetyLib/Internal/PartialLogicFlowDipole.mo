within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialLogicFlowDipole
  "Dipole of a power system. Normal flow is from P to N internally. State indicated by 6 logic pairs: open, leak, reversed flow, high, low and ground potentials."
 extends EU_CleanSky.EDS.SafetyLib.Internal.PartialDipole;

/* Internal components */

protected
  LogicPairM openM "P-side open circuit pair internal connector."
    annotation (Placement(transformation(extent={{-82,98},{-78,102}})));
  LogicPairM leakM "P-side leak pair internal connector."
    annotation (Placement(transformation(extent={{-82,58},{-78,62}})));
  LogicPairM revM "P-side reverse flow pair internal connector."
    annotation (Placement(transformation(extent={{-82,18},{-78,22}})));
  LogicPairM groundM "P-side ground pair internal connector."
    annotation (Placement(transformation(extent={{-82,-62},{-78,-58}})));
  LogicPairM lowM "P-side low logic level pair internal connector."
    annotation (Placement(transformation(extent={{-82,-102},{-78,-98}})));
  LogicPairM highM "P-side high logic level pair internal connector."
    annotation (Placement(transformation(extent={{-82,-22},{-78,-18}})));
  LogicPairF openF "N-side open circuit pair internal connector."
    annotation (Placement(transformation(extent={{78,98},{82,102}})));
  LogicPairF leakF "N-side leak pair internal connector."
    annotation (Placement(transformation(extent={{78,58},{82,62}})));
  LogicPairF revF "N-side reverse flow pair internal connector."
    annotation (Placement(transformation(extent={{78,18},{82,22}})));
  LogicPairF highF "N-side high logic level pair internal connector."
    annotation (Placement(transformation(extent={{78,-22},{82,-18}})));
  LogicPairF groundF "N-side ground pair internal connector."
    annotation (Placement(transformation(extent={{78,-62},{82,-58}})));
  LogicPairF lowF "N-side low logic level pair internal connector."
    annotation (Placement(transformation(extent={{78,-102},{82,-98}})));
equation

  connect(m.high,highM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,-20},{-80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.ground,groundM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,-60},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.low,lowM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,-100},{-80,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.reverse,revM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.leak,leakM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.open,openM)  annotation (Line(
      points={{-100,0},{-90,0},{-90,100},{-80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.open,openF)  annotation (Line(
      points={{100,0},{90,0},{90,100},{80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakF,f. leak) annotation (Line(
      points={{80,60},{90,60},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF,f. high) annotation (Line(
      points={{80,-20},{90,-20},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundF,f. ground) annotation (Line(
      points={{80,-60},{90,-60},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF,f. low) annotation (Line(
      points={{80,-100},{90,-100},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revF,f. reverse) annotation (Line(
      points={{80,20},{90,20},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({135,135,135}, if graphics.problem < 0.5 then graphics.background else {255,135,0}),
          fillPattern=FillPattern.Solid),
        Polygon(visible=true,
          points=DynamicSelect({{-48,14},{-48,-14},{-24,0},{-24,-14},{0,0},{0,-14},{24,0},{24,
              -14},{48,0},{24,14},{24,0},{0,14},{0,0},{-24,14},{-24,0}},graphics.pointsP),
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor=DynamicSelect({135,135,135}, if graphics.stillP < 0.5 then {0,127,0} else
                    graphics.background),
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135},
          origin={-48,0},
          rotation=0),
        Polygon(visible=true,
          points=DynamicSelect({{-48,14},{-48,-14},{-24,0},{-24,-14},{0,0},{0,-14},{24,0},{24,
              -14},{48,0},{24,14},{24,0},{0,14},{0,0},{-24,14},{-24,0}},graphics.pointsN),
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor=DynamicSelect({135,135,135}, if graphics.stillN < 0.5 then {0,127,0} else
                    graphics.background),
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135},
          origin={48,0},
          rotation=0),
        Text(
          extent={{-110,0},{112,-38}},
          textString="%name",
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,127,0})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,extent={{-100,-100},{100,100}}),
                                                    graphics),
    Documentation(info="<html>
<p>Dipole is an abstraction of a bipolar device transporting a power carrying medium. It can be used as a simple model of any electrical dipole, or wire. It is also applicable to fluid power systems, whether they carry heat or hydraulic power.</p>
<p>The dipole propagates information in Booleans along a sequence of dipoles. Its has no internal state, but accepts two inputs &QUOT;Open&QUOT; and &QUOT;Leak&QUOT; from the englobing component model. &QUOT;Open&QUOT; means that the flow of power is blocked, by an electrical open circuit for instance. Another example could be a clogged filter in a fluid system. &QUOT;Leak&QUOT; means that the power carrying fluid is massively leaving the circuit to go into the environment. It can be the consequence of an electrical short-circuit, or a pipe that opens. The component describes the power system point of view: even though small leaks may do harm in the receiving environment, they will not have an immediate effect on the power system. The leak input describes leaks large enough to cause a change in the intensive variable (voltage or pressure).</p>
<p>A large leak has also the effect of a downstream blockage. The Open information will be true on the downstream side. The normal flow orientation is P to N, but the flow can be reversed.</p>
</html>"));
end PartialLogicFlowDipole;
