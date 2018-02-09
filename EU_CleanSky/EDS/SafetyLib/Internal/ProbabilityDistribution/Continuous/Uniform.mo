within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous;
model Uniform "Uniform distribution"
  extends ProbabilityDistribution.Icons.Distribution_Uniform2;
  extends ProbabilityDistribution.Interfaces.PartialDistribution(
    final distributionName="Normal",
    final i_distribution=4,
    final nb_parameters=0,
    final parametersName=fill("", nb_parameters),
    final parametersValue=fill(0, nb_parameters),
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
source="modelica://EU/Cleansky/EDS/SafetyLib/Internal/ProbabilityDistribution/Images/UniformDistribution.png")),
      Documentation(info="<html>
<p>&QUOT;In probability theory and statistics, the continuous uniform distribution or rectangular distribution is a family of probability distributions such that for each member of the family, all intervals of the same length on the distribution&apos;s support are equally probable.</p>
<p>if a &LT;= x &LT;= b</p>
<p><ul>
<li><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-vfk43YA0.png\" alt=\"f(x)=1/(b-a)\"/></li>
</ul></p>
<p>sinon</p>
<p><ul>
<li><img src=\"modelica://ProbabilityDistribution/Images/equations/equation-ZoISfUyn.png\" alt=\"f(x)=0\"/></li>
</ul></p>
<p>The support is defined by the two parameters, a and b, which are its minimum and maximum values. The distribution is often abbreviated U(a,b). It is the maximum entropy probability distribution for a random variate X under no constraint other than that it is contained in the distribution&apos;s support.&QUOT;</p>
<p>source : www.wikipedia.org</p>
<p>Cette distribution est born&eacute;e dans l&apos;intervalle [min, max]</p>
</html>", revisions="<html>
<p>2012/03/21 E. Thomas</p>
<p><ul>
<li>Cr&eacute;ation du composant</li>
</ul></p>
</html>"));
end Uniform;
