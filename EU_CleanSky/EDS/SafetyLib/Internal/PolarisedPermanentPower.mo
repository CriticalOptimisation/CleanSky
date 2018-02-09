within EU_CleanSky.EDS.SafetyLib.Internal;
model PolarisedPermanentPower
  "A permanent power source emitting high and low potentials"
  extends PartialNonLeakyDipole;
  Sources.HiPotential m1
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Sources.LoPotential f1
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
equation
  connect(m, f1.m) annotation (Line(
      points={{-100,0},{-50,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f, m1.f) annotation (Line(
      points={{100,0},{50,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="power",Icon(graphics={
        Polygon(visible=showPolarity,
          points={{70,2},{78,2},{78,2},{82,2},{82,2},{90,2},{90,-2},{82,-2},{82,
              -2},{78,-2},{78,-2},{70,-2},{70,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=(showPolarity and not useReverseInterface),
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={80,0},
          rotation=90),
        Polygon(visible=showPolarity,
          points={{-88,2},{-80,2},{-80,2},{-76,2},{-76,2},{-68,2},{-68,-2},{-76,
              -2},{-76,-2},{-80,-2},{-80,-2},{-88,-2},{-88,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
                                  Diagram(graphics));
end PolarisedPermanentPower;
