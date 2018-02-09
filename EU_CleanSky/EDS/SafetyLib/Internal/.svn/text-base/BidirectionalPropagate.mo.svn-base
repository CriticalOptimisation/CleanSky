within EU_CleanSky.EDS.SafetyLib.Internal;
model BidirectionalPropagate
  "Propagates a logic true on the local input to the P and N sides, otherwise propagates P to N and N to P."
  extends PartialLogicPairDipole;

  Modelica.Blocks.Logical.Or propagateM
    annotation (HideResult=true,Placement(transformation(extent={{-60,-42},{-80,
            -22}})));
  Modelica.Blocks.Logical.Or propagateF
    annotation (HideResult=true,Placement(transformation(extent={{60,-42},{80,-22}})));

equation
  if useInput==false then
     propagateM.u2=false;
     propagateF.u2=false;
  end if;
  connect(u,propagateM. u2) annotation (Line(
      points={{0,-100},{0,-40},{-58,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(u,propagateF. u2) annotation (Line(
      points={{0,-100},{0,-40},{58,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateF.y, f.FtoM) annotation (Line(
      points={{81,-32},{90,-32},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateF.u1, m.FtoM) annotation (Line(
      points={{58,-32},{0,-32},{0,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateM.y, m.MtoF) annotation (Line(
      points={{-81,-32},{-90,-32},{-90,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateM.u1, f.MtoF) annotation (Line(
      points={{-58,-32},{-42,-32},{-42,-24},{8,-24},{8,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));

  annotation(defaultComponentName="biProp", Icon(graphics={
        Polygon(
          points={{-78,14},{70,14},{70,18},{78,12},{70,6},{70,10},{-78,10},{-78,
              14}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{78,-10},{-70,-10},{-70,-6},{-78,-12},{-70,-18},{-70,-14},{78,
              -14},{78,-10}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics));
end BidirectionalPropagate;
