within EU_CleanSky_Test.EDS.SafetyLib;
model TestSplitMerge2
  "Test associations of split and merge components - Two paths"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Split split
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  EU_CleanSky.EDS.SafetyLib.Merge merge
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,10})));
  EU_CleanSky.EDS.SafetyLib.Link link(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential p
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential n(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load1(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,10})));
equation
  connect(split.f2, load.m) annotation (Line(
      points={{10,32},{10,26},{10,20},{10,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.f, merge.m2) annotation (Line(
      points={{10,0},{10,-12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.f, link1.m) annotation (Line(
      points={{-60,40},{-40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, split.m) annotation (Line(
      points={{-20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.f1, link.m) annotation (Line(
      points={{20,40},{40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.f, load1.m) annotation (Line(
      points={{60,40},{80,40},{80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load1.f, link3.m) annotation (Line(
      points={{80,0},{80,-20},{60,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.f, merge.m1) annotation (Line(
      points={{40,-20},{20,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge.f, link2.m) annotation (Line(
      points={{0,-20},{-20,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, n.m) annotation (Line(
      points={{-40,-20},{-60,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestSplitMerge2;
