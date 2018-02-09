within EU_CleanSky_Test.EDS.SafetyLib;
model TestControlledBooster2
  "Operation with input representing the power needed to make high potential."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.ControlledBooster boost(useInput=true)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential n(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{30,10},{10,30}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Merge split annotation (Placement(transformation(
        extent={{-10.5,15.5},{10.5,-15.5}},
        rotation=90,
        origin={-21.5,19.5})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=(time > 0.25))
    annotation (Placement(transformation(extent={{-86,-20},{-66,0}})));
equation
  connect(split.f, boost.f) annotation (Line(
      points={{-21.5,9},{-21.5,2.5},{-22,2.5},{-22,-3.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.m2, n.f) annotation (Line(
      points={{-9.1,19.5},{-1.61665,19.5},{-1.61665,20},{10,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.minusF, split.m1) annotation (Line(
      points={{-40,40},{-21.5,40},{-21.5,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y, boost.u) annotation (Line(
      points={{-65,-10},{-40,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(boost.nOut, load.plusM) annotation (Line(
      points={{-38,-3.4},{-38,20},{-70,20},{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestControlledBooster2;
