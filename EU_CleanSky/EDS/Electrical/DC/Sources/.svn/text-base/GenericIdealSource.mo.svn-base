within EU_CleanSky.EDS.Electrical.DC.Sources;
model GenericIdealSource
  "A generic DC electrical power source. All electrical power sources are controlled."

  Interfaces.PlugF     plug      annotation (Placement(transformation(extent={{-4,16},
            {4,24}}),      iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.BooleanInput deliverDCPower
    "When true, the supply delivers power." annotation (Placement(
        transformation(
        extent={{19,-19},{-19,19}},
        rotation=180,
        origin={-75,-13}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={0,98})));

  import EU_CleanSky.EDS.SafetyLib;

  SafetyLib.Sources.ControlledPower power(useReverseInterface=true)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
equation
  connect(power.u, deliverDCPower)
                           annotation (Line(
      points={{-10,-13},{-75,-13}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.m, plug.n) annotation (Line(
      points={{-6,-5},{-6,20},{0,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.f, plug.p) annotation (Line(
      points={{6,-5},{6,20},{0,20}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,255,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,-64},{58,-90}},
          lineColor={0,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          textString="DC output"),
        Text(
          extent={{-100,30},{100,-16}},
          lineColor={0,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                         graphics));
end GenericIdealSource;
