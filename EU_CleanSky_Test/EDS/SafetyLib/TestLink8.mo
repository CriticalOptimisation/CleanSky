within EU_CleanSky_Test.EDS.SafetyLib;
model TestLink8 "Open link. Hidden connectors."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useLeak=false, useOpen=true)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Sources.BooleanExpression open(y=true)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  EU_CleanSky.EDS.SafetyLib.Link link4(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
equation
  connect(link2.open, open.y) annotation (Line(
      points={{-22,36},{-22,0},{-69,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-80,40},{-70,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, link2.m) annotation (Line(
      points={{-50,40},{-30,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, link3.m) annotation (Line(
      points={{-10,40},{10,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.f, link4.m) annotation (Line(
      points={{30,40},{50,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link4.f, sink.m) annotation (Line(
      points={{70,40},{80,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=2),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>When a leak is created in &QUOT;link2&QUOT;, the load continues to run although spent power is evacuated to the environment through the leak.</p>
<p>The condition for a load to be correctly powered from a power system are:</p>
<p><ul>
<li>It must receive a low signal on its N side and a high signal on its P side.</li>
<li>It must not receive a ground signal on both N and P.</li>
<li>It must not be traversed by an &QUOT;open&QUOT; signal in either direction, since that indicates a blocked flow / open circuit.</li>
</ul></p>
<p><br/>In addition, when a leak is created in link1 too, the flow of power goes from + to - through the ground, and not through the load, therefore the load isn&apos;t powered.</p>
</html>"));
end TestLink8;
