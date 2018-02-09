within EU_CleanSky.EDS.Kinematics;
model FrameVisualiser
  "Displays graphically the axes of a reference frame in the animation window"
  parameter Real axisDiameterFraction=100
    "Ratio of arrow length to arrow diameter.";
  parameter Modelica.Mechanics.MultiBody.Types.Color color={0,0,255}
    "Color of arrows";
  parameter Modelica.SIunits.Length length=1 "Length of complete arrow";
  parameter Boolean animation=true "= true, if animation shall be enabled";
  Internal.FixedArrowAxis xAxis(
    headColor={255,0,0},
    animation=animation,
    length=length,
    diameter=length/axisDiameterFraction,
    color=color) "First axis of reference frame"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Internal.FixedArrowAxis yAxis(
    headColor={0,255,0},
    animation=animation,
    n(displayUnit="1") = {0,1,0},
    length=length,
    diameter=length/axisDiameterFraction,
    color=color) "Second axis of reference frame"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Internal.FixedArrowAxis zAxis(
    headColor={0,0,255},
    animation=animation,
    length=length,
    diameter=length/axisDiameterFraction,
    color=color,
    n(displayUnit="1") = {0,0,1}) "Third axis of reference frame"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame
    "Coordinate system in which visualization data is resolved"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  connect(yAxis.frame_a, frame) annotation (Line(
      points={{-20,0},{-100,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(xAxis.frame_a, frame) annotation (Line(
      points={{-20,60},{-60,60},{-60,0},{-100,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(zAxis.frame_a, frame) annotation (Line(
      points={{-20,-60},{-60,-60},{-60,0},{-100,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-80,0},{-50,100},{-38,58}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-50,100},{-84,72}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{-32,-92},{-20,-54}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-32,-92},{-80,-66}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{30,18},{10,-10}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{30,18},{0,38}},
          color={0,0,255},
          smooth=Smooth.None),
        Text(
          extent={{-100,-100},{102,-132}},
          lineColor={0,0,255},
          textString="%name")}));
end FrameVisualiser;
