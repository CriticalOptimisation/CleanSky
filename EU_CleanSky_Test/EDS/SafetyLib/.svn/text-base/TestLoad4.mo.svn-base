within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad4 "Test of dipole circuits N°3"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link1(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link2(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sink(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useLeak=false,
    useOpen=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    final useReverseInterface=true)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-59,0},{32,0},{32,36}},
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
  connect(sourceP.f, link1.m) annotation (Line(
      points={{-70,40},{-60,40}},
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
<p>The example shows a reverse polarised load (- on the left side, + on the right side), inserted in a reverse flow circuit (positive potential on the right). Power flows from right to left. Models can be built with arbitrary power flow orientations. The hollow and pink connectors named p and n on each component are necessary because there is an output and an input for each pair of signals, and these need to be reversed to allow connection. Modelica connects signals by name in a structured connector, and needs to find the output matching each input.</p>
<p>The leak in &QUOT;link2&QUOT; has no effect, since the leak only gives a ground reference to the circuit, without drawing any power.</p>
</html>"));
end TestLoad4;
