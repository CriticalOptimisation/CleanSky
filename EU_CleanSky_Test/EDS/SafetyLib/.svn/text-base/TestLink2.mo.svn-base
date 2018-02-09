within EU_CleanSky_Test.EDS.SafetyLib;
model TestLink2 "Checks absence of flow between two leaks."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-84,24},{-64,44}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  EU_CleanSky.EDS.SafetyLib.Link link4(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{40,30},{20,10}})));
  EU_CleanSky.EDS.SafetyLib.Link link5(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{0,30},{-20,10}})));
  EU_CleanSky.EDS.SafetyLib.Link link6(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-40,30},{-60,10}})));
  EU_CleanSky.EDS.SafetyLib.Link link7(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  EU_CleanSky.EDS.SafetyLib.Link link8(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  EU_CleanSky.EDS.SafetyLib.Link link9(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  EU_CleanSky.EDS.SafetyLib.Link link10(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-90}})));
  EU_CleanSky.EDS.SafetyLib.Link link11(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{0,-70},{-20,-90}})));
  EU_CleanSky.EDS.SafetyLib.Link link12(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{40,-70},{20,-90}})));
equation
  connect(link1.leak, leakSrc.y) annotation (Line(
      points={{-48,76},{-48,34},{-63,34}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.leak, leakSrc.y) annotation (Line(
      points={{32,76},{32,34},{-63,34}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-70,80},{-60,80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, link2.m) annotation (Line(
      points={{-40,80},{-20,80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, link3.m) annotation (Line(
      points={{0,80},{20,80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.f, link4.m) annotation (Line(
      points={{40,80},{60,80},{60,20},{40,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link4.f, link5.m) annotation (Line(
      points={{20,20},{0,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link5.f, link6.m) annotation (Line(
      points={{-20,20},{-40,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link6.f, link9.m) annotation (Line(
      points={{-60,20},{-80,20},{-80,-20},{-60,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link9.f, link8.m) annotation (Line(
      points={{-40,-20},{-20,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link8.f, link7.m) annotation (Line(
      points={{0,-20},{20,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link7.f, link12.m) annotation (Line(
      points={{40,-20},{60,-20},{60,-80},{40,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link12.f, link11.m) annotation (Line(
      points={{20,-80},{0,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link11.f, link10.m) annotation (Line(
      points={{-20,-80},{-40,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link10.f, sink.m) annotation (Line(
      points={{-60,-80},{-70,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    Documentation(info="<html>
<p>This test is an extension of TestLink1 to many link components in a row. In principle, the number of consecutive link elements is unlimited.</p>
<p>In addition, leaks are optionally present on link1 and link3. For an electrical circuit using + and - polarisations relative to ground, power would flow through the ground between link1 and link3, and re-enter the circuit at link3. It is assumed that links are near zero impedance, but that ground impedance is always significantly smaller. This test also demonstrates the disappearance of flow indication arrows on sections which are necessarily at ground potential.</p>
</html>"),
    experiment(StopTime=0.5, Interval=0.1),
    __Dymola_experimentSetupOutput);
end TestLink2;
