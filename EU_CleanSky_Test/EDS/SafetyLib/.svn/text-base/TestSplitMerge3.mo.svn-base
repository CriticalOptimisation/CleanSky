within EU_CleanSky_Test.EDS.SafetyLib;
model TestSplitMerge3
  "Test associations of split and merge components - Two paths and ground"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Split split
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  EU_CleanSky.EDS.SafetyLib.Merge merge
    annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  EU_CleanSky.EDS.SafetyLib.Link load(useOpen=false, useLeak=true) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,10})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential p
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential n(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load1(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,10})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-40,0},{-24,16}})));
equation
  connect(split.f2, load.p) annotation (Line(
      points={{10,32},{10,26},{10,20},{10,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakSrc.y, load.leak) annotation (Line(
      points={{-23.2,8},{6,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.f1, load1.plusM) annotation (Line(
      points={{20,40},{40,40},{40,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.f, split.m) annotation (Line(
      points={{-20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(n.m, merge.f) annotation (Line(
      points={{60,-20},{50,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge.m2, load1.minusF) annotation (Line(
      points={{40,-12},{40,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.n, merge.m1) annotation (Line(
      points={{10,0},{10,-20},{30,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestSplitMerge3;
