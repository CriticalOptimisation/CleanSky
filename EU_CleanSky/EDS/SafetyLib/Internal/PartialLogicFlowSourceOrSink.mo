within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialLogicFlowSourceOrSink
  "Source of a power flow. Normal flow is from P to N internally. State is indicated by 6 logic pairs: open, leak, reversed flow, high, low and ground potentials."
  extends PartialElementGraphics;
/* Parameters */
  parameter Boolean showGraphics=true;
  parameter Gender gender=EU_CleanSky.EDS.SafetyLib.Gender.male
    "Select interface gender."                                                             annotation (Dialog(group="Connections"),Evaluate=true);

/* Connectors */
  Interfaces.LogicFlowF f(
    open(FtoM=open),
    leak(FtoM=leak),
    reverse(FtoM=rev),
    high(FtoM=high),
    ground(FtoM=ground),
    low(FtoM=low)) if gender ==EU_CleanSky.EDS.SafetyLib.Gender.female
               annotation (Placement(transformation(extent={{98,-4},{102,0}}),
        iconTransformation(extent={{94,-6},{106,6}})));
  Interfaces.LogicFlowM m(
    open(MtoF=open),
    leak(MtoF=leak),
    reverse(MtoF=rev),
    high(MtoF=high),
    ground(MtoF=ground),
    low(MtoF=low)) if gender ==EU_CleanSky.EDS.SafetyLib.Gender.male
               annotation (Placement(transformation(extent={{98,0},{102,4}}),
        iconTransformation(extent={{94,-6},{106,6}})));
/* Internal components */

  /* variables storing input and output values */

protected
  Modelica.Blocks.Interfaces.BooleanOutput open
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Modelica.Blocks.Interfaces.BooleanOutput leak
    annotation (Placement(transformation(extent={{90,20},{110,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput rev
    annotation (Placement(transformation(extent={{90,0},{110,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput high
    annotation (Placement(transformation(extent={{90,0},{110,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput ground
    annotation (Placement(transformation(extent={{90,-20},{110,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput low
    annotation (Placement(transformation(extent={{90,-40},{110,-60}})));
  Modelica.Blocks.Interfaces.BooleanInput inOpen
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Blocks.Interfaces.BooleanInput inLeak
    annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
  Modelica.Blocks.Interfaces.BooleanInput inRev
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  Modelica.Blocks.Interfaces.BooleanInput inHigh
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Modelica.Blocks.Interfaces.BooleanInput inGround
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Modelica.Blocks.Interfaces.BooleanInput inLow
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
equation
  // Only define common graphical attributes
  // Flow information is not displayed on source icons
  graphics.stillM = false;
  graphics.stillF = false;
  graphics.reversedM = false;
  graphics.reversedF = false;
  graphics.leakOut = false;
  graphics.leakIn = false;
  graphics.blockageProblem = inOpen;
  graphics.leakProblem = inLeak and semantics==Semantics.fluid;

  // conditional connections
  connect(inOpen,f.open.MtoF);
  connect(inOpen,m.open.FtoM);
  connect(inLeak,f.leak.MtoF);
  connect(inLeak,m.leak.FtoM);
  connect(inRev,f.reverse.MtoF);
  connect(inRev,m.reverse.FtoM);
  connect(inHigh,f.high.MtoF);
  connect(inHigh,m.high.FtoM);
  connect(inGround,f.ground.MtoF);
  connect(inGround,m.ground.FtoM);
  connect(inLow,f.low.MtoF);
  connect(inLow,m.low.FtoM);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                   graphics={Ellipse(visible=showGraphics,
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({135,135,135}, graphics.background),
          fillPattern=FillPattern.Solid),      Text(visible=showGraphics,
          extent={{-152,-28},{148,-68}},
          textString="%name",
          lineColor={255,255,255})}),       Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                                                    graphics),
    Documentation(info="<html>
<p>This partial model specialises PartialElementGraphics for terminal elements of the circuit graph. </p>
<p>The circuit is represented by an acyclic oriented graph defined by connection gender. Cycles can be constructed but such circuits cannot carry power and will not pass the Modelica check (they are underdetermined, in a fashion similar to unreferenced voltages or zero resistance current loops in ideal electrical circuits). Proper circuits are acyclic oriented graphs, and therefore must have terminal elements conventionally called &QUOT;sources&QUOT; and &QUOT;sinks&QUOT; in graph theory. The terminal elements all derive from this partial model.</p>
<p>This partial model implements gender changing capability. It defines internal variables for all the output and input signals and properly connects them to the selected interface (according to the useSinkInterface parameter).</p>
<p>This partial model completely defines the missing equations in PartialElementGraphics, but adds 6 unknown output variables which must be defined by derived models.</p>
</html>"),    Diagram(graphics));
end PartialLogicFlowSourceOrSink;
