within EU_CleanSky.EDS.SafetyLib.Interfaces;
model PowerSource "Repackages the interface in the shape of a battery."
  extends Internal.PartialElementGraphics;
  parameter Boolean useReverseInterface=false
    "Controls only the graphical appearance (+ and - markings)."                                           annotation (Evaluate=true,HideResult=true);
  parameter Boolean showPolarity=false
    "Controls whether polarity is displayed on icon."                                    annotation (Evaluate=true,HideResult=true);
  replaceable model Dipole = Internal.PolarisedPermanentPower constrainedby
    EU_CleanSky.EDS.SafetyLib.Internal.PartialDipole;
  Dipole d annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
//   replaceable Internal.PolarisedPermanentPower d constrainedby
//     Internal.PartialLogicFlowDipole
//     annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  LogicFlowM m  annotation (Placement(transformation(extent={{-102,-2},{-98,2}}),
        iconTransformation(extent={{-70,40},{-50,60}})));
  LogicFlowF f  annotation (Placement(transformation(extent={{98,-2},{102,2}}),
        iconTransformation(extent={{50,40},{70,60}})));
equation
  // Graphical attributes mimic those of encapsulated dipole.
  // It is not possible to express this in a single equation, because the
  // Graphics record contains definition equations.
  // TODO: put all the undefined variables in Graphics in a sub-record.
  // presence/absence of flow shapes
  graphics.stillM = d.graphics.stillM;
  graphics.stillF = d.graphics.stillF;
  // direction of flow shapes
  graphics.reversedM = d.graphics.reversedM;
  graphics.reversedF = d.graphics.reversedF;
  // background
  graphics.blockageProblem = d.graphics.blockageProblem;
  // leak
  graphics.leakIn = d.graphics.leakIn;
  graphics.leakOut = d.graphics.leakOut;
  graphics.leakProblem = d.graphics.leakProblem;

  // Connections
  connect(d.m, m)  annotation (Line(
      points={{-20,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(d.f, f)  annotation (Line(
      points={{20,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
annotation (Icon(graphics={
        Rectangle(
          extent={{-100,40},{100,-100}},
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
          extent={{-110,-22},{112,-60}},
          textString="%name",
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,127,0}),
        Polygon(visible=showPolarity,
          points={{52,26},{60,26},{60,26},{64,26},{64,26},{72,26},{72,22},{64,22},
              {64,22},{60,22},{60,22},{52,22},{52,26}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=showPolarity,
          points={{-70,26},{-62,26},{-62,26},{-58,26},{-58,26},{-50,26},{-50,22},
              {-58,22},{-58,22},{-62,22},{-62,22},{-70,22},{-70,26}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=(showPolarity and useReverseInterface),
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-60,24},
          rotation=90),
        Polygon(visible=(showPolarity and not useReverseInterface),
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,  255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={62,24},
          rotation=90)}),              Diagram(graphics),
    Documentation(info="<html>
<p>This model is an adapter to change the shape of a standard dipole to an icon more recognisable as a power source. The + and - markings can be swapped using a paramater, or made invisible.</p>
</html>"));
end PowerSource;
