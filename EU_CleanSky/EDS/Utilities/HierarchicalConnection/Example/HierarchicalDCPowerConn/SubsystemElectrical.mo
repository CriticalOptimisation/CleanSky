within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn;
model SubsystemElectrical
  "A Subsystem specialised for electrical subsystems, showing total current."
  extends HierarchicalDCPowerConn.PartialSubsystem(nSensors=1, signal1Name=
        "Total current");
  CurrentSensingElement currentSensingElement
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
equation
  connect(currentSensingElement.i1, signal1.numberPort) annotation (Line(
      points={{-69.2,40},{78.5,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(currentSensingElement.hierarchy, hierarchy) annotation (Line(
      points={{-80,50},{-80,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(currentSensingElement.internal, internal) annotation (Line(
      points={{-80,30},{-80,-100}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SubsystemElectrical;
