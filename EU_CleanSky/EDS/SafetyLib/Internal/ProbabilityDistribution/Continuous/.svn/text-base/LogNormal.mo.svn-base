within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous;
model LogNormal "LogNormal distribution"
  extends ProbabilityDistribution.Icons.Distribution_LogNormal2;

  extends ProbabilityDistribution.Interfaces.PartialDistribution(
    final distributionName="Normal",
    final i_distribution=2,
    final nb_parameters=2,
    final parametersName={"mu","sigma"},
    parametersValue={0,0.1},
    min=-10,
    max=10);

  redeclare function extends densityOfProbability
    "Return density of probability as function of temperature"
      input Real x;
      output Real pdf;
  end densityOfProbability;

  redeclare function extends cumulativeDistribution
    "Return cumulative distribution as function of probability x"
    input Real x;
    output Real cdf;
  end cumulativeDistribution;

  redeclare function extends mean "Return mean as function of x"
    input Real x;
    output Real mean;
  end mean;

  redeclare function extends median "Return median as function of x"
    input Real x;
    output Real mean;
  end median;

  redeclare function extends mode "Return mode as function of x"
    input Real x;
    output Real mode;
  end mode;

  redeclare function extends variance "Return variance as function of x"
    input Real x;
    output Real mode;
  end variance;

  redeclare function extends skewness "Return skewness as function of x"
    input Real x;
    output Real skewness;
  end skewness;

  redeclare function extends kurtosis "Return skewness as function of x"
    input Real x;
    output Real kurtosis;
  end kurtosis;

  redeclare function extends entropy "Return skewness as function of x"
    input Real x;
    output Real entropy;
  end entropy;

  redeclare function extends mgf
    "Return fonction génératrice des moments as function of x"
    input Real x;
    output Real mgf;
  end mgf;

  redeclare function extends cf
    "Return fonction caractéristique as function of x"
    input Real x;
    output Real cf;
  end cf;

  redeclare function extends fisherMatrix
    "Return fonction caractéristique as function of x"
    input Real x;
    output Real fisherMatrix[:,:];
  end fisherMatrix;

annotation (__Dymola_Images(Parameters(group="Picture",
source="modelica://EU/Cleansky/EDS/SafetyLib/Internal/ProbabilityDistribution/Images/LogNormalDistribution.png")),
      Documentation(info="<html>
<p>&QUOT;In probability theory, a log-normal distribution is a continuous probability distribution of a random variable whose logarithm is normally distributed.</p>
<p><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-D0D4pHbh.png\" alt=\"f_X(x,mu,sigma^2)=1/(x*sigma*sqrt(2*pi))*e^(-(ln(x)-mu)^2/(2*sigma^2))\"/></p>
<p>If X is a random variable with a normal distribution, then Y = exp(X) has a log-normal distribution; likewise, if Y is log-normally distributed, then X = log(Y) is normally distributed. (This is true regardless of the base of the logarithmic function: if loga(Y) is normally distributed, then so is logb(Y), for any two positive numbers a, b &ne; 1.)&QUOT;</p>
<p>source : www.wikipedia.org</p>
<p>Cette distribution est born&eacute;e dans l&apos;intervalle [min, max]</p>
</html>", revisions="<html>
<p>2012/03/21 E. Thomas</p>
<p><ul>
<li>Cr&eacute;ation du composant</li>
</ul></p>
</html>"));
end LogNormal;
