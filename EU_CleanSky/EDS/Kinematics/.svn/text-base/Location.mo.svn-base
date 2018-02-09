within EU_CleanSky.EDS.Kinematics;
model Location "Location or position of aircraft on Earth"
  parameter Boolean animationNEDFrame=true
    "= true, if the NED reference frame is displayed" annotation (Dialog(tab="Animation"));
//   constant Modelica.SIunits.Duration stellarDay=86164.1
//     "24 hr contain 86400 seconds, but the Earth rotates slightly more than 360° until the Sun is exactly overhead twice in a row.";
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a NEDframe
    "North East Down frame used by JSBSim." annotation (Placement(
        transformation(extent={{-126,-16},{-94,16}}), iconTransformation(extent={{-126,-16},{-94,16}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute ECEFtoLongitude(
    n(displayUnit="1") = {0,0,1},
    useAxisFlange=forcePosition,
    animation=false)
    "Allow aircraft motion along the equator (longitude, east-west direction)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-20,0})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic ECEFtoUEN(animation=false,useAxisFlange=forcePosition)
    "Translate from ECEF to Up East North reference frame."
    annotation (Placement(transformation(extent={{-40,30},{-60,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation UENtoNED(n(displayUnit="1")=
         {0,1,0}, angle=-90,
    animation=false)
    "Fixed rotation from Up,East,North direct reference frame to North,East,Down direct reference frame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,20})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,0})));
  Modelica.Mechanics.MultiBody.Sensors.Distance distance(animation=false)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,60})));
  FrameVisualiser NED(
    animation=animationNEDFrame,
    color={0,180,0},
    length(displayUnit="m") = world.nominalLength)
    "North East Down reference frame visualisation"
    annotation (Placement(transformation(extent={{-70,-26},{-50,-6}})));
  Internal.MakePosition makePosition
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  // This is the fixed rotation between the fixed surface point (on the equator)
  // and the rotating ECEF frame.

  // Because TheEarth is an extension of the MSL multibody mechanics world, it is
  // necessary to define this here, otherwise the compiler complains about inconsistent
  // outer world declarations in the various components when checking the class.
protected
  outer TheEarth world annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
public
  Modelica.Mechanics.MultiBody.Parts.FixedRotation UENtoNED2(
                                                            n(displayUnit="1")=
         {0,1,0}, angle=-90,
    r={world.a,0,0},
    width=500,
    animation=false)
    "Fixed rotation from Up,East,North direct reference frame to North,East,Down direct reference frame"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,90})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b Vertical
    "Coordinate system fixed to the component with one cut-force and cut-torque"
                                                                                                        annotation (
      Placement(transformation(extent={{-116,74},{-84,106}}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=180,
        origin={-80,0})));
  parameter Boolean forcePosition=false
    "Make a position input available to force the position of the mobile when it is computed."
    annotation (Dialog(tab="Earth surface"));
  input Interfaces.PositionInput positionInput if     forcePosition
    "Optional position input"
    annotation (Placement(transformation(extent={{110,50},{90,70}}), iconTransformation(extent={{110,50},{90,70}})));
  Modelica.Mechanics.Rotational.Sources.Position setXPosition(exact=false, f_crit=0.0167) if
                                                                             forcePosition annotation (Placement(transformation(extent={{30,24},{10,44}})));
  Internal.DecodePosition decodePosition if forcePosition annotation (Placement(transformation(extent={{80,70},{60,50}})));
  Modelica.Mechanics.Translational.Sources.Position setZPosition(exact=false, f_crit=0.1) if
                                                                                 forcePosition
    "Filtered in order to avoid infinite forces on slope changes."
    annotation (Placement(transformation(extent={{10,42},{-10,62}})));
equation

public
  Interfaces.PositionOutput positionOutput
    annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  connect(NEDframe, UENtoNED.frame_b)
    annotation (Line(
      points={{-110,0},{-80,0},{-80,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ECEFtoUEN.frame_b, UENtoNED.frame_a)
    annotation (Line(
      points={{-60,40},{-80,40},{-80,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ECEFtoUEN.frame_a, ECEFtoLongitude.frame_b)
    annotation (Line(
      points={{-40,40},{-20,40},{-20,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ECEFtoLongitude.frame_a, relativeAngles.frame_a)
    annotation (Line(
      points={{-20,-10},{30,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ECEFtoLongitude.frame_b, relativeAngles.frame_b)
    annotation (Line(
      points={{-20,10},{30,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(distance.frame_b, ECEFtoUEN.frame_b)
    annotation (Line(
      points={{-60,60},{-60,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(distance.frame_a, ECEFtoUEN.frame_a)
    annotation (Line(
      points={{-40,60},{-40,40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(NEDframe, NED.frame)
    annotation (Line(
      points={{-110,0},{-80,0},{-80,-16},{-70,-16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(positionOutput, makePosition.position)
    annotation (Line(
      points={{100,0},{88,0},{88,-0.1},{74.1,-0.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(relativeAngles.angles[3], makePosition.lon)
    annotation (Line(
      points={{41.6667,0},{46,0},{46,-6},{54,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(distance.distance, makePosition.radius)
    annotation (Line(
      points={{-50,71},{-50,76},{-66,76},{-66,20},{46,20},{46,6},{54,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(world.ECEF, ECEFtoLongitude.frame_a)
    annotation (Line(
      points={{0,-40},{-20,-40},{-20,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(UENtoNED2.frame_b, Vertical) annotation (Line(
      points={{-80,90},{-100,90}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(UENtoNED2.frame_a, distance.frame_a)
    annotation (Line(
      points={{-60,90},{-40,90},{-40,60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(positionInput, decodePosition.positionInput) annotation (Line(
      points={{100,60},{79.9,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(setXPosition.flange, ECEFtoLongitude.axis)
    annotation (Line(
      points={{10,34},{0,34},{0,0},{-10,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(setXPosition.phi_ref, decodePosition.lon)
    annotation (Line(
      points={{32,34},{48,34},{48,54},{60,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(setZPosition.flange, ECEFtoUEN.axis) annotation (Line(
      points={{-10,52},{-58,52},{-58,46}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(setZPosition.s_ref, decodePosition.radius)
    annotation (Line(
      points={{12,52},{28,52},{28,66},{60,66}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),                                                                      graphics={Rectangle(
          extent={{-34,42},{-4,22}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-32,42},{-6,22}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="For a fully general 
model, a rotation 
around Y should be
 added here.")}),
    Documentation(info="<html>
<p>This class models the position of the centre of the earth, with a fixed frame which can be considered inertial. This frame is called EarthCenteredInertial, or ECI. A first forced rotation along the Z axis models the Earth rotation. The model is suitable for modelling launches into space from the equator, and will correctly model the advantage of launching eastwards rather than westwards.</p>
<p>Although the Modelica approach masks lots of equations (quaternions ...), this model mimics JSBSim::FGLocation class. In particular, the same reference frames are used. This is why location excludes orientation.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-100,100},{102,-98}}, fileName="modelica://EU_CleanSky/EDS/Kinematics/Resources/3d-Earth-Globe-300px.png"),
          Text(
          extent={{-100,-100},{100,-140}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-38,-100},{42,-56}},
          lineColor={255,255,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Earth fixed"),
        Text(
          extent={{-70,-10},{-10,12}},
          lineColor={255,255,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Surface")}));
end Location;
