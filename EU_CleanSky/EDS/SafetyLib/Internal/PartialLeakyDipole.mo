within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialLeakyDipole
  "Dipole of a flowing system, calculating occlusion in line."
  extends PartialLogicFlowDipole;
/* Parameters */
  parameter Boolean useOpen=true
    "Selects conditional input \"open\" for broken link." annotation(Dialog(group="Connections"),Evaluate=true,HideResult=true);
  parameter Boolean useLeak=true
    "Selects conditional input for leaky (grounded) link." annotation(Dialog(group="Connections"),Evaluate=true,HideResult=true);

//   encapsulated type LeakSemantics = enumeration(
//       electrical,
//       fluid) "Adjust leak semantics for either electrical or fluid circuits.";

/* Connectors */
  Modelica.Blocks.Interfaces.BooleanInput leak if useLeak
    "Leak in this component of the circuit."
                                         annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-87,49}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-40})));
  Modelica.Blocks.Interfaces.BooleanInput open if useOpen
    "Flow blocked in this component on the circuit."
                                         annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={7,31}),    iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-40})));
  /* Internal components */
protected
  Internal.BidirectionalPropagate biProp1(varname="rev", useStatus=false)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Internal.BidirectionalPropagate biProp2(varname="leak", useInput=true,
    useStatus=false)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Internal.BidirectionalPropagate biProp3(useInput=true, varname="open")
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  ConditionalPropagate
                     selProp1(
    useInput=true,
    useStatus=false,
    varname="gnd")
    annotation (Placement(transformation(extent={{-70,-50},{-50,-70}})));
  Modelica.Blocks.Logical.Or or1
   annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={40,32})));
  Boolean localLeak;
//   Boolean leakOut annotation(hideResult=false);
//   Boolean leakIn  annotation(hideResult=false);

  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={-60,-10})));
  Modelica.Blocks.Sources.BooleanExpression electricalSemantics(y=semantics ==SafetyLib.Semantics.electrical)
    annotation (Placement(transformation(extent={{16,-10},{-40,10}})));
  Modelica.Blocks.Sources.BooleanExpression stillFside(y=not (f.high.MtoF
         or f.low.MtoF))
    annotation (Placement(transformation(extent={{-10,-58},{-48,-40}})));
  Modelica.Blocks.Sources.BooleanExpression stillMside(y=not (m.high.FtoM
         or m.low.FtoM))
    annotation (Placement(transformation(extent={{-10,-40},{-48,-22}})));
equation
  if not useLeak then
    biProp2.u = false;
    and1.u1 = false;
  end if;
  if not useOpen then
    or1.u2 = false;
  end if;
  localLeak = biProp2.u;
  if semantics == SafetyLib.Semantics.electrical then
    graphics.leakOut = localLeak and ((m.leak.FtoM and (m.low.FtoM or f.high.MtoF)) or (f.leak.MtoF and (f.low.MtoF or m.high.FtoM)));
    graphics.leakIn  = localLeak and ((m.leak.FtoM and (f.low.MtoF or m.high.FtoM)) or (f.leak.MtoF and (m.low.FtoM or f.high.MtoF)));
    graphics.leakProblem = leakM.FtoM and leakF.MtoF;
  else
    graphics.leakOut = localLeak and (not (m.ground.FtoM or f.ground.MtoF) or m.high.FtoM or f.high.MtoF or m.low.FtoM or f.low.MtoF);
    graphics.leakIn  = false;
    graphics.leakProblem = leakM.FtoM or leakF.MtoF;
  end if;

  connect(biProp2.m, leakM) annotation (Line(
      points={{-50,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp2.f, leakF) annotation (Line(
      points={{-30,60},{80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp1.m, revM) annotation (Line(
      points={{-50,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp3.m, openM)  annotation (Line(
      points={{30,100},{-80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp3.f, openF)  annotation (Line(
      points={{50,100},{80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp1.f, revF) annotation (Line(
      points={{-30,20},{80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(selProp1.m, groundM)
                              annotation (Line(
      points={{-70,-60},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(selProp1.f, groundF)
                              annotation (Line(
      points={{-50,-60},{80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(biProp3.u, or1.y) annotation (Line(
      points={{40,93.6},{40,38.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.u2, open) annotation (Line(
      points={{35.2,24.8},{35.2,22},{20,22},{20,31},{7,31}},
      color={255,0,255},
      smooth=Smooth.None));

  // conditional connections (leak is conditioned on useLeak)
  connect(leak, biProp2.u) annotation (Line(
      points={{-87,49},{-40,49},{-40,53.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, selProp1.u)
                             annotation (Line(
      points={{-60,-16.6},{-60,-53.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak, and1.u1) annotation (Line(
      points={{-87,49},{-60,49},{-60,-2.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(electricalSemantics.y, and1.u2)
                                        annotation (Line(
      points={{-42.8,0},{-55.2,0},{-55.2,-2.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(stillFside.y, selProp1.propToF) annotation (Line(
      points={{-49.9,-49},{-54,-49},{-54,-53.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(stillMside.y, selProp1.propToM) annotation (Line(
      points={{-49.9,-31},{-66,-31},{-66,-53.6}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Documentation(info="<html>
<p>Dipole is an abstraction of a bipolar device transporting a power carrying medium. It is also applicable to fluid power systems, whether they carry heat or hydraulic power.</p>
<p>The dipole propagates information in Booleans along a sequence of dipoles. It has no internal state, but accepts two inputs &QUOT;Open&QUOT; and &QUOT;Leak&QUOT; from the englobing component model. &QUOT;Open&QUOT; means that the flow of power is blocked, by an electrical open circuit for instance. Another example could be a clogged filter in a fluid system. &QUOT;Leak&QUOT; means that the power carrying fluid is massively leaving the circuit to go into the environment. It can be the consequence of an electrical short-circuit, or a pipe that opens. The component describes the power system point of view: even though small leaks may do harm in the receiving environment, they will not have an immediate effect on the power system. The leak input describes leaks large enough to cause a change in the intensive variable (voltage or pressure).</p>
<p>A large leak has also the effect of a downstream blockage. The Open information will be true on the downstream side. The normal flow orientation is P to N, but the flow can be reversed.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics={
        Text(
          extent={{-74,96},{30,90}},
          lineColor={0,0,255},
          textString="A local open circuit propagates both ways, and indicates that the flow is still."),
        Text(
          extent={{-74,92},{52,86}},
          lineColor={0,0,255},
          textString=
              "A local leak propagates to ground as \"open\", and indicates absence of flow after the leak."),
        Text(
          extent={{-48,-62},{80,-66}},
          lineColor={0,0,255},
          textString="Ground propagates from a leak or the other end, if flow is still.")}),
    Icon(graphics={
        Polygon(
          points={{12,-14},{12,14},{-12,0},{12,-14}},
          smooth=Smooth.None,
          fillColor=DynamicSelect({255,255,255}, if graphics.leakIn >=0.5 then {200,127,0} else {255,255,255}),
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={8,54},
          rotation=90),
        Polygon(
          points={{-12,14},{-12,-14},{12,0},{-12,14}},
          smooth=Smooth.None,
          fillColor=DynamicSelect({255,255,255}, if graphics.leakOut >= 0.5 then {200,127,0} else {255,255,255}),
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-8,54},
          rotation=90)}));
end PartialLeakyDipole;
