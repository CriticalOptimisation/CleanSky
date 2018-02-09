within EU_CleanSky_Test.EDS.SafetyLib;
model TestFailureMode2
  "Test that failure mode delivers false without interaction but with initial failure."
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.FailureMode failureMode(
    redeclare model Law = ProbabilityDistribution.Continuous.Exponential,
    lambda=0,
    initialFailure=true)
    annotation (Placement(transformation(extent={{-30,-10},{30,50}})));
  Modelica.Blocks.Interaction.Show.BooleanValue booleanValue
    annotation (Placement(transformation(extent={{36,10},{56,30}})));
equation
  connect(failureMode.y, booleanValue.activePort) annotation (Line(
      points={{17.4,20},{34.5,20}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=200),
    __Dymola_experimentSetupOutput);
end TestFailureMode2;
