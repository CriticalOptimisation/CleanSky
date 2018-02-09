within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialDipole "Dipole of a power system."
 extends PartialElementGraphics;
/* Connectors */
  Interfaces.LogicFlowM m
               annotation (Placement(transformation(extent={{-102,-2},{-98,2}}),
        iconTransformation(extent={{-106,-6},{-94,6}})));
  Interfaces.LogicFlowF f
               annotation (Placement(transformation(extent={{98,-2},{102,2}}),
        iconTransformation(extent={{94,-6},{106,6}})));
/* Internal components */

equation
  // equations are only for graphics
  // presence/absence of flow shapes
  graphics.stillM = (m.ground.MtoF and m.ground.FtoM) or m.open.MtoF or m.open.FtoM;
  graphics.stillF = (f.ground.MtoF and f.ground.FtoM) or f.open.FtoM or f.open.MtoF;
  // direction of flow shapes
  graphics.reversedM = m.reverse.MtoF;
  graphics.reversedF = f.reverse.FtoM;
  // background
  graphics.blockageProblem = m.open.MtoF or f.open.FtoM;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({135,135,135}, graphics.background),
          fillPattern=FillPattern.Solid),
        Polygon(visible=true,
          points=DynamicSelect({{-48,14},{-48,-14},{-24,0},{-24,-14},{0,0},{0,-14},{24,0},{24,
              -14},{48,0},{24,14},{24,0},{0,14},{0,0},{-24,14},{-24,0}},graphics.pointsP),
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor=DynamicSelect({135,135,135}, if graphics.stillP < 0.5 then {0,127,0} else
                    graphics.background),
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135},
          origin={-48,0},
          rotation=0),
        Polygon(visible=true,
          points=DynamicSelect({{-48,14},{-48,-14},{-24,0},{-24,-14},{0,0},{0,-14},{24,0},{24,
              -14},{48,0},{24,14},{24,0},{0,14},{0,0},{-24,14},{-24,0}},graphics.pointsN),
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor=DynamicSelect({135,135,135}, if graphics.stillN < 0.5 then {0,127,0} else
                    graphics.background),
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135},
          origin={48,0},
          rotation=0),
        Text(
          extent={{-110,0},{112,-38}},
          textString="%name",
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,127,0})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                                                    graphics),
    Documentation(info="<html>
<p>Dipole is an abstraction of a bipolar device transporting a power carrying medium. It can be used as a simple model of any electrical dipole, or wire. It is also applicable to fluid power systems, whether they carry heat or hydraulic power.</p>
<p>The dipole propagates information in Booleans along a sequence of dipoles. Its has no internal state, but accepts two inputs &QUOT;Open&QUOT; and &QUOT;Leak&QUOT; from the englobing component model. &QUOT;Open&QUOT; means that the flow of power is blocked, by an electrical open circuit for instance. Another example could be a clogged filter in a fluid system. &QUOT;Leak&QUOT; means that the power carrying fluid is massively leaving the circuit to go into the environment. It can be the consequence of an electrical short-circuit, or a pipe that opens. The component describes the power system point of view: even though small leaks may do harm in the receiving environment, they will not have an immediate effect on the power system. The leak input describes leaks large enough to cause a change in the intensive variable (voltage or pressure).</p>
<p>A large leak has also the effect of a downstream blockage. The Open information will be true on the downstream side. The normal flow orientation is P to N, but the flow can be reversed.</p>
</html>"));
end PartialDipole;
