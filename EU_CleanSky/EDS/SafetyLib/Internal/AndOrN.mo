within EU_CleanSky.EDS.SafetyLib.Internal;
model AndOrN "Logical combination: y = (pre(input) and u2) or u3"
  extends Modelica.Blocks.Interfaces.partialBooleanBlockIcon;
         Modelica.Blocks.Interfaces.BooleanInput u3
    "Connector of second Boolean input signal"
                                           annotation (Placement(
        transformation(extent={{-140,60},{-100,100}},   rotation=0),
        iconTransformation(extent={{-140,54},{-100,94}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-32,0})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-10,-70},{10,-90}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{50,10},{70,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput u2 annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-140,-94},{-100,-54}})));
  LogicPairF f annotation (Placement(transformation(extent={{108,-8},{92,8}}),
        iconTransformation(extent={{132,-34},{68,30}})));
equation

  connect(u2, and1.u1) annotation (Line(
      points={{-120,-80},{-12,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre1.y, and1.u2) annotation (Line(
      points={{-32,-11},{-32,-72},{-12,-72}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, or1.u1) annotation (Line(
      points={{11,-80},{30,-80},{30,0},{48,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(u3, or1.u2) annotation (Line(
      points={{-120,80},{30,80},{30,8},{48,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.y, f.FtoM) annotation (Line(
      points={{71,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre1.u, f.MtoF) annotation (Line(
      points={{-32,12},{-32,60},{80,60},{80,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="andor",
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-122,116},{58,36}},
          lineColor={0,0,0},
          textString="or"),        Text(
          extent={{-96,-22},{84,-102}},
          lineColor={0,0,0},
          textString="and")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}),
                                    graphics),
    Documentation(info="<html>
<p>See diagram.</p>
<p>This operator is frequently used in Split and Merge blocks. It is factorized here for lisibility.</p>
</html>"));
end AndOrN;
