within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example;
model MySubsystem2 "A subsystem with three components."
  extends HierarchicalDCPowerConn.PartialContext(ssType="MySubsystem2");
  Resistor resistor
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Resistor resistor1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Resistor resistor2
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
end MySubsystem2;
