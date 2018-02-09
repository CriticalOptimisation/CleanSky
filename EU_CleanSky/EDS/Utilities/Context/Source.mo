within EU_CleanSky.EDS.Utilities.Context;
model Source "Source of contextual data"
  parameter Integer p=0 "Context priority";
  Connector c annotation (Placement(transformation(extent={{50,-10},{70,10}}),
        iconTransformation(extent={{50,-10},{70,10}})));
  DataInput dataInput annotation (Placement(transformation(extent={{-68,-10},{-48,
            10}}), iconTransformation(extent={{-68,-10},{-48,10}})));
equation
  if p > 0 then
    Connections.potentialRoot(c, p);
  else
    Connections.potentialRoot(c);
  end if;
  if Connections.isRoot(c) then
    c.context = dataInput;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
            {60,60}}), graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(coordinateSystem(extent={{-60,-60},
            {60,60}})));
end Source;
