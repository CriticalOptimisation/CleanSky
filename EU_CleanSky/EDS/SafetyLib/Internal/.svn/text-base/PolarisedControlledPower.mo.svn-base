within EU_CleanSky.EDS.SafetyLib.Internal;
model PolarisedControlledPower
  "A controlled power source emitting high and low potentials when boolean input is true."
  extends PartialNonLeakyDipole;
  parameter Modelica.Blocks.Interfaces.BooleanOutput initialState=false
    "If true, function is failed at T=0";
  parameter Real lambda=0.1 "Loss of function probability (per hour)";
   replaceable model Law =
       Internal.ProbabilityDistribution.Continuous.Exponential
    "Failure probability law"  annotation (Documentation(info="<html>
 <p>The law of probability attached to the &QUOT;loss of power&QUOT; failure mode of the Controlled Power model. It can be replaced by any law under Internal/ProbabilityDistribution/Continuous.</p>
 </html>"));

  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(extent={{-108,-28},{-92,-12}}),
                                                     iconTransformation(extent={{-8,-8},
            {8,8}},
        rotation=90,
        origin={-60,-40})));
protected
  Sources.ControlledHiPotential p1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Sources.ControlledLoPotential n1
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-24,-24},{-16,-16}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-44,-44},{-36,-36}})));
  FailureMode loss(initialFailure=initialState, redeclare model Law = Law,
    lambda=lambda)
    annotation (Placement(transformation(extent={{-72,-52},{-48,-28}})));
equation
  connect(and1.y, n1.u) annotation (Line(
      points={{-15.6,-20},{0,-20},{0,0},{-40,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, p1.u) annotation (Line(
      points={{-15.6,-20},{0,-20},{0,0},{40,0}},
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
  connect(p1.f, f) annotation (Line(
      points={{60,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m, n1.m) annotation (Line(
      points={{-100,0},{-60,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="power",Icon(graphics={
        Polygon(visible=showPolarity,
          points={{-88,2},{-80,2},{-80,2},{-76,2},{-76,2},{-68,2},{-68,-2},{-76,
              -2},{-76,-2},{-80,-2},{-80,-2},{-88,-2},{-88,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=(showPolarity and not useReverseInterface),
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={80,0},
          rotation=90),
        Polygon(visible=showPolarity,
          points={{70,2},{78,2},{78,2},{82,2},{82,2},{90,2},{90,-2},{82,-2},{82,
              -2},{78,-2},{78,-2},{70,-2},{70,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
                                  Diagram(graphics),
    Documentation(info="<html>
<p>This component represents a function which provides power to a circuit. It is intended for embedding in the model of a power source or power transformer. When the input is true, both potentials are emitted, and when it is false, none are emitted and the function behaves like a pair of caps.</p>
<p>The only failure modes associated with this function is the loss of the function. Since this function delivers power and there is only one input, the input represents the availability of suitable power. When the input is false, an untimely operation is therefore impossible.</p>
</html>"));
end PolarisedControlledPower;
