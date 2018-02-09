within EU_CleanSky.EDS.SafetyLib.Internal;
model SelectivePropagate
  "Bidirectional propagation with selective propagation of local inputs"
  extends PartialLogicPairDipole;

  Modelica.Blocks.Interfaces.BooleanInput propToM if useInput==true
  annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-100}),                          iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-64})));
  Modelica.Blocks.Interfaces.BooleanInput propToF if useInput==true
  annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-30,-100}),                          iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-64})));
  Modelica.Blocks.Logical.Or propagateM
    annotation (HideResult=true,Placement(transformation(extent={{-40,10},{-60,30}})));
  Modelica.Blocks.Logical.Or propagateF
    annotation (HideResult=true,Placement(transformation(extent={{40,10},{60,30}})));
  constant Modelica.Blocks.Interfaces.BooleanInput localPropToM=false if useInput==false;
  constant Modelica.Blocks.Interfaces.BooleanInput localPropToF=false if useInput==false;

  Modelica.Blocks.Logical.Or orM
    annotation (HideResult=true,Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-50,-30})));

  Modelica.Blocks.Logical.Or orF
    annotation (HideResult=true,Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={50,-30})));

equation
/* conditional connections */
  connect(localPropToM,orM. u2);
  connect(localPropToF,orF. u2);
  connect(local_u,orM. u1);
  connect(local_u,orF. u1);
  connect(u,orM. u1) annotation (Line(
      points={{0,-100},{0,-60},{-50,-60},{-50,-42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propToM,orM. u2) annotation (Line(
      points={{-60,-100},{-60,-60},{-58,-60},{-58,-42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(u,orF. u1) annotation (Line(
      points={{0,-100},{0,-60},{50,-60},{50,-42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propToF,orF. u2) annotation (Line(
      points={{-30,-100},{-30,-52},{42,-52},{42,-42}},
      color={255,0,255},
      smooth=Smooth.None));
/* permanent connections */
  connect(propagateM.y, m.MtoF) annotation (Line(
      points={{-61,20},{-86,20},{-86,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateF.u1, m.FtoM) annotation (Line(
      points={{38,20},{20,20},{20,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(propagateF.y, f.FtoM) annotation (Line(
      points={{61,20},{80,20},{80,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateM.u2,orM. y) annotation (Line(
      points={{-38,12},{-30,12},{-30,-10},{-50,-10},{-50,-19}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(orF.y,propagateF. u2) annotation (Line(
      points={{50,-19},{50,-10},{30,-10},{30,12},{38,12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.MtoF,propagateM. u1) annotation (Line(
      points={{100,0},{80,0},{80,-6},{-20,-6},{-20,20},{-38,20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (defaultComponentName="selProp",Icon(graphics={
        Polygon(
          points={{-78,8},{70,8},{70,12},{78,6},{70,0},{70,4},{-78,4},{-78,8}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{78,-6},{-70,-6},{-70,-2},{-78,-8},{-70,-14},{-70,-10},{78,-10},
              {78,-6}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{-64,-4},{-56,-12}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{-46,-4},{-38,-12}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{-28,-4},{-20,-12}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{-10,-6},{-2,-14}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{8,-2},{16,-10}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{26,-2},{34,-10}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{44,-4},{52,-12}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{62,-2},{70,-10}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-82,-58},{-66,-74}},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          lineColor={255,0,255},
          textString="P"),
        Text(
          extent={{66,-58},{82,-74}},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          lineColor={255,0,255},
          textString="N")}),        Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                            graphics),
    Documentation(info="<html>
<p>The component propagates logic input on N side to output on P side and vice-versa.</p>
<p>The component has three inputs. Input u is propagated to N and P side if it is true. Input propToP is propagated to the P side only when true, and input propToN is propagated to the N side only when true.</p>
</html>"));
end SelectivePropagate;
