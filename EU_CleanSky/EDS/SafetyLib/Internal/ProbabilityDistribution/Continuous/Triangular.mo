within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous;
model Triangular "Triangular distribution"
  extends ProbabilityDistribution.Icons.Distribution_Triangular2;
  extends ProbabilityDistribution.Interfaces.PartialDistribution(
    final distributionName="Normal",
    final i_distribution=3,
    final nb_parameters=3,
    final parametersName={"a","b","c"},
    parametersValue={-12,12,0},
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
source="modelica://EU/Cleansky/EDS/SafetyLib/Internal/ProbabilityDistribution/Images/TriangularDistribution.png")),
      Documentation(info="<html>
<p>&QUOT;In probability theory and statistics, the triangular distribution is a continuous probability distribution with lower limit a, upper limit b and mode c, where a &LT; b and a &le; c &le; b. The probability density function is given by</p>
<p>if a &LT;= x &LT;= c</p>
<p><ul>
<li><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-8ArmWWGx.png\" alt=\"f(x,a,b,c)=2*(x-a)/((b-a)*(c-a))\"/></li>
</ul></p>
<p>else if c &LT;= x &LT;= b</p>
<p><ul>
<li><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-0WlkR9rE.png\" alt=\"f(x,a,b,c)=2*(b-x)/((b-a)*(b-a))\"/></li>
</ul></p>
<p>else</p>
<p><ul>
<li><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-JJ4fK0QS.png\" alt=\"f(x,a,b,c)=0\"/></li>
</ul></p>
<p>&QUOT;</p>
<p>source : www.wikipedia.org</p>
<p>Cette distribution est born&eacute;e dans l&apos;intervalle [min, max]</p>
</html>", revisions="<html>
<p>2012/03/21 E. Thomas</p>
<p><ul>
<li>Cr&eacute;ation du composant</li>
</ul></p>
</html>"));
end Triangular;
