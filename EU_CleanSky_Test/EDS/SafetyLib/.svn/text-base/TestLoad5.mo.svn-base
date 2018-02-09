within EU_CleanSky_Test.EDS.SafetyLib;
model TestLoad5 "Check diode behaviour of polarized loads."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load1(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=false,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential sourceP(gender=EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sink(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load2(
    useLeak=false,
    useOpen=false,
    final useReverseInterface=true,
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(load2.f, sink.m) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load2.m, load1.f) annotation (Line(
      points={{-20,40},{-40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceP.f, load1.m) annotation (Line(
      points={{-70,40},{-60,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=2),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>When two loads with reverse polarity are connected in series, nothing works since &QUOT;load1&QUOT; gets reverse polarity and blocks the flow of power in the circuit (like a diode would). To let this system work, we would need a diode in reverse parallel with each load.</p>
</html>"));
end TestLoad5;
