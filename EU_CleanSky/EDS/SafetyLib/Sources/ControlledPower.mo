within EU_CleanSky.EDS.SafetyLib.Sources;
model ControlledPower
  "A controlled power source emitting high and low potentials when boolean input is true."
  extends Interfaces.PowerSource(final showPolarity=true,
                                 redeclare model Dipole =
        Interfaces.ReversibleDipole(redeclare model Dipole =
            Internal.PolarisedControlledPower));
  parameter Boolean useReverseInterface=false
    "If true, the component has its + and - plugs connector types reversed."
    annotation (Dialog(group="Connections"),Evaluate=true, HideResult=true);

  Dipole d(final useReverseInterface=useReverseInterface);
  Modelica.Blocks.Interfaces.BooleanInput u "Control input" annotation (Placement(
        transformation(extent={{-112,-68},{-96,-52}}),
                                                     iconTransformation(extent={{-8,-8},
            {8,8}},
        rotation=0,
        origin={-100,-30})));
equation

  connect(u,d.d.u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end ControlledPower;
