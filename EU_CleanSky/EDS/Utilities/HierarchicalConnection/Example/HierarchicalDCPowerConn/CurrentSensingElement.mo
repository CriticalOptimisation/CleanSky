within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.HierarchicalDCPowerConn;
model CurrentSensingElement "Senses current on the DC power connector"
  extends Modelica.Icons.RotationalSensor;

  HierarchicalConnector hierarchy annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,82}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
  HierarchicalConnector internal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-82}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
protected
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 "positive pin"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
public
  Modelica.Blocks.Interfaces.RealOutput i1
    "current in the branch from p to n as output signal"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
equation
  connect(currentSensor.n, hierarchy.pin[2]) annotation (Line(
      points={{0,10},{0,82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(currentSensor.p, internal.pin[2]) annotation (Line(
      points={{0,-10},{0,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(p1, hierarchy.pin[1]) annotation (Line(
      points={{-40,0},{-40,60},{0,60},{0,82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(p1, internal.pin[1]) annotation (Line(
      points={{-40,0},{-40,-60},{0,-60},{0,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(currentSensor.i, i1) annotation (Line(
      points={{10,0},{108,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end CurrentSensingElement;
