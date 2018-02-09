within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example;
model MySystem "The whole system made of two MySS2 and one MySS1"
  extends HierarchicalDCPowerConn.PartialContext(ssType="MySystem");
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=1)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-40,-10})));
  HierarchicalDCPowerConn.SubsystemElectrical subsystem1(redeclare MySubsystem2
      content, ssType="MySubsystem2")
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  HierarchicalDCPowerConn.SubsystemElectrical subsystem2(redeclare MySubsystem1
      content, ssType="MySubsystem1")
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  HierarchicalDCPowerConn.SubsystemElectrical subsystem3(redeclare MySubsystem2
      content, ssType="MySubsystem2")
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  HierarchicalDCPowerConn.DCPower dCPower
    annotation (Placement(transformation(extent={{-80,-20},{-68,0}})));
equation
  connect(dCPower.pin_p, constantVoltage.p) annotation (Line(
      points={{-68,-8},{-60,-8},{-60,0},{-40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dCPower.pin_n, constantVoltage.n) annotation (Line(
      points={{-68,-12},{-60,-12},{-60,-20},{-40,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end MySystem;
