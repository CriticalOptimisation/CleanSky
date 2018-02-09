within EU_CleanSky.EDS.Electrical.Examples;
model TestElectricalFunction1
  "Simple static test of parameters interface and icon appearance."

  EU_CleanSky.EDS.SafetyLib.Split split
    annotation (Placement(transformation(extent={{-42,10},{-22,-10}})));
  EU_CleanSky.EDS.SafetyLib.Merge merge
    annotation (Placement(transformation(extent={{16,-10},{-4,10}})));
  EU_CleanSky.EDS.SafetyLib.Link link(useLeak=true)
    annotation (Placement(transformation(extent={{-20,30},{0,10}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{20,-32},{42,-12}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential n
    annotation (Placement(transformation(extent={{74,-32},{54,-12}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential p
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  SafetyLib.FailureMode leak(lambda=1E-5)
    annotation (Placement(transformation(extent={{-68,20},{-28,60}})));
equation
  connect(n.m, load.f) annotation (Line(
      points={{54,-22},{42,-22}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.m, split.f2) annotation (Line(
      points={{-20,20},{-32,20},{-32,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.f, merge.m2) annotation (Line(
      points={{0,20},{6,20},{6,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.f1, merge.m1) annotation (Line(
      points={{-22,0},{-4,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge.f, load.m) annotation (Line(
      points={{16,0},{18,0},{18,-22},{20,-22}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.f, split.m) annotation (Line(
      points={{-60,0},{-42,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak.y, link.leak) annotation (Line(
      points={{-36.4,40},{-8,40},{-8,24}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics));
end TestElectricalFunction1;
