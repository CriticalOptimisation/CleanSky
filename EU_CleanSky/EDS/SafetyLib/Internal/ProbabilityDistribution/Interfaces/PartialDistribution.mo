within EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Interfaces;
partial model PartialDistribution "Base package of all distribution packages"

//   replaceable type type_parametersValue=Real;

  parameter String distributionName="" "name of the distribution" annotation(Evaluate=true);
  parameter Integer i_distribution=0 "ref distribution"
                                                       annotation(Evaluate=true);
  parameter Integer nb_parameters=0 "number of parameters"
                                                          annotation(Evaluate=true);
  parameter String parametersName[nb_parameters]=fill("",nb_parameters)
    "parameter names"
                     annotation(Evaluate=true);
  parameter Real parametersValue[nb_parameters]=fill(0,nb_parameters)
    "parameter values"
                      annotation(Evaluate=true);
  parameter Real min=-Modelica.Constants.Integer_inf "min value"
                                                                annotation(Evaluate=true);
  parameter Real max=Modelica.Constants.Integer_inf "max value"
                                                               annotation(Evaluate=true);

//   Real parametersValue_temp[nb_parameters]=parametersValue;

protected
  replaceable partial function densityOfProbability
    "Return density of probability as function of temperature"
    input Real x;
    output Real pdf;
  end densityOfProbability;

  replaceable partial function cumulativeDistribution
    "Return cumulative distribution as function of probability x"
    input Real x;
    output Real cdf;
  end cumulativeDistribution;

  replaceable partial function mean "Return mean as function of x"
    input Real x;
    output Real mean;
  end mean;

  replaceable partial function median "Return median as function of x"
    input Real x;
    output Real mean;
  end median;

  replaceable partial function mode "Return mode as function of x"
    input Real x;
    output Real mode;
  end mode;

  replaceable partial function variance "Return variance as function of x"
    input Real x;
    output Real mode;
  end variance;

  replaceable partial function skewness "Return skewness as function of x"
    input Real x;
    output Real skewness;
  end skewness;

  replaceable partial function kurtosis "Return skewness as function of x"
    input Real x;
    output Real kurtosis;
  end kurtosis;

  replaceable partial function entropy "Return skewness as function of x"
    input Real x;
    output Real entropy;
  end entropy;

  replaceable partial function mgf
    "Return fonction génératrice des moments as function of x"
    input Real x;
    output Real mgf;
  end mgf;

  replaceable partial function cf
    "Return fonction caractéristique as function of x"
    input Real x;
    output Real cf;
  end cf;

  replaceable partial function fisherMatrix
    "Return fonction caractéristique as function of x"
    input Real x;
    output Real fisherMatrix[:,:];
  end fisherMatrix;
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Text(
          extent={{-130,-105},{26,-117}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          fontSize=13,
          fontName="Arial",
          textString="min=%min%"), Text(
          extent={{-22,-94},{144,-128}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          fontSize=13,
          fontName="Arial",
          textString="max=%max%")}));
end PartialDistribution;
