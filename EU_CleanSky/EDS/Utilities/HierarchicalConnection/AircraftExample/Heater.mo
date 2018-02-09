within EU_CleanSky.EDS.Utilities.HierarchicalConnection.AircraftExample;
model Heater "All the models describing a heater component"
  extends MySubsystem2.HC.Icons.Heater;

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=28)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(pin_p, resistor.p) annotation (Line(
      points={{-100,0},{-10,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pin_n, resistor.n) annotation (Line(
      points={{100,0},{10,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,60},{100,-100}},
          lineColor={0,0,255},
          fillColor={156,166,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-78,40},{80,40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-78,18},{80,18}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-78,-8},{80,-8}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-48,14},{-48,62},{-20,34},{-20,90}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-14,14},{-14,62},{14,34},{14,90}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{20,14},{20,62},{48,34},{48,90}},
          color={255,0,0},
          smooth=Smooth.None)}), Diagram(graphics));
end Heater;
