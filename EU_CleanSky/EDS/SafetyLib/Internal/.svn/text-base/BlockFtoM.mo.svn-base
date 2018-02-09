within EU_CleanSky.EDS.SafetyLib.Internal;
model BlockFtoM
  "Consumes a logic true coming from the F side, preventing propagation to the M side output."
  extends PartialLogicPairDipole;

  parameter Boolean useInput=false annotation(Evaluate=true);
  Modelica.Blocks.Logical.Or propagateN
    annotation (HideResult=true,Placement(transformation(extent={{40,-42},{60,-22}})));

equation
  if useInput==false then
     propagateN.u2=false;
     m.MtoF=false;
  end if;
  connect(u, propagateN.u2) annotation (Line(
      points={{0,-100},{0,-40},{38,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateN.y, f.FtoM) annotation (Line(
      points={{61,-32},{80,-32},{80,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(propagateN.u1, m.FtoM) annotation (Line(
      points={{38,-32},{20,-32},{20,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(u, m.MtoF) annotation (Line(
      points={{0,-100},{0,-40},{-80,-40},{-80,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(defaultComponentName="biProp", Icon(graphics={
        Polygon(
          points={{-78,14},{70,14},{70,18},{78,12},{70,6},{70,10},{-78,10},{-78,
              14}},
          smooth=Smooth.None,
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{78,-10},{-70,-10},{-70,-6},{-78,-12},{-70,-18},{-70,-14},{78,
              -14},{78,-10}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,2},{20,-2}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={2,-12},
          rotation=45),
        Rectangle(
          extent={{-20,2},{20,-2}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={2,-12},
          rotation=-45)}),
    Diagram(graphics),
    Documentation(info="<html>
<p>The status presented on the optional input (false by default) replaces the output signal on the upstream side.</p>
</html>"));
end BlockFtoM;
