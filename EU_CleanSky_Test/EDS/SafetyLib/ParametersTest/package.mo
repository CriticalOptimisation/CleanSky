within EU_CleanSky_Test.EDS.SafetyLib;
package ParametersTest "Contains tests which are passed when a Check is successful."


annotation (Documentation(info="<html>
<p>The basic Check operation in Dymola does a number of verification with only one set of parameter values. Default values are used if provided, or assumed to be zero/false when left unspecified. Since parameters can be used to make some components conditional, and therefore affect model structure, including the number of variables and equations. For balanced models a successful check without warnings is the expected result. Partial models can be checked with the addition of equations making them complete.</p>
</html>"));
end ParametersTest;
