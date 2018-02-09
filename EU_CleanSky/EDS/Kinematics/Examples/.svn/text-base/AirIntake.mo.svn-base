within EU_CleanSky.EDS.Kinematics.Examples;
model AirIntake "Partial recuperation of dynamic pressure in an air intake."
  Modelica.Fluid.Sources.Boundary_pT exhaust(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_p_in=false,
    nPorts=1,
    p=19000,
    T=218.15) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  inner Modelica.Fluid.System system(p_ambient=10000, T_ambient=218.15)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Fluid.Fittings.AbruptAdaptor leftAdaptor(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    show_totalPressures=true,
    show_portVelocities=true,
    diameter_a=Modelica.Constants.inf,
    diameter_b=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT exhaust1(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_p_in=false,
    nPorts=1,
    p=58000,
    T=218.15)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(leftAdaptor.port_b, exhaust.ports[1]) annotation (Line(
      points={{10,0},{80,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(exhaust1.ports[1], leftAdaptor.port_a) annotation (Line(
      points={{-60,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end AirIntake;
