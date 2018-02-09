within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn;
model HierarchicalPin "Electrical pin proxy"
  import EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
  extends HierarchicalDCPowerConn.Icons.InputOutputProxy;
protected
  outer HierarchicalConnector hierarchy
    "All the models and levels of the model hierarchy, up to System model are connected by this connector."
    annotation (Placement(transformation(extent={{-96,-14},{-70,14}}),
        iconTransformation(extent={{-100,80},{-80,100}})), missingInnerMessage=
        "This class must only be extended from to create component models.\nPopulate your own derivative from \"PartialSubsystem\" with Components and \"Subsystems\".\n\"PartialSubsystem\" provides the correponding \"inner HierarchicalConnector hierarchy\" component.");
public
  Modelica.Electrical.Analog.Interfaces.Pin pin annotation (Placement(
        transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={
            {92,-8},{108,8}})));
  parameter Integer nr=1
    "The number of the pin to connect to in the pin array.";
equation
  connect(pin, hierarchy.pin[nr]) annotation (Line(
      points={{100,0},{10,0},{10,1.77636e-015},{-83,1.77636e-015}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-20},
            {100,20}}), graphics={Text(
          extent={{46,20},{94,-20}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%nr")}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics));
end HierarchicalPin;
