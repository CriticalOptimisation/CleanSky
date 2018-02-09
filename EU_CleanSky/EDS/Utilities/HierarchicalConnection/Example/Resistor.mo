within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example;
model Resistor "A simple component packaged for structural aggregation."
  extends HierarchicalDCPowerConn.PartialContext(final ssType="Resistor");
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1, useHeatPort=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,0})));
  HierarchicalDCPowerConn.DCPower dCPower
    annotation (Placement(transformation(extent={{-52,-10},{-40,10}})));
equation
  connect(dCPower.pin_p, resistor.p) annotation (Line(
      points={{-40,2},{-20,2},{-20,20},{0,20},{0,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dCPower.pin_n, resistor.n) annotation (Line(
      points={{-40,-2},{-20,-2},{-20,-20},{0,-20},{0,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Resistor;
