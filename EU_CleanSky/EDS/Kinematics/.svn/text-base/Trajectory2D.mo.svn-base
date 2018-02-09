within EU_CleanSky.EDS.Kinematics;
model Trajectory2D
  "Forces a mobile object to follow a prescribed trajectory expressed as a time, distance, altitude table."

  parameter String tableName="NoName"
    "Table name on file or in function usertab (see docu)";
  parameter String fileName="NoName" "File where matrix is stored";
  parameter Modelica.SIunits.Angle startLongitude=0
    "Longitude of starting point";
  parameter Modelica.SIunits.Angle startLatitude=0
    "Longitude of starting point";
    parameter Boolean flyEast=true "fly toward east(true) / west(false)";
  Modelica.Blocks.Sources.RealExpression TimeFromTakeOff(y=time) annotation (Placement(transformation(extent={{-100,
            -10},{-80,10}})));
  Modelica.Blocks.Math.Gain gain(k=1/world.a) annotation (Placement(transformation(extent={{20,-10},
            {28,-2}})));
  Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2_1
    annotation (Placement(transformation(extent={{-28,6},{-16,-6}})));
  Internal.MakePosition makePosition
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  outer TheEarth world
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Tables.CombiTable1Ds TrajectoryTable(
    tableOnFile=true,
    tableName=tableName,
    fileName=fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2,3})                                              annotation (Placement(transformation(extent={{-60,-10},
            {-40,10}})));
  Modelica.Blocks.Math.Add add(k2=+1, k1=if flyEast then +1 else -1)
    "\"positive longitudes are Eastern longitudes\""
    annotation (Placement(transformation(extent={{40,-22},{60,-2}})));
  Modelica.Blocks.Sources.RealExpression StartLon(y=startLongitude)
    "Longitude of starting point"
    annotation (Placement(transformation(extent={{-16,-8},{16,-28}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{40,2},{60,22}})));
  Modelica.Blocks.Sources.RealExpression Surface(y=world.a)
    "Distance from surface to centre of the Earth"
    annotation (Placement(transformation(extent={{-16,8},{16,28}})));
  output Interfaces.PositionOutput position
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Blocks.Interfaces.RealOutput altitude
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={6,6})));
  Modelica.Blocks.Interfaces.RealOutput distance
    annotation (Placement(transformation(extent={{0,0},{12,-12}}), iconTransformation(extent={{0,-12},{12,0}})));
equation
  connect(TrajectoryTable.u, TimeFromTakeOff.y) annotation (Line(
      points={{-62,0},{-79,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(distance, gain.u) annotation (Line(
      points={{6,-6},{19.2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TrajectoryTable.y, deMultiplex2_1.u) annotation (Line(
      points={{-39,0},{-29.2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex2_1.y1[1], distance)
    annotation (Line(
      points={{-15.4,-3.6},{-8,-3.6},{-8,-6},{6,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex2_1.y2[1], altitude) annotation (Line(
      points={{-15.4,3.6},{-8,3.6},{-8,6},{6,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, add.u1) annotation (Line(
      points={{28.4,-6},{38,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, makePosition.lon) annotation (Line(
      points={{61,-12},{66,-12},{66,-6},{72,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(StartLon.y, add.u2) annotation (Line(
      points={{17.6,-18},{38,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Surface.y, add1.u1) annotation (Line(
      points={{17.6,18},{38,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(altitude, add1.u2) annotation (Line(
      points={{6,6},{38,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, makePosition.radius) annotation (Line(
      points={{61,12},{66,12},{66,6},{72,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(makePosition.position, position) annotation (Line(
      points={{92.1,-0.1},{96.05,-0.1},{96.05,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Documentation(info="<html>
<p>The trajectory is expressed as a time, distance, altitude table.</p>
<p>The distance is the distance between the reference surface location (distance zero) and the point of the surface being overflown by the mobile object, counted along the equator. If the mobile is covering more than once the circumference of the planet, values greater than one circumference shall be used in the table.</p>
<p>The altitude is the geodetic altitude as calculated by the Location object. It will be equal to the geometric distance between the point of the surface overflown by the mobile object and the NED frame of reference of the mobile object. The distance is measured along a vertical line. Most airplanes have vertical plane performance which is quite limited, so the total distance flown taking into account climbs and descents is very close to the distance in the table. </p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                                                     graphics={Line(
          points={{-80,-80},{-72,-80},{-60,0},{-40,0},{-36,20},{20,20},{28,40},{60,40},{80,-80},{90,-80}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Trajectory2D;
