within EU_CleanSky.EDS.SafetyLib;
model FailureMode "Data package describing a failure mode."
parameter Boolean initialFailure=false
    "Failed at the beginning of the simulation.";
parameter Real lambda "Failure rate.";
output Modelica.Blocks.Interfaces.BooleanOutput y
   annotation (Placement(transformation(extent={{60,20},{80,40}}),
         iconTransformation(extent={{56,-2},{60,2}})));
   replaceable model Law =
    Internal.ProbabilityDistribution.Continuous.Exponential
    constrainedby
    Internal.ProbabilityDistribution.Interfaces.PartialDistribution
    "Law describes evolution of failure rate lambda." annotation(Dialog(tab="Probability", __Dymola_descriptionLabel=true), choicesAllMatching=true,
    Documentation(info="<html>
<p>The law of probability attached to the &QUOT;loss of power&QUOT; failure mode of the Reverse Controlled Power model. It can be replaced by any law under Internal/ProbabilityDistribution/Continuous.</p>
</html>"));

   Law law(parametersValue =   {lambda});

Boolean click(start=false, fixed=true) annotation(DDE);

equation
  when change(click) then
    y = not pre(y);
  end when;

initial equation
  y=initialFailure;
  click=pre(click);

//interaction={OnMouseDownSetBoolean(click, click<0.5)},
  annotation (Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.3),                                               graphics={
                                       Polygon(
          points={{-60,0},{0,-32},{60,0},{0,32},{-60,0}},
          lineColor={56,93,138},
          smooth=Smooth.None,
          fillColor=DynamicSelect({255,255,255},if (y>0.5) then {255,0,0} else {255,255,255}),
          fillPattern=FillPattern.Solid),                                      Text(
          extent={{-56,-4},{56,4}},
          lineColor={56,93,138},
          textString="%name",
          textStyle={TextStyle.Bold})}), Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.3)),
    Documentation(info="<html>
<p>There are multiple way to use the Failure Mode class. The boolean output of the class must in general be connected through a logic &QUOT;and&QUOT; with a functional link in the logical architecture model. </p>
<p>The output remains true all the time unless the following happens : </p>
<p><ul>
<li>The user interactively clicks on the failure icon during a simulation. It simulates the occurrence of a failure which then propagates through the system.</li>
<li>The user sets the &QUOT;initialFailure&QUOT; parameter to &QUOT;true&QUOT;, and the failure is present when the simulation starts.</li>
</ul></p>
<p><br/>The law of probability is never used by the Modelica simulation. It is intended forfurther analysis tools which extract the model equations to calculate probabilities of occurrence and cut-sets for various high level failure conditions.</p>
</html>"));
end FailureMode;
