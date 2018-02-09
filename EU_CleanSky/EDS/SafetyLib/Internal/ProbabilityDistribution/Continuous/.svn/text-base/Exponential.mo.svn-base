within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous;
model Exponential "Exponential distribution"
  extends ProbabilityDistribution.Icons.Distribution_Exponential2;

  extends ProbabilityDistribution.Interfaces.PartialDistribution(
    final distributionName="Exponential",
    final i_distribution=5,
    final nb_parameters=1,
    final parametersName={"lambda"},
    parametersValue={0},
    min=0,
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
source="modelica://EU/Cleansky/EDS/SafetyLib/Internal/ProbabilityDistribution/Images/ExponentialDistribution.png")),
      Documentation(info="<html>
<p>&QUOT;In probability theory, the normal (or Gaussian) distribution is a continuous probability distribution that has a bell-shaped probability density function, known as the Gaussian function or informally the bell curve:[nb 1]</p>
<p><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-XPhqCmeR.png\" alt=\"f(x,mu,sigma^2)=1/(sigma*sqrt(2*pi))*e^(-(x-mu)^2/(2*sigma^2))\"/></p>
<p>where parameter <img src=\"modelica://ProbabilityDistribution/Images/equations/equation-HCZfdv8P.png\" alt=\"mu\"/> is the mean or expectation (location of the peak) and  is the variance. &sigma; is known as the standard deviation.</p>
<p>The distribution with <img src=\"modelica://ProbabilityDistribution/Images/equations/equation-K6WEPqtn.png\" alt=\"mu\"/> = 0 and <img src=\"modelica://ProbabilityDistribution/Images/equations/equation-kf1OYOMP.png\" alt=\"sigma^2\"/> = 1 is called the standard normal distribution or the unit normal distribution. A normal distribution is often used as a first approximation to describe real-valued random variables that cluster around a single mean value.&QUOT;</p>
<p>source : www.wikipedia.org</p>
<p>Cette distribution est born&eacute;e dans l&apos;intervalle [min, max]</p>
</html>", revisions="<html>
<p>2012/03/21 E. Thomas</p>
<p><ul>
<li>Cr&eacute;ation du composant</li>
</ul></p>
</html>"));
end Exponential;
