within EU_CleanSky_Test.EDS.SafetyLib;
model TestLopot1 "Test of low potential source/sink"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.BooleanConstant leak(k=true)
    annotation (Placement(transformation(extent={{-84,-28},{-64,-8}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link3(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
equation
  connect(sourceP.f, link1.p) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.n, link2.p) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak.y, link2.leak) annotation (Line(
      points={{-63,-18},{-8,-18},{-8,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.n, sink.m) annotation (Line(
      points={{40,40},{50,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link3.p, link2.n) annotation (Line(
      points={{20,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(info="<html>
<p>This test demonstrates the flow orientation indication in link components. This is not a regular case since it is a short circuit from + to -.</p>
<p>Even when the Leak input is true, power flows normally since the source and the sink are not referenced with respect to the ground. There isn&apos;t any power flowing into the ground.</p>
</html>"));
end TestLopot1;
