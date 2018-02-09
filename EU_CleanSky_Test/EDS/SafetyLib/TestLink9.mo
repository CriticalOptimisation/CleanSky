within EU_CleanSky_Test.EDS.SafetyLib;
model TestLink9 "Test fluid leak semantics."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  EU_CleanSky.EDS.SafetyLib.Cap sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
  EU_CleanSky.EDS.SafetyLib.Cap sink annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,40})));
  EU_CleanSky.EDS.SafetyLib.Link link2(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Sources.BooleanExpression leak(y=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(leak.y, link1.leak) annotation (Line(
      points={{-59,0},{-48,0},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak.y, link2.leak) annotation (Line(
      points={{-59,0},{-8,0},{-8,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak.y, link3.leak) annotation (Line(
      points={{-59,0},{32,0},{32,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-80,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, link2.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, link3.m) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.f, sink.m) annotation (Line(
      points={{40,40},{60,40}},
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
end TestLink9;
