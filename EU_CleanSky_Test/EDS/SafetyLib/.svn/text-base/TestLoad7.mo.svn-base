within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad7 "Test of dipole with hydraulic leak above the load."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Link link2(
    useOpen=false,
    useLeak=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sourceP
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.BooleanConstant leakSrc(k=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sink
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(leakSrc.y, link2.leak) annotation (Line(
      points={{-59,0},{-48,0},{-48,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, link2.m) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link2.f, load.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.f, sink.m) annotation (Line(
      points={{0,40},{10,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=0.5, NumberOfIntervals=1),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>A leak in &QUOT;link2&QUOT; lets the fluid leave the circuit and therefore prevents the load from operating. The high potential is not propagated across an fluid leak.</p>
<p>While hydraulic leaks are not always severe enough to perturbate the pressures up to a point where the systems become inoperative, it made sense in this library to consider only the leaks severe enough to perturbate operation. Limited leaks can be included in components and would only take advantage of the space allocation model to simulate the injection of fluid in various aircraft zones. The model may implement fluid tank low level conditions if a leak remains uncontrolled for a while.</p>
<p>The condition for a load to be correctly powered from a power system are:</p>
<p><ul>
<li>It must receive a low signal on its - side and a high signal on its + side.</li>
<li>It must not receive a ground signal on both N and P.</li>
<li>It must not be traversed by an &QUOT;open&QUOT; signal in both directions, since that indicates a blocked flow / open circuit.</li>
</ul></p>
</html>"));
end TestLoad7;
