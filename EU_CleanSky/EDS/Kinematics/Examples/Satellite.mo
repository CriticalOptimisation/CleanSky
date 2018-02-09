within EU_CleanSky.EDS.Kinematics.Examples;
model Satellite "An aircraft with the characteristics of a 1 ton satellite"
  extends Aircraft;
  parameter Modelica.SIunits.Position initialPosition[3]={35784000+6378140,0,0}
    "Position vector from origin of world frame to origin of frame_a, resolved in world frame";
  parameter Modelica.SIunits.Velocity initialVelocity[3]={0,0,0}
    "Absolute velocity of frame_a, resolved in world frame (= der(r_0))";
  parameter Boolean forcePosition=false
    "Set to true if the connected Location object is used with forcePosition=true";
  Modelica.Mechanics.MultiBody.Parts.PointMass satellite(
    specularCoefficient=1,
    m=1000,
    r_0(fixed=not forcePosition, start=initialPosition),
    v_0(fixed=not forcePosition, start=initialVelocity),
    sphereDiameter=world.nominalLength/20,
    sphereColor={0,230,0})
    annotation (Placement(transformation(extent={{-72,-48},{-170,50}})));
  outer Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-500,420},{-460,460}})));
equation
  connect(satellite.frame_a, CG) annotation (Line(
      points={{-121,1},{8,1},{8,-12}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(zero, satellite.frame_a)
    annotation (Line(
      points={{-540,0},{-330,0},{-330,1},{-121,1}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-560,
            -500},{560,500}}),                                                                     graphics));
end Satellite;
