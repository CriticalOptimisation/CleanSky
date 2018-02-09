within EU_CleanSky.EDS.SafetyLib.Internal;
model BlockUpstream
  "Prevents a logic true entering downstream from propagating upstream"
  extends PartialLogicPairDipole;

  Modelica.Blocks.Interfaces.BooleanInput reversed
    "Flow is reversed (goes from N to P)."
  annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-26,-100}),                          iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-64})));
  Modelica.Blocks.Logical.Or propagateP
    annotation (HideResult=true,Placement(transformation(extent={{-54,14},{-66,26}})));
  Modelica.Blocks.Logical.Or propagateN
    annotation (HideResult=true,Placement(transformation(extent={{54,-26},{66,-14}})));

  Modelica.Blocks.Logical.And andP
    annotation (HideResult=true,Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={-40,-20})));

  Modelica.Blocks.Logical.And andN
    annotation (HideResult=true,Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={40,-40})));

  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-86,-66},{-74,-54}})));
  Modelica.Blocks.Logical.And and1
                                 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-20,-20})));
  Modelica.Blocks.Logical.And and2
                                 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={20,-40})));
equation
/* conditional connections */
  connect(local_u, andP.u1);
  connect(local_u, andN.u1);
/* permanent connections */
  connect(propagateP.y, m.MtoF) annotation (Line(
      points={{-66.6,20},{-86,20},{-86,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(propagateN.y, f.FtoM) annotation (Line(
      points={{66.6,-20},{80,-20},{80,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateP.u2, andP.y)
                                annotation (Line(
      points={{-52.8,15.2},{-40,15.2},{-40,-13.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andN.y, propagateN.u2)
                                annotation (Line(
      points={{40,-33.4},{40,-24.8},{52.8,-24.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y,and2. u2)
                          annotation (Line(
      points={{-73.4,-60},{15.2,-60},{15.2,-47.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(reversed, and1.u2) annotation (Line(
      points={{-26,-100},{-26,-70},{-24.8,-70},{-24.8,-27.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and2.y, propagateN.u1) annotation (Line(
      points={{20,-33.4},{20,-20},{52.8,-20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and1.y, propagateP.u1) annotation (Line(
      points={{-20,-13.4},{-20,20},{-52.8,20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(reversed, not1.u) annotation (Line(
      points={{-26,-100},{-26,-70},{-92,-70},{-92,-60},{-87.2,-60}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(not1.y, andP.u2) annotation (Line(
      points={{-73.4,-60},{-44.8,-60},{-44.8,-27.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(reversed, andN.u2) annotation (Line(
      points={{-26,-100},{-26,-70},{35.2,-70},{35.2,-47.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(u, andN.u1) annotation (Line(
      points={{0,-100},{0,-76},{40,-76},{40,-47.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and2.u1, m.FtoM) annotation (Line(
      points={{20,-47.2},{20,-66},{-60,-66},{-60,-20},{-86,-20},{-86,0},{-100,0}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));

  connect(u, andP.u1) annotation (Line(
      points={{0,-100},{0,-54},{-40,-54},{-40,-27.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and1.u1, f.MtoF) annotation (Line(
      points={{-20,-27.2},{-20,-40},{10,-40},{10,0},{100,0}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (defaultComponentName="blkUp",Icon(graphics={
        Polygon(
          points={{-78,12},{70,12},{70,16},{78,10},{70,4},{70,8},{-78,8},{-78,12}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{78,-8},{-70,-8},{-70,-4},{-78,-10},{-70,-16},{-70,-12},{78,-12},
              {78,-8}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),Rectangle(
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
          extent={{8,-6},{16,-14}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{26,-6},{34,-14}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{44,-8},{52,-16}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                             Rectangle(
          extent={{62,-6},{70,-14}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{66,-58},{108,-78}},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          lineColor={255,0,255},
          textString="Rev"),
        Rectangle(
          extent={{-20,2},{20,-2}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={2,-10},
          rotation=-45),
        Rectangle(
          extent={{-20,2},{20,-2}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={2,-10},
          rotation=45)}),           Diagram(graphics),
    Documentation(info="<html>
<p>Stream orientation is set by &QUOT;reversed&QUOT; input. The convention is that stream goes from P to N internally is &QUOT;reversed&QUOT; is false, from N to P otherwise. The status which is not propagated is replaced by optional input u, whose default value is false.</p>
</html>"));
end BlockUpstream;
