within EU_CleanSky_Test.EDS.SafetyLib;
model TestControlledPower2 "Test of controlled power supply switched off."
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
  Modelica.Blocks.Sources.BooleanConstant powerOff(k=false)
    annotation (Placement(transformation(extent={{-74,50},{-54,70}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-63,-18},{-48,-18},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(powerOff.y, power.u) annotation (Line(
      points={{-53,60},{-46,60},{-46,70},{-40,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.m, power.p) annotation (Line(
      points={{-60,40},{-80,40},{-80,80},{-38,80},{-38,76.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.n, load.f) annotation (Line(
      points={{-22,76.6},{-22,80},{20,80},{20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.m, link2.f) annotation (Line(
      points={{-20,40},{-40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=1),
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
end TestControlledPower2;
