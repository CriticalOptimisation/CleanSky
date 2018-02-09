within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad2 "Test of dipole circuits N°3"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-59,0},{32,0},{32,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, load.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.f, link2.m) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, sink.m) annotation (Line(
      points={{40,40},{50,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=2),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The leak in &QUOT;link2&QUOT; only indicates that - is connected to the ground, and has no effect on the operation of the load.</p>
</html>"));
end TestLoad2;
