within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn;
model DCPower "Access to global DC power network"
  import EU_CleanSky;
public
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{10,10},{30,30}}), iconTransformation(extent={{
            10,10},{30,30}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn.HierarchicalPin
    posPin annotation (Placement(transformation(extent={{-94,18},{-74,22}})));
  EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn.HierarchicalPin
    negPin(nr=2)
    annotation (Placement(transformation(extent={{-94,-22},{-74,-18}})));
equation
  connect(posPin.pin, pin_p) annotation (Line(
      points={{-74,20},{20,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(negPin.pin, pin_n) annotation (Line(
      points={{-74,-20},{20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{20,100}}), graphics), Icon(coordinateSystem(extent={{-100,
            -100},{20,100}}, preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{20,-100}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-140,-100},{60,-132}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end DCPower;
