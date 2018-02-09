within EU_CleanSky_Test.EDS.SafetyLib;
model TestPermanentPower1 "Test of dipole circuits N°2."

  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.PermanentPower power(useReverseInterface=
        false, d(useReverseInterface=power.useReverseInterface))
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-59,20},{-48,20},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.f, link2.m) annotation (Line(
      points={{-36,75},{-36,80},{-80,80},{-80,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.m, load.f) annotation (Line(
      points={{-24,75},{-24,80},{20,80},{20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, load.m) annotation (Line(
      points={{-40,40},{-20,40}},
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
end TestPermanentPower1;
