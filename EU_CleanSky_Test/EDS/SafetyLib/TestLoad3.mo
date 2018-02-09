within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad3
  "Test of dipole circuits N°4. Two loads in series between high and low potentials, do not work."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load2(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link1.f, load.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.f, load2.m) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load2.f, sink.m) annotation (Line(
      points={{40,40},{50,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=2),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Two loads in a sequence do not receive the expected potentials. In practice, they might work with reduced performance, or behave erratically. In this library, a load which does not receive proper high and low potentials does not work.</p>
</html>"));
end TestLoad3;
