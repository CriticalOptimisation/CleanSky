within EU_CleanSky.EDS.SafetyLib.Internal;
model ReversibleControlledPower
  "A controlled power source emitting high and low potentials when boolean input is true."
  extends Interfaces.ReversibleDipole(redeclare model Dipole =
          Internal.PolarisedControlledPower);

  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-60,-88}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-60,-40})));
equation
  connect(d.u, u) annotation (Line(
      points={{-12,-8},{-12,-30},{-60,-30},{-60,-88}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics));
end ReversibleControlledPower;
