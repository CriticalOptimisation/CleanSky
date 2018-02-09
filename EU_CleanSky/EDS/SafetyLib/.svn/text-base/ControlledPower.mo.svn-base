within EU_CleanSky.EDS.SafetyLib;
model ControlledPower
  "A controlled power source emitting high and low potentials when boolean input is true."
  parameter Modelica.Blocks.Interfaces.BooleanOutput initialState=false
    "If true, function is failed at T=0";
  parameter Real lambda=0.1 "Loss of function probability (per hour)";
  replaceable model Law =
      Internal.ProbabilityDistribution.Continuous.Exponential
    "Failure probability law";

  Interfaces.LogicFlowM f annotation (Placement(transformation(extent={{78,40},{
            82,44}}), iconTransformation(extent={{74,60},{86,72}})));
  Interfaces.LogicFlowF m annotation (Placement(transformation(extent={{-82,40},
            {-78,44}}), iconTransformation(extent={{-86,60},{-74,72}})));
  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(extent={{-108,-28},{-92,-12}}),
                                                     iconTransformation(extent={{-108,-8},
            {-92,8}})));
protected
  Sources.ControlledHiPotential p1
    annotation (Placement(transformation(extent={{-30,10},{-50,30}})));
  Sources.ControlledLoPotential n1
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-24,-24},{-16,-16}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-44,-44},{-36,-36}})));
  FailureMode loss(initialFailure=initialState, redeclare model Law = Law,
    lambda=lambda)
    annotation (Placement(transformation(extent={{-72,-52},{-48,-28}})));
equation
  connect(and1.y, n1.u) annotation (Line(
      points={{-15.6,-20},{0,-20},{0,20},{30,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, p1.u) annotation (Line(
      points={{-15.6,-20},{0,-20},{0,20},{-30,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.u1, u) annotation (Line(
      points={{-24.8,-20},{-100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, and1.u2) annotation (Line(
      points={{-35.6,-40},{-30,-40},{-30,-23.2},{-24.8,-23.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(loss.y, not1.u) annotation (Line(
      points={{-53.04,-40},{-44.8,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p1.f,m)  annotation (Line(
      points={{-50,20},{-80,20},{-80,42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(n1.m,f)  annotation (Line(
      points={{50,20},{80,20},{80,42}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="power",Icon(graphics={Rectangle(
          extent={{-100,60},{100,-100}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}), Text(
          extent={{-100,8},{100,-54}},
          lineColor={0,0,255},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-112,68},{-48,26}},
          lineColor={0,0,255},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="+"),
        Rectangle(
          extent={{72,50},{88,46}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}),
                                          graphics),
    Documentation(info="<html>
<p>This component represents a function which provides power to a circuit. It is intended for embedding in the model of a power source or power transformer. When the input is true, both potentials are emitted, and when it is false, none are emitted and the function behaves like a pair of caps.</p>
<p>The only failure modes associated with this function is the loss of the function. Since this function delivers power and there is only one input, the input represents the availability of suitable power. When the input is false, an untimely operation is therefore impossible.</p>
</html>"));
end ControlledPower;
