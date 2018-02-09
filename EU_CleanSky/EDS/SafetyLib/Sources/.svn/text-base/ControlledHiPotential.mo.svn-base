within EU_CleanSky.EDS.SafetyLib.Sources;
model ControlledHiPotential
  "Delivers a high potential when input is true. Configurable to be source or sink."
  extends Internal.PartialLogicFlowSourceOrSink(gender=EU_CleanSky.EDS.SafetyLib.Gender.female);

  Modelica.Blocks.Sources.BooleanExpression falseConstant
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,30})));
  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}}),  iconTransformation(
          extent={{-108,-8},{-92,8}})));
  Modelica.Blocks.Sources.BooleanExpression revExpr(y=(gender == Gender.male))
    annotation (Placement(transformation(extent={{-20,-10},{20,10}},
        rotation=0,
        origin={20,10})));
equation
  /* Normally a sink has p connector and should be a low potential, and since 
     this one is a high potential, it emits reversed flow when sink interface is selected. */
  connect(falseConstant.y, open) annotation (Line(
      points={{41,30},{60,30},{60,50},{100,50}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(falseConstant.y, leak) annotation (Line(
      points={{41,30},{100,30}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(falseConstant.y, ground) annotation (Line(
      points={{41,30},{60,30},{60,-30},{100,-30}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(falseConstant.y, low) annotation (Line(
      points={{41,30},{60,30},{60,-50},{100,-50}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(u, high) annotation (Line(
      points={{-80,0},{0,0},{0,-10},{100,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revExpr.y, rev) annotation (Line(
      points={{42,10},{100,10}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="p",Icon(graphics={Text(
          extent={{-102,100},{102,-102}},
          lineColor={0,0,255},
          textString="+")}),                Diagram(graphics),
    Documentation(info="<html>
<p>Delivers a high potential when boolean input u is true. A flow of power is described by a connection between a high potential and a low potential. The connection should include exactly one load on each possible path, otherwise it is a short-circuit.</p>
<p><br/>When input u is false, this component behaves exactly like a Cap.</p>
</html>"));
end ControlledHiPotential;
