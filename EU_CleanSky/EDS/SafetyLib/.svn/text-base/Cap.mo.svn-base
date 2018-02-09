within EU_CleanSky.EDS.SafetyLib;
model Cap "This component can terminate a link by a plug"
extends Internal.PartialLogicFlowSourceOrSink(final showGraphics=false, gender=SafetyLib.Gender.male)
annotation(IconMap(extent={{-100,-50},{0,50}},primitivesVisible=true));
/* Parameters */
/* Connectors */
/* Internal components */
public
  Modelica.Blocks.Sources.BooleanExpression booleanFalse
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Logical.Pre pre3
    annotation (Placement(transformation(extent={{-6,-56},{6,-44}})));
  Modelica.Blocks.Sources.BooleanExpression booleanTrue(y=true)
    annotation (Placement(transformation(extent={{40,60},{60,40}})));
  Modelica.Blocks.Logical.Pre pre4
    annotation (Placement(transformation(extent={{-6,-16},{6,-4}})));
  Modelica.Blocks.Logical.Pre pre5
    annotation (Placement(transformation(extent={{-6,-36},{6,-24}})));
initial equation
  // Orientation reversals are only allowed through a pre(x) to avoid algebraic dependencies.
  // This creates sequences of events instead. To solve the initialisation problem, the
  // default equation pre(x)=x must be replaced to avoid a circular dependency.
  pre(inHigh)=false;
  pre(inGround)=false;
  pre(inLow)=false;

equation

  connect(inHigh, pre4.u) annotation (Line(
      points={{-100,-10},{-7.2,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre4.y, high) annotation (Line(
      points={{6.6,-10},{100,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(inGround, pre5.u) annotation (Line(
      points={{-100,-30},{-7.2,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre5.y, ground) annotation (Line(
      points={{6.6,-30},{100,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(inLow, pre3.u) annotation (Line(
      points={{-100,-50},{-7.2,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pre3.y, low) annotation (Line(
      points={{6.6,-50},{100,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanFalse.y, rev) annotation (Line(
      points={{61,20},{80,20},{80,10},{100,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanFalse.y, leak) annotation (Line(
      points={{61,20},{80,20},{80,30},{100,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanTrue.y, open) annotation (Line(
      points={{61,50},{100,50}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="cap",Icon(coordinateSystem(preserveAspectRatio=true, extent={{0,-100},
            {200,100}},
        initialScale=0.1),
                   graphics={Polygon(visible=(gender==SafetyLib.Gender.male),
          points={{100,40},{100,40},{100,-40},{100,-40},{80,-36},{64,-20},{60,0},
              {64,20},{80,36},{100,40}},
          lineColor={0,0,255},
          smooth=Smooth.Bezier,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
                             Polygon(visible=(gender==SafetyLib.Gender.female),
          points={{100,40},{100,40},{100,-40},{100,-40},{120,-36},{136,-20},{140,
              0},{136,20},{120,36},{100,40}},
          lineColor={0,0,255},
          smooth=Smooth.Bezier,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}),                  Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}},
        initialScale=0.1),                          graphics),
    Documentation(info="<html>
<p>Dipole is an abstraction of a bipolar device transporting a power carrying medium. It can be used as a simple model of any electrical dipole, or wire. It is also applicable to fluid power systems, whether they carry heat or hydraulic power.</p>
<p>The dipole propagates information in Booleans along a sequence of dipoles. Its has no internal state, but accepts two inputs &QUOT;Open&QUOT; and &QUOT;Leak&QUOT; from the englobing component model. &QUOT;Open&QUOT; means that the flow of power is blocked, by an electrical open circuit for instance. Another example could be a clogged filter in a fluid system. &QUOT;Leak&QUOT; means that the power carrying fluid is massively leaving the circuit to go into the environment. It can be the consequence of an electrical short-circuit, or a pipe that opens. The component describes the power system point of view: even though small leaks may do harm in the receiving environment, they will not have an immediate effect on the power system. The leak input describes leaks large enough to cause a change in the intensive variable (voltage or pressure).</p>
<p>A large leak has also the effect of a downstream blockage. The Open information will be true on the downstream side. The normal flow orientation is P to N, but the flow can be reversed.</p>
</html>"));
end Cap;
