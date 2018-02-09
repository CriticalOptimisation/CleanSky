within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Tests;
model test_distribution_01 "test distribution_01"

  BaseClasses.ModelWithDistributions_01 modelWithDistributions_01_1(
    x=2,
    y=3,
    redeclare model X_distribution =
      ProbabilityDistribution.Continuous.Normal (
        parametersValue={2,0.15},
        min=-5,
        max=5),
    redeclare model Y_distribution =
      ProbabilityDistribution.Continuous.LogNormal (
        parametersValue={3,0.1},
        min=-3,
        max=8)) annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

//Layout
    annotation (Placement(transformation(extent={{-40,0},{0,40}})));
end test_distribution_01;
