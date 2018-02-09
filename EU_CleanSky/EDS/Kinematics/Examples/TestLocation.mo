within EU_CleanSky.EDS.Kinematics.Examples;
model TestLocation "Example of geostationary satellite using Location model."
  extends Modelica.Icons.Example;
  inner TheEarth world(
    worldCentreAtSurface=true,
    startLongitude=0,
    surfaceLongitude=45,
    animateWorld=false)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Location location
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Satellite                                    satellite(initialPosition={
        35784000 + world.a,0,0}, initialVelocity={0,3074,0})
    annotation (Placement(transformation(extent={{9,-8},{-9,8}},
        rotation=90,
        origin={-80,1})));
  Modelica.Mechanics.MultiBody.Sensors.CutForce scale(animation=false,
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
    "Measures the weight of an object."
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Mechanics.MultiBody.Parts.PointMass kg(                 m=1,
    animation=true,
    sphereDiameter=10)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue(significantDigits=5)
    annotation (Placement(transformation(extent={{-14,18},{30,38}})));
equation
  connect(kg.frame_a, scale.frame_b) annotation (Line(
      points={{20,60},{-20,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(scale.force[3], realValue.numberPort) annotation (Line(
      points={{-38,48.3333},{-38,28},{-17.3,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(satellite.CG, location.NEDframe)
    annotation (Line(
      points={{-79.04,0.28},{-45.4,0.28},{-45.4,0},{-11,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(scale.frame_a, world.SurfaceFrame) annotation (Line(
      points={{-40,60},{-90,60},{-90,80}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
                                Text(
          extent={{-12,24},{28,16}},
          lineColor={0,0,255},
          textString="local gravity on the equator")}),
    experiment(StopTime=100000),
    __Dymola_experimentSetupOutput);
end TestLocation;
