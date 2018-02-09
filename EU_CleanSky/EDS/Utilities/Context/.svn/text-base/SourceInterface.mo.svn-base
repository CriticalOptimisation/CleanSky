within EU_CleanSky.EDS.Utilities.Context;
partial model SourceInterface
  "Partial Source of contextual data, for graphical source definition."
  parameter Integer p=0 "Context priority";
  Connector c annotation (Placement(transformation(extent={{50,-10},{70,10}}),
        iconTransformation(extent={{50,-10},{70,10}})));
  Source source annotation (Placement(transformation(extent={{34,-6},{46,6}})));
equation
  connect(source.c, c) annotation (Line(
      points={{46,0},{60,0}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (
    preferredView="diagram",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
        graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Diagram(coordinateSystem(extent={{-60,-60},{60,60}}, preserveAspectRatio=
            false), graphics));
end SourceInterface;
