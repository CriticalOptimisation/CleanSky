within EU_CleanSky.EDS.SafetyLib.Internal;
model PolarisedLoadDipole
  "Main object is to consume power. High potiential must be connected to + and low potential to -."
  extends PartialLeakyDipole(biProp3(useStatus=true), biProp1(useStatus=true));

public
  Modelica.Blocks.Interfaces.BooleanOutput powered
    annotation (HideResult=false,Placement(transformation(extent={{22,-8},{6,
            8}}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={60,40})));
public
  Modelica.Blocks.Logical.Not not2 annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={60,40})));
  Internal.And3 and3
    annotation (Placement(transformation(extent={{46,-6},{34,6}})));
  Internal.BlockDownstream blkDown(varname="high", useStatus=false)
    annotation (Placement(transformation(extent={{-30,-10},{-10,-30}})));
  Internal.BlockUpstream blkUp(varname="low", useStatus=false)
    annotation (Placement(transformation(extent={{-16,-90},{4,-110}})));
  Modelica.Blocks.Logical.And and4
    annotation (Placement(transformation(extent={{34,-56},{46,-44}})));
  Modelica.Blocks.Logical.Not not3 annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={40,-80})));
  Modelica.Blocks.Logical.And and5
    annotation (Placement(transformation(extent={{-26,-74},{-14,-86}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={52,-30})));
equation

  connect(biProp3.s, not2.u) annotation (Line(
      points={{40,106.6},{40,110},{60,110},{60,47.2}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and3.y, powered) annotation (Line(
      points={{33.4,0},{14,0}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(highM, blkDown.m) annotation (Line(
      points={{-80,-20},{-30,-20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(blkDown.f, highF) annotation (Line(
      points={{-10,-20},{80,-20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(blkDown.reversed, biProp1.s) annotation (Line(
      points={{-14,-13.6},{-14,30},{-40,30},{-40,26.6}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(blkUp.reversed, biProp1.s) annotation (Line(
      points={{0,-93.6},{0,30},{-40,30},{-40,26.6}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(blkUp.m, lowM) annotation (Line(
      points={{-16,-100},{-80,-100}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(blkUp.f, lowF) annotation (Line(
      points={{4,-100},{80,-100}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and4.y, and3.u2) annotation (Line(
      points={{46.6,-50},{60,-50},{60,-4.8},{47.2,-4.8}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and4.u1, highM.FtoM) annotation (Line(
      points={{32.8,-50},{-40,-50},{-40,-20},{-80,-20}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and4.u2, lowF.MtoF) annotation (Line(
      points={{32.8,-54.8},{20,-54.8},{20,-100},{80,-100}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and3.u3, not2.y) annotation (Line(
      points={{47.2,4.8},{60,4.8},{60,33.4}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and5.u2, groundF.MtoF) annotation (Line(
      points={{-27.2,-75.2},{-34,-75.2},{-34,-60},{80,-60}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and5.u1, groundM.FtoM) annotation (Line(
      points={{-27.2,-80},{-74,-80},{-74,-60},{-80,-60}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(and5.y, not3.u) annotation (Line(
      points={{-13.4,-80},{32.8,-80}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(not3.y, and3.u1) annotation (Line(
      points={{46.6,-80},{64,-80},{64,0},{47.2,0}},
      color={255,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(not1.y, or1.u1) annotation (Line(
      points={{52,-23.4},{52,14},{40,14},{40,24.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and4.y, not1.u) annotation (Line(
      points={{46.6,-50},{52,-50},{52,-37.2}},
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
          pattern=LinePattern.None),
        Polygon(
          points={{-90,2},{-82,2},{-82,10},{-78,10},{-78,2},{-70,2},{-70,-2},
              {-78,-2},{-78,-10},{-82,-10},{-82,-2},{-90,-2},{-90,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{70,2},{78,2},{78,2},{82,2},{82,2},{90,2},{90,-2},{82,-2},{
              82,-2},{78,-2},{78,-2},{70,-2},{70,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
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
end PolarisedLoadDipole;
