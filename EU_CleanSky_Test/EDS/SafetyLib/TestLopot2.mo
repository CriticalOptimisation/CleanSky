within EU_CleanSky_Test.EDS.SafetyLib;
model TestLopot2
  "Test low potential source/sink in reverse flow. Fluid color scheme."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.fluid)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(
    useOpen=false,
    useLeak=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.fluid)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sourceN(semantics=EU_CleanSky.EDS.SafetyLib.Semantics.fluid,
      gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sinkP(semantics=EU_CleanSky.EDS.SafetyLib.Semantics.fluid,
      gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
equation
  connect(link1.n, link2.p) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceN.f, link1.p) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sinkP.m, link2.n) annotation (Line(
      points={{10,40},{0,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(info="<html>
<p>This example should show green flow arrows in the link components pointing toward the left (to the source, which is the negative potential in this test).</p>
</html>"));
end TestLopot2;
