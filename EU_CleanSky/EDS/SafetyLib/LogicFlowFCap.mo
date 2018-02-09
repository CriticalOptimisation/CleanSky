within EU_CleanSky.EDS.SafetyLib;
model LogicFlowFCap "This component can terminate a link by a plug"

/* Connectors */
  Interfaces.LogicFlowM m "P-side connector"
               annotation (Placement(transformation(extent={{98,-2},{102,2}}),
        iconTransformation(extent={{-16,-16},{16,16}})));
/* Internal components */
protected
  Boolean problem "Indicates that there is a problem" annotation(HideResult=false);
  Internal.LogicPairM openM
    annotation (Placement(transformation(extent={{78,98},{82,102}})));
  Internal.LogicPairM leakM
    annotation (Placement(transformation(extent={{78,58},{82,62}})));
  Internal.LogicPairM revM
    annotation (Placement(transformation(extent={{78,18},{82,22}})));
  Internal.LogicPairM highM
    annotation (Placement(transformation(extent={{78,-22},{82,-18}})));
  Internal.LogicPairM groundM
    annotation (Placement(transformation(extent={{78,-62},{82,-58}})));
  Internal.LogicPairM lowM
    annotation (Placement(transformation(extent={{78,-102},{82,-98}})));
public
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{44,-26},{56,-14}})));
  Modelica.Blocks.Logical.Pre pre2
    annotation (Placement(transformation(extent={{44,-66},{56,-54}})));
  Modelica.Blocks.Logical.Pre pre3
    annotation (Placement(transformation(extent={{44,-106},{56,-94}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{40,110},{60,90}})));
initial equation
  // Orientation reversals are only allowed through a pre(x) to avoid algebraic dependencies.
  // This creates sequences of events instead. To solve the initialisation problem, the
  // default equation pre(x)=x must be replaced to avoid a circular dependency.
  pre(highM.FtoM)=false;
  pre(groundM.FtoM)=false;
  pre(lowM.FtoM)=false;

equation
  problem = m.open.FtoM or m.leak.FtoM;

  connect(m.open,openM)  annotation (Line(
      points={{100,0},{90,0},{90,100},{80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakM,m.leak) annotation (Line(
      points={{80,60},{90,60},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM,m.high) annotation (Line(
      points={{80,-20},{90,-20},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundM,m.ground) annotation (Line(
      points={{80,-60},{90,-60},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM,m.low) annotation (Line(
      points={{80,-100},{90,-100},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revM,m.reverse) annotation (Line(
      points={{80,20},{90,20},{90,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y,revM.MtoF) annotation (Line(
      points={{61,40},{70,40},{70,20},{80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y,leakM.MtoF) annotation (Line(
      points={{61,40},{70,40},{70,60},{80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre1.y,highM.MtoF) annotation (Line(
      points={{56.6,-20},{80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre1.u,highM.FtoM) annotation (Line(
      points={{42.8,-20},{40,-20},{40,0},{80,0},{80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre2.u,groundM.FtoM) annotation (Line(
      points={{42.8,-60},{40,-60},{40,-40},{80,-40},{80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre3.u,lowM.FtoM) annotation (Line(
      points={{42.8,-100},{40,-100},{40,-80},{80,-80},{80,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre3.y,lowM.MtoF) annotation (Line(
      points={{56.6,-100},{80,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre2.y,groundM.MtoF) annotation (Line(
      points={{56.6,-60},{80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression1.y,openM.MtoF) annotation (Line(
      points={{61,100},{80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="cap",Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}},
        initialScale=0.04),
                   graphics={Polygon(
          points={{0,100},{0,-100},{18,-98},{38,-92},{60,-80},{76,-64},{90,
              -44},{98,-20},{100,0},{96,26},{90,42},{82,56},{70,72},{52,86},{
              34,94},{20,98},{0,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false,extent={{-100,-100},{100,100}},
        initialScale=0.04),                         graphics),
    Documentation(info="<html>
<p>Dipole is an abstraction of a bipolar device transporting a power carrying medium. It can be used as a simple model of any electrical dipole, or wire. It is also applicable to fluid power systems, whether they carry heat or hydraulic power.</p>
<p>The dipole propagates information in Booleans along a sequence of dipoles. Its has no internal state, but accepts two inputs &QUOT;Open&QUOT; and &QUOT;Leak&QUOT; from the englobing component model. &QUOT;Open&QUOT; means that the flow of power is blocked, by an electrical open circuit for instance. Another example could be a clogged filter in a fluid system. &QUOT;Leak&QUOT; means that the power carrying fluid is massively leaving the circuit to go into the environment. It can be the consequence of an electrical short-circuit, or a pipe that opens. The component describes the power system point of view: even though small leaks may do harm in the receiving environment, they will not have an immediate effect on the power system. The leak input describes leaks large enough to cause a change in the intensive variable (voltage or pressure).</p>
<p>A large leak has also the effect of a downstream blockage. The Open information will be true on the downstream side. The normal flow orientation is P to N, but the flow can be reversed.</p>
</html>"));
end LogicFlowFCap;
