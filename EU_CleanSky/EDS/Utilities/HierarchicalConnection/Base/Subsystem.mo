within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
model Subsystem "A basic Subsystem without any sensing."
  extends PartialSubsystem;
equation
  connect(internal, hierarchy) annotation (Line(
      points={{-80,-100},{-80,100}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Subsystem;
