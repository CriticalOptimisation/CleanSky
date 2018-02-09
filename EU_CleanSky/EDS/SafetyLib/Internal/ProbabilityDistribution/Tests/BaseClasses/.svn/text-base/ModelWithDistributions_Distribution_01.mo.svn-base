within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Tests.BaseClasses;
model ModelWithDistributions_Distribution_01
  "probability distributions for model ModelWithDistributions"

  // Distributions
  replaceable model X_distribution =
    ProbabilityDistribution.Continuous.Normal constrainedby
    ProbabilityDistribution.Interfaces.PartialDistribution "distribution of x"
                        annotation(Dialog(tab="Probability", __Dymola_descriptionLabel=true), choicesAllMatching=true);

   X_distribution x_distribution;

  replaceable model Y_distribution =
    ProbabilityDistribution.Continuous.Normal constrainedby
    ProbabilityDistribution.Interfaces.PartialDistribution "distribution of y"
                        annotation(Dialog(tab="Probability", __Dymola_descriptionLabel=true), choicesAllMatching=true);

   Y_distribution y_distribution;

  annotation (Icon(graphics));
end ModelWithDistributions_Distribution_01;
