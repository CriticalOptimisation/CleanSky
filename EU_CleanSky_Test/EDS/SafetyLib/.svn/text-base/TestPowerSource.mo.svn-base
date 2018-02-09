within EU_CleanSky_Test.EDS.SafetyLib;
model TestPowerSource "Test of power source icon look"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.Interfaces.PowerSource powerSource
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-59,0},{-48,0},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.plusM, link2.n) annotation (Line(
      points={{-20,40},{-40,40}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(powerSource.f, link2.m) annotation (Line(
      points={{-36,75},{-36,84},{-80,84},{-80,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(powerSource.m, load.minusF) annotation (Line(
      points={{-24,75},{-24,84},{20,84},{20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=0.5, NumberOfIntervals=1),
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
end TestPowerSource;
