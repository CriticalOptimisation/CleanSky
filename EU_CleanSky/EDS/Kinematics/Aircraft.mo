within EU_CleanSky.EDS.Kinematics;
partial model Aircraft "Base class for Aircraft models in the EMM"
  // The list of published mechanical interfaces, where equipment can be attached.
  replaceable type AllFrames = enumeration(:);
  // The list of external mechanical interfaces, where external forces can act.
  replaceable type AircraftFrames
    extends AllFrames;
  end AircraftFrames;

  FrameVisualiser frameVisualiser(length=1)
    annotation (Placement(transformation(extent={{-540,134},{-470,188}})));
  // Coordinates is a table of vectors. On rigid aircraft, the values are time-independant.
  // They can change with time on flexible aircraft structure models.
  // Need to add definition equations for derived class in equation section too.
  Modelica.SIunits.Position[3] coordinates[AllFrames];

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a CG "Center of gravity"
    annotation (Placement(transformation(extent={{-8,-28},{24,4}})));
protected
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a zero "Origin of body axes"
    annotation (Placement(transformation(extent={{-544,-4},{-536,4}})));
equation

  connect(frameVisualiser.frame, zero) annotation (Line(
      points={{-540,161},{-540,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-560,-500},{560,
            500}}), graphics), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,0},{-80,10},{-20,10},{40,100},{50,100},{20,10},{40,6},{50,6},{50,10},{44,10},{44,20},{60,20},{70,18},{70,12},{60,10},{60,6},{70,6},{
              88,40},{96,40},{88,2},{98,0},{88,-2},{96,-40},{88,-40},{70,-6},{60,-6},{60,-10},{70,-12},{70,-18},{60,-20},{44,-20},{44,-10},{50,-10},{50,-6},
              {40,-6},{20,-10},{50,-100},{40,-100},{-20,-10},{-80,-10},{-100,0}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));
end Aircraft;
