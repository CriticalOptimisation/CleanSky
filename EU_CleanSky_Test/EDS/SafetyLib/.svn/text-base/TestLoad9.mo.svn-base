within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad9 "Test of dipole electrically ground referenced above the load."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link2(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-84,-28},{-64,-8}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useReverseInterface=false)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-63,-18},{-48,-18},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link2.m) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, load.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.f, sink.m) annotation (Line(
      points={{0,40},{10,40}},
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
end TestLoad9;
