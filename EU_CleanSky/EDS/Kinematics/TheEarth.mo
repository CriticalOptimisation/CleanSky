within EU_CleanSky.EDS.Kinematics;
model TheEarth
  "A Modelica.Mechanics.Multibody.World class customised to behave like the Earth"
  extends Modelica.Mechanics.MultiBody.World(
     redeclare replaceable function gravityAcceleration =
        EU_CleanSky.EDS.Kinematics.Internal.earthGravityAcceleration (earth=fixed.frame_b.r_0),
     final gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,
     final animateGravity = false,
     final mue=3.9925e14,
     final g=9.7803,
     final n={0,0,-1},
     final label1="x",
     final label2="z",
     nominalLength=if animateWorld then 20e6 else 100,
     axisLength=20e6,
     final axisDiameter=axisLength/100,
     axisColor_x={230,230,0},
     axisColor_y=Modelica.Mechanics.MultiBody.Types.Defaults.FrameColor,
     axisColor_z=Modelica.Mechanics.MultiBody.Types.Defaults.FrameColor,
     final gravityArrowTail={0,0,0},
     final gravityArrowLength=axisLength/2,
     final gravityArrowDiameter=gravityArrowLength/defaultWidthFraction,
     final gravityArrowColor={0,230,0},
     final gravitySphereDiameter=12742000,
     final gravitySphereColor={0,230,0});
  // all the last 'final' parameters are not used but declaring them here simplifies the user interface

  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg startLongitude=0
    "Initial noon longitude at time=0";
  parameter Boolean animationECEFFrame=animateWorld
    "= true, if the ECEF reference frame is displayed" annotation (Dialog(tab="Animation"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg
      surfaceLongitude=0
    "Longitude of surface Frame connector placed on the equator."
    annotation (Dialog(tab="Earth surface"));
  parameter Boolean worldCentreAtSurface=false
    "Origin of ECI frame at initial position of surface Frame"
    annotation (Dialog(tab="Earth surface"));

  constant Modelica.SIunits.Radius a = 6378137
    "Average semi-major Earth axis (equator)";
  constant Modelica.SIunits.Radius b = 6356752.3142
    "Average semi-minor Earth axis (poles)";
  constant Modelica.SIunits.Duration stellarDay=86164.1
    "24 hr contain 86400 seconds, but the Earth rotates slightly more than 360° until the Sun is exactly overhead twice in a row.";

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape earthSurface(
    shapeType="sphere",
    r_shape={-b,0,0},
    lengthDirection={1,0,0},
    length=2*b,
    width=2*a,
    height=2*a,
    color={0,128,255},
    specularCoefficient=0,
    r=ECEF.r_0,
    R=ECEF.R) if animateWorld;
  Modelica.Mechanics.Rotational.Sources.Speed speed(                 exact=true, useSupport=false,
    phi(fixed=false))
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Blocks.Sources.RealExpression earthSpeed(y=2*Modelica.Constants.pi/stellarDay)
    "Rotational speed of the Earth"
    annotation (Placement(transformation(extent={{70,-10},{16,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute ECItoECEF(
    n(displayUnit="1") = {0,0,1},
    useAxisFlange=true,
    w(start=2*Modelica.Constants.pi/stellarDay, fixed=true),
    animation=false,
    phi(fixed=true, start=Modelica.SIunits.Conversions.from_deg(-startLongitude)))
    "Allow Earth rotation"                     annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-40,0})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b ECEF
    "Earth Centred Earth Fixed frame which rotates witht the planet"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r=
        Modelica.Mechanics.MultiBody.Frames.resolve1(Modelica.Mechanics.MultiBody.Frames.planarRotation({0,0,1},angle=Modelica.SIunits.Conversions.from_deg(-startLongitude+surfaceLongitude),der_angle=0), {-a,0,0}),
      animation=false)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-50})));
  FrameVisualiser ECEF1(
                       color={255,0,0},
    length(displayUnit="m") = 2e7,
    animation=animateWorld) if
                       animationECEFFrame or animateWorld
    annotation (Placement(transformation(extent={{-20,38},{0,58}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation surface(
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
    n(displayUnit="1") = {0,0,1},
    r={-a,0,0},
    angle=-surfaceLongitude)
    "Rotation sets the surface frame at the correct longitude."
    annotation (Placement(transformation(extent={{-60,38},{-40,58}})));

  Modelica.Mechanics.MultiBody.Parts.FixedRotation UENtoNED1(
                                                            n(displayUnit="1")=
         {0,1,0}, angle=-90,
    animation=false)
    "Fixed rotation from Up,East,North direct reference frame to North,East,Down direct reference frame"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-80,48})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b SurfaceFrame
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,32},{-84,64}}),
        iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,-100})));

equation
  connect(speed.w_ref,earthSpeed. y) annotation (Line(
      points={{2,0},{13.3,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ECEF, ECItoECEF.frame_b)
    annotation (Line(
      points={{-100,0},{-80,0},{-80,20},{-40,20},{-40,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ECItoECEF.axis, speed.flange) annotation (Line(
      points={{-30,0},{-20,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(UENtoNED1.frame_b,SurfaceFrame)
    annotation (Line(
      points={{-90,48},{-100,48}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(surface.frame_a,UENtoNED1. frame_a)
    annotation (Line(
      points={{-60,48},{-70,48}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(surface.frame_b, ECEF1.frame) annotation (Line(
      points={{-40,48},{-20,48}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(surface.frame_b, ECItoECEF.frame_b) annotation (Line(
      points={{-40,48},{-40,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));

  connect(ECItoECEF.frame_a, fixed.frame_b) annotation (Line(
      points={{-40,-10},{-40,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    defaultComponentName="world",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"world\" component is defined. A default world
    component with the point gravity field will be used. If this is not desired,
drag EU_CleanSky.EDS.Kinematics.TheEarth into the top level of your model.",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p>The Earth object is a derivative from the World object of Modelica.Mechanics.MultiBody, which it replaces. The World object is configured with a specific gravityAcceleration function which gives the right acceleration for objects moving near the equator, and the 3D graphical appearance is modified to match the shape of the earth better (a flattened ellipsoid). In addition the attached shape rotates at the same speed as the earth surface, for applications near the earth surface (e.g. aircraft simulation). </p>
<h4><span style=\"color:#008000\">Position relative to the Sun</span></h4>
<p>Since the motion around the Sun is not modelled, the Earth Centered Inertial frame is just offset from the world frame. The 27&deg; tilt of the Earth axis relative to the normal to its orbital plane, which is responsible for the existence of seasons, is not reproduced either : the Earth rotates around the z {0,0,1} axis in world frame. </p>
<p>The Sun is in the general direction of world frame x axis, which by default is displayed in yellow. It sits there at the equinox only, and moves up and down on the XZ plane with the season. The distance to the Sun also varies with the season. The Sun motion is not modelled, nor is the season, but if they are added to a model, the x axis is always on the meridian where it is exactly solar noon (the Sun is at its highest). The meridian where it is noon at the beginning of the simulation can be set with parameter <b>startLongitude</b>. If you want the simulation to start at noon on the Greenwich meridian (the default), set this parameter to 0. </p>
<h4><span style=\"color:#008000\">Longitude and latitude sign convention</span></h4>
<p>Longitudes are positive in the eastern direction, and negative in the western direction, since this is consistent with the chosen reference frame (Z up through the North pole). Of course once the simulation starts, the Earth will begin to rotate, therefore as seen from the startLongitude, the Sun will begin to go down toward the western horizon.</p>
<p>Latitudes should be positive in the northern hemisphere and negative in the southern hemisphere, in order to match the orientation of the z axis, but in the current implementation the latitude is always zero.</p>
<h4><span style=\"color:#008000\">Model of gravity</span></h4>
<p>While it derives from the World object of the Modelica Standard Library, a custom gravityAcceleration function is used. The function implements the point mass gravity model, which is a crude approximation of the planet&apos;s gravitational field. The default World uses a value for &apos;mue&apos; (the gravitational constant) which gives an asymptotically correct field far from the planet surface. The custom function uses a slightly different value which gives the expected downwards acceleration on the equator (latitude = 0). Due to the ellisoidal shape of the Earth, even the local orientation of the gravitational field is incorrectly calculated at all other latitudes excepted at the poles, and the magnitude is wrong at all non zero latitudes.</p>
<p>A much more complex gravity model would be needed if the model had to support trajectories which do not follow the equator. The current implementation of the Location model does not include the degree of freedom required for non zero latitudes, although provisions have been made for that. Even if they stay above the equator, simulation of orbiting satellites are only correct for low earth orbits. The tuned gravitational constant is wrong for trajectories which go too far from the Earth surface, like geostationary orbits.</p>
<p>As a provision, the custom gravityAcceleration function in TheEarth is still replaceable, and it would not be extremely complicated to craft a replacement giving correct answers in the whole equatorial plane, in order to model for instance Arthur C. Clarke&apos;s space elevator.</p>
<h4><span style=\"color:#008000\">Connectors</span></h4>
<p>The <b>frame_b</b> connector is inherited from the standard library world, and directly connects at the origin of the world frame. It should rarely be used, if ever.</p>
<p>The <b>ECEF</b> connector is placed at the centre of the Earth and rotates with it. Many Location components can be connected to this connector (one per moving object). This connector has conventional North-East-Down orientation for its X, Y and Z axes respectively. By conventional, we mean that Down points to the centre of the Earth, and not exactly in the local, gravitational &QUOT;Down&QUOT; direction, even though they will be the same with the supplied approximation of the gravitational field.</p>
<p>The <b>SurfaceFrame</b> connector has a fixed position and orientation relative to the planet. In other words, it stays at the same place on Earth all the time, and is also NED-oriented. The connector can currently only be placed on the equator, and its longitude can be set with parameter <b>surfaceLongitude</b> in the tab &QUOT;Earth Surface&QUOT;. The general idea is to have the simulated trajectories start from SurfaceFrame, because it will be easy to compute the covered distance, through a simple comparison of the orientations of the starting and local NED-oriented connectors. Of course it only works for trajectories shorter than a half great circle.</p>
<p>The parameter <b>worldCentreAtSurface</b> ensures that the position of the centre of the Earth is offset from the world frame such that the origin of the world frame coincides exactly with the SurfaceFrame position. When this parameter is true, the initial absolute position recorded in SurfaceFrame.r_0 will always start at {0,0,0} at the beginning of the simulation.</p>
<h4><span style=\"color:#008000\">Animations</span></h4>
<p>The parameter <b>enableAnimation</b> is inherited from the MSL. All the visualiser objects built into the Modelica.Mechanics.MultiBody library components are removed from the model (they are conditional). The parameter <b>animateWorld</b> makes 3D graphics appear at orbital scale. When the parameter is false, all the joints and parts defining the coordinate system, which are thousands of kilometers long, and the shape of the planet are hidden. The inherited visual representation of the world axes and the ECEF frame are also hidden.</p>
<p>The parameter <b>animationECEFFrame</b> in the tab Animation can be set to false to selectively hide the ECEF frame when animateWorld is true. It can be used when, for instance, the Earth rotation is not relevant for a particular simulation. </p>
<p>When <b>enableAnimation</b> is true, and <b>animateWorld</b> is false, all the planet-scale visualisation are removed from the model. When these parameters are combined with <b>worldCentreAtSurface</b> and the trajectory starts at <b>SurfaceFrame</b>, the vehicle scale graphical objects will be the only things displayed, and they will also be located very close to the world frame origin. This combination of settings makes a planet scale simulation possible while the 3D view window shows only the vehicle. The image below on the left shows a 10 meter diameter sphere from the TestLocation example, placed at a fixed position on the <b>SurfaceFrame</b> connector at time=0. The XY grid has a 1 meter grid step, and is 20x20 m&sup2; overall. The image on the right shows the same object 0.4 seconds later, already departing the area. The grid size is set using the command &QUOT;animationGrid(step, size)&QUOT; and defines what the window initially looks at. The ability to focus on the simulated vehicle at time=0, combined with the follow settings the Animation Setup menu, make it easy to track a vehicle while it moves around the world. In addition, it is possible to display the Earth surface at the same time, but its large size makes it difficult to process for the renderer, and it is rarely visible in the window. It is usually a good idea to connect a reasonably sized flat representation of the ground to <b>SurfaceFrame</b>.</p>
<p><img src=\"modelica://EU_CleanSky/EDS/Kinematics/Resources/GlobalLocal-1.png\"/><img src=\"modelica://EU_CleanSky/EDS/Kinematics/Resources/GlobalLocal-5.png\"/></p>
<h4><span style=\"color:#008000\">Other</span></h4>
<p>The parameter <b>driveTrainMechanics3D</b> is inherited from the MSL World component, and is used by a few components of the MSL linking rotational mechanics to 3D mechanics. It enables the calculation of gyroscopic forces and other 3D effects appearing in rotational machinery.</p>
</html>"));
end TheEarth;
