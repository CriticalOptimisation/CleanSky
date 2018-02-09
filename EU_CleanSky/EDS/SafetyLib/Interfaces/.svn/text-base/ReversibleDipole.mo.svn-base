within EU_CleanSky.EDS.SafetyLib.Interfaces;
model ReversibleDipole
  "Implements interface gender reversibility for bipolar components other than sources."
  extends EU_CleanSky.EDS.SafetyLib.Internal.PartialDipole;
  parameter Boolean useReverseInterface=false
    "If true, the component has its + and - plugs connector types reversed."
    annotation (Dialog(group="Connections"),Evaluate=true, HideResult=true);
  replaceable model Dipole = Internal.PolarisedPermanentPower constrainedby
    EU_CleanSky.EDS.SafetyLib.Internal.PartialDipole;
  Dipole d annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  // Connectors
  LogicFlowM m "Male connector."                                           annotation (Placement(
        transformation(extent={{-102,-2},{-98,2}}), iconTransformation(extent={{
            -106,-6},{-94,6}})));
  LogicFlowF f "Female connector."                                            annotation (
      Placement(transformation(extent={{98,-2},{102,2}}), iconTransformation(
          extent={{94,-6},{106,6}})));
  // Internal Components
  Internal.GenderChangerM genderChangerM if useReverseInterface
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Internal.GenderChangerF genderChangerF if useReverseInterface
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Link linkM if not useReverseInterface annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Link linkF if not useReverseInterface annotation (Placement(transformation(extent={{50,-10},{70,10}})));
equation
  // equations are only for graphics
  // leak
  graphics.leakIn = d.graphics.leakIn;
  graphics.leakOut = d.graphics.leakOut;
  graphics.leakProblem = d.graphics.leakProblem;

  connect(linkM.f, d.m) annotation (Line(
      points={{-50,0},{-20,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(linkM.m, m) annotation (Line(
      points={{-70,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(linkF.m, d.f) annotation (Line(
      points={{50,0},{20,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(linkF.f, f) annotation (Line(
      points={{70,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(genderChangerM.m, m) annotation (Line(
      points={{-10,40},{-80,40},{-80,0},{-100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(genderChangerM.m1, d.f) annotation (Line(
      points={{10,40.2},{26,40.2},{26,40},{40,40},{40,0},{20,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(genderChangerF.f1, d.m) annotation (Line(
      points={{-10,-39.8},{-26,-39.8},{-26,-40},{-40,-40},{-40,0},{-20,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(genderChangerF.f, f) annotation (Line(
      points={{10,-40},{80,-40},{80,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={
                  Polygon(visible=true,
          points={{70,2},{78,2},{78,2},{82,2},{82,2},{90,2},{90,-2},{82,-2},{82,
              -2},{78,-2},{78,-2},{70,-2},{70,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=true,
          points={{-88,2},{-80,2},{-80,2},{-76,2},{-76,2},{-68,2},{-68,-2},{-76,
              -2},{-76,-2},{-80,-2},{-80,-2},{-88,-2},{-88,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(visible=(not useReverseInterface),
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-78,0},
          rotation=90),
        Polygon(visible=useReverseInterface,
          points={{-10,2},{-2,2},{-2,2},{2,2},{2,2},{10,2},{10,-2},{2,-2},{2,-2},
              {-2,-2},{-2,-2},{-10,-2},{-10,2}},
          smooth=Smooth.None,
          fillColor={255,0,  255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={80,0},
          rotation=90)}), Diagram(graphics));
end ReversibleDipole;
