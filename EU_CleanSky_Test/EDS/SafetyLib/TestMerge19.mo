within EU_CleanSky_Test.EDS.SafetyLib;
model TestMerge19 "Three high potential sources"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Merge merge1
    annotation (Placement(transformation(extent={{-20,50},{0,30}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(useOpen=false, useLeak=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,-10})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential source2
    annotation (Placement(transformation(extent={{80,30},{60,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential source1 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,-50})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sink(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,40})));
  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-40,30},{-60,50}})));
equation
  connect(merge1.m2, link3.n) annotation (Line(
      points={{-10,32},{-10,16},{-10,0},{-10,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sink.m, link1.n) annotation (Line(
      points={{-80,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.p, merge1.f) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge1.m1, link2.n) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.p, source2.f) annotation (Line(
      points={{40,40},{60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.p, source1.f) annotation (Line(
      points={{-10,-20},{-10,-25},{-10,-25},{-10,-30},{-10,-40},{-10,-40}},
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
</html>"));
end TestMerge19;
