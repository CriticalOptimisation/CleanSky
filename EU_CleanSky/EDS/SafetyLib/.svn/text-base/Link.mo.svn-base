within EU_CleanSky.EDS.SafetyLib;
model Link "Main object is to carry power, not to consume it."
  extends Internal.PartialLeakyDipole(useLeak=false, useOpen=false);
protected
  Internal.BidirectionalPropagate biProp4(
    useStatus=false,
    useInput=false,
    varname="low")
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Internal.ConditionalPropagate condProp1(
    useStatus=false,
    varname="high",
    useInput=true)
    annotation (Placement(transformation(extent={{40,-10},{60,-30}})));
  Modelica.Blocks.Sources.BooleanExpression expr
    annotation (Placement(transformation(extent={{16,0},{36,20}})));
  Modelica.Blocks.Sources.BooleanExpression fluidLeak(y=semantics ==
        Semantics.fluid)
    annotation (Placement(transformation(extent={{-54,54},{2,34}})));
  Modelica.Blocks.Logical.Nand nand2
                                   annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={20,44})));
equation
  if not useLeak then
    nand2.u2 = false;
  end if;
  connect(biProp4.f, lowF) annotation (Line(
      points={{10,-100},{80,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp4.m, lowM) annotation (Line(
      points={{-10,-100},{-80,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(condProp1.f, highF)
                            annotation (Line(
      points={{60,-20},{80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(condProp1.m, highM)
                            annotation (Line(
      points={{40,-20},{-80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(expr.y, or1.u1) annotation (Line(
      points={{37,10},{40,10},{40,24.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(expr.y, condProp1.u) annotation (Line(
      points={{37,10},{50,10},{50,-13.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(fluidLeak.y, nand2.u1)          annotation (Line(
      points={{4.8,44},{12.8,44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak, nand2.u2) annotation (Line(
      points={{-87,49},{-36.6,49},{-36.6,48.8},{12.8,48.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(nand2.y, condProp1.propToF) annotation (Line(
      points={{26.6,44},{56,44},{56,-13.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(nand2.y, condProp1.propToM) annotation (Line(
      points={{26.6,44},{56,44},{56,0},{44,0},{44,-13.6}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end Link;
