within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example;
model MySubsystem1 "A subsystem with two components and a nested subsystem."
  extends HierarchicalDCPowerConn.PartialContext(ssType="MySubsystem1");
  Resistor resistor
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Resistor resistor1
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  HierarchicalDCPowerConn.SubsystemElectrical mySubsystem2(redeclare
      MySubsystem2 content)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end MySubsystem1;
