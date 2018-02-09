within EU_CleanSky.EDS.SafetyLib;
model PolarisedLoad
  "Main object is to consume power. High potiential must be connected to + and low potential to -."
  extends Interfaces.ReversibleDipole(redeclare model Dipole =
        Internal.PolarisedLoadDipole (
        semantics=semantics,
        useOpen=useOpen,
        useLeak=useLeak));

public
  Modelica.Blocks.Interfaces.BooleanOutput powered
    annotation (HideResult=false,Placement(transformation(extent={{-14,52},{-30,
            68}}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={60,40})));
  Modelica.Blocks.Interfaces.BooleanInput leak if useLeak
    "Leak in this component of the circuit."
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-60}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-40})));
  Modelica.Blocks.Interfaces.BooleanInput open if useOpen
    "Flow blocked in this component on the circuit."
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-40})));
  parameter Boolean useOpen=true
    "Selects conditional input \"open\" for broken link.";
  parameter Boolean useLeak=true
    "Selects conditional input for leaky (grounded) link.";
equation

  connect(open, d.open) annotation (Line(
      points={{-30,-40},{-4,-40},{-4,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(powered, d.powered) annotation (Line(
      points={{-22,60},{12,60},{12,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak, d.leak) annotation (Line(
      points={{-30,-60},{4,-60},{4,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="load",Diagram(graphics), Icon(graphics={
        Ellipse(
          extent={{-40,100},{40,20}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-34,94},{34,26}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({255,255,255}, if powered > 0.5 then {255,255,0} else {
              192,192,192}),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,4},{40,-4}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,60},
          rotation=45,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-40,4},{40,-4}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,60},
          rotation=-45,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
<p>The polarised load component exists in two versions: PolarisedLoad and ReversePolarisedLoad. The only difference is the association of connector gender with potential polarities + and -.</p>
<p>As soon as power is correctly applied (a high potential is present on + and a low potential on -) the powered boolean output indicates that the function is correctly powered. The light symbol turns yellow when powered is true, and gray when powered is false. In editing mode, the light symbol has a white background. When this component is embedded in a component representing the behaviour of an equipment, it is necessary to add two Link components in order to implement an open circuit and a short circuit on the power input. Loss of function for internal reasons is implemented in the ControlledPower component, in which the probability law is a replaceable submodel. Intermediate logic is neeed for complex equipment which has one of the following characteristics:</p>
<p><ul>
<li>Function performance is not conditioned only be the availability of power: it also requires a command of some sort.</li>
<li>Multiple power inputs, including systems like motorised valves in which distinct power inputs directly control several functions.</li>
<li>Power is provided by a fluid fuel which is used both as a thermodynamic or mechanical power carrying fluid (i.e. is pumped, ventilated or compressed), and as a thermochemical power source (as a fuel).</li>
</ul></p>
</html>"));
end PolarisedLoad;
