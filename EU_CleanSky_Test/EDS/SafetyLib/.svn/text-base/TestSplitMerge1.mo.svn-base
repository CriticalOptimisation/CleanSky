within EU_CleanSky_Test.EDS.SafetyLib;
model TestSplitMerge1 "Test associations of split and merge components."
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
  EU_CleanSky.EDS.SafetyLib.Cap cap
    annotation (Placement(transformation(extent={{84,-24},{76,-16}})));
  EU_CleanSky.EDS.SafetyLib.Cap cap1(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{76,36},{84,44}})));
equation
  connect(split.f2, load.plusM) annotation (Line(
      points={{10,32},{10,26},{10,20},{10,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.minusF, merge.m2) annotation (Line(
      points={{10,0},{10,-12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.n, split.m) annotation (Line(
      points={{-20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.f1, link.p) annotation (Line(
      points={{20,40},{40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.p, merge.f) annotation (Line(
      points={{-20,-20},{0,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge.m1, link3.n) annotation (Line(
      points={{20,-20},{40,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.n, cap1.p) annotation (Line(
      points={{60,40},{80,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.p, cap.n) annotation (Line(
      points={{60,-20},{80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(n.m, link2.n) annotation (Line(
      points={{-60,-20},{-40,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.f, link1.p) annotation (Line(
      points={{-60,40},{-40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestSplitMerge1;
