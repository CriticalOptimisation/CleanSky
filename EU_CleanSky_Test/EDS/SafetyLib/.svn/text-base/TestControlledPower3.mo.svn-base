within EU_CleanSky_Test.EDS.SafetyLib;
model TestControlledPower3 "Test of controlled power supply switching."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-84,-28},{-64,-8}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.ControlledPower power
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(
    width=50,
    period=1,
    startTime=0.25)
    annotation (Placement(transformation(extent={{-72,60},{-52,80}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-63,-18},{-48,-18},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.plusM, link2.n) annotation (Line(
      points={{-20,40},{-40,40}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(power.m, link2.p) annotation (Line(
      points={{-38,76.6},{-38,80},{-78,80},{-78,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.f, load.minusF) annotation (Line(
      points={{-22,76.6},{-22,80},{18,80},{18,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanPulse.y, power.u) annotation (Line(
      points={{-51,70},{-40,70}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=10, NumberOfIntervals=100),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>A leak in &QUOT;link2&QUOT; does not affect the load, since it simply references the circuit to the ground in &QUOT;link2&QUOT;.</p>
<p>The condition for a load to be correctly powered from a power system are:</p>
<p><ul>
<li>It must receive a low signal on its - side and a high signal on its + side.</li>
<li>It must not receive a ground signal on both N and P.</li>
<li>It must not be traversed by an &QUOT;open&QUOT; signal in both directions, since that indicates a blocked flow / open circuit.</li>
</ul></p>
</html>"));
end TestControlledPower3;
