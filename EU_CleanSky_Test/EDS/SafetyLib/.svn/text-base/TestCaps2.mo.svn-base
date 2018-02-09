within EU_CleanSky_Test.EDS.SafetyLib;
model TestCaps2 "Check end caps behaviour, with two end caps"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-84,-28},{-64,-8}})));
  EU_CleanSky.EDS.SafetyLib.Cap logicFlowPosCap(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
  EU_CleanSky.EDS.SafetyLib.Cap logicFlowNCap(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-63,-18},{-8,-18},{-8,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, logicFlowNCap.m) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(logicFlowPosCap.f, link1.m) annotation (Line(
      points={{-80,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, link2.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestCaps2;
