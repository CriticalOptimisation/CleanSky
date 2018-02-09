within EU_CleanSky.EDS.SafetyLib;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  partial model LandingGearSystem
    "Model of a 2 leg landing gear extension system"

    EU_CleanSky.EDS.SafetyLib.PolarisedLoad extendJack(useLeak=false, useOpen=
          false)
      annotation (Placement(transformation(extent={{-72,42},{-52,62}})));
    EU_CleanSky.EDS.SafetyLib.Sources.PermanentPower hyd1
      annotation (Placement(transformation(extent={{-104,-84},{-124,-64}})));
    EU_CleanSky.EDS.SafetyLib.Split split annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-106,-52})));
    EU_CleanSky.EDS.SafetyLib.PolarisedLoad powerByGravity(useLeak=false)
      annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
    EU_CleanSky.EDS.SafetyLib.PolarisedLoad powerByHyd(useLeak=false)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    EU_CleanSky.EDS.SafetyLib.ControlledPower potential
      annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
    EU_CleanSky.EDS.SafetyLib.Merge merge annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-74,-64})));
    Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={-78,20})));
    EU_CleanSky.EDS.SafetyLib.PolarisedLoad extendJack1(useLeak=false, useOpen=
          false)
      annotation (Placement(transformation(extent={{48,42},{68,62}})));
    EU_CleanSky.EDS.SafetyLib.PolarisedLoad powerByGravity1(useLeak=false)
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    EU_CleanSky.EDS.SafetyLib.PolarisedLoad powerByHyd1(useLeak=false)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    EU_CleanSky.EDS.SafetyLib.ControlledPower potential1
      annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
    Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={42,20})));
  protected
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus
      subControlBus
      annotation (Placement(transformation(extent={{-30,-52},{-10,-32}})));
  protected
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus
      subControlBus1
      annotation (Placement(transformation(extent={{90,-52},{110,-32}})));
  public
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-54,-48},{-60,-42}})));
    Modelica.Blocks.Logical.Not not2
      annotation (Placement(transformation(extent={{66,-48},{60,-42}})));
    replaceable Modelica.Blocks.Interfaces.PartialBooleanMISO LeftMGPhysics(nu=2)
      constrainedby Modelica.Blocks.Interfaces.PartialBooleanMISO
      annotation (Placement(transformation(extent={{-46,54},{-30,70}})));
    replaceable Modelica.Blocks.Interfaces.PartialBooleanMISO RightMGPhysics(nu=2)
      constrainedby Modelica.Blocks.Interfaces.PartialBooleanMISO
      annotation (Placement(transformation(extent={{74,54},{90,70}})));
    UserInteraction.Outputs.IndicatorLamp LeftGearDown(hideConnector=false)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},
          rotation=90,
          origin={71,-67})));
    UserInteraction.Outputs.IndicatorLamp rightGearDown(hideConnector=false)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},
          rotation=90,
          origin={89,-67})));
    UserInteraction.Inputs.ToggleButton toggleButton(label="Gear Down",
        buttonState(start=false, fixed=true))
      annotation (Placement(transformation(extent={{66,-88},{94,-78}})));
  protected
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus
      subControlBus2
      annotation (Placement(transformation(extent={{90,-86},{110,-66}})));
  public
    Modelica.Blocks.Logical.Not not3
      annotation (Placement(transformation(extent={{-30,-34},{-38,-26}})));
  public
    Modelica.Blocks.Logical.Not not4
      annotation (Placement(transformation(extent={{90,-34},{82,-26}})));
    UserInteraction.Inputs.ToggleButton toggleButton1(
        buttonState(start=false, fixed=true), label="Backup")
      annotation (Placement(transformation(extent={{66,-98},{94,-88}})));
    EU_CleanSky.EDS.SafetyLib.ControlledPower combined
      "Combined power of hydraulics and gravity"
      annotation (Placement(transformation(extent={{-72,22},{-52,42}})));
    EU_CleanSky.EDS.SafetyLib.ControlledPower combined1
      "Combined power of hydraulics and gravity"
      annotation (Placement(transformation(extent={{48,22},{68,42}})));
  public
    Modelica.Blocks.Logical.Not not5
      annotation (Placement(transformation(extent={{-38,-14},{-44,-8}})));
  public
    Modelica.Blocks.Logical.Not not6
      annotation (Placement(transformation(extent={{82,-14},{76,-8}})));
  equation
    connect(powerByHyd.powered, or1.u1) annotation (Line(
        points={{-84,4},{-84,10},{-78,10},{-78,15.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByGravity.powered, or1.u2) annotation (Line(
        points={{-56,4},{-56,10},{-74.8,10},{-74.8,15.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByHyd1.powered, or2.u1) annotation (Line(
        points={{36,4},{36,10},{42,10},{42,15.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByGravity1.powered, or2.u2) annotation (Line(
        points={{64,4},{64,10},{45.2,10},{45.2,15.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(split.f1, powerByHyd1.m) annotation (Line(
        points={{-96,-52},{14,-52},{14,0},{20,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(split.f2, powerByHyd.m) annotation (Line(
        points={{-106,-44},{-106,0},{-100,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByHyd.f, merge.m2) annotation (Line(
        points={{-80,0},{-74,0},{-74,-56}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(merge.m1, powerByHyd1.f) annotation (Line(
        points={{-64,-64},{46,-64},{46,0},{40,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByHyd.open, not1.y) annotation (Line(
        points={{-92,-4},{-92,-8},{-68,-8},{-68,-45},{-60.3,-45}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.u, subControlBus.MLG_HCLO400) annotation (Line(
        points={{-53.4,-45},{-22.7,-45},{-22.7,-42},{-20,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(powerByHyd1.open, not2.y) annotation (Line(
        points={{28,-4},{28,-8},{52,-8},{52,-45},{59.7,-45}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(LeftMGPhysics.y, subControlBus.MLG_ZEFD400) annotation (Line(
        points={{-28.8,62},{-26,62},{-26,-42},{-20,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(powerByHyd.powered, LeftMGPhysics.u[1]) annotation (Line(
        points={{-84,4},{-84,64.8},{-46,64.8}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(extendJack.powered, LeftMGPhysics.u[2]) annotation (Line(
        points={{-56,56},{-56,59.2},{-46,59.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(powerByHyd1.powered, RightMGPhysics.u[1]) annotation (Line(
        points={{36,4},{36,64.8},{74,64.8}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(extendJack1.powered, RightMGPhysics.u[2]) annotation (Line(
        points={{64,56},{64,59.2},{74,59.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(RightMGPhysics.y, subControlBus1.MLG_ZEFD401) annotation (Line(
        points={{91.2,62},{94,62},{94,-42},{100,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(hyd1.f, split.m) annotation (Line(
        points={{-120,-69},{-120,-52},{-116,-52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(hyd1.m, merge.f) annotation (Line(
        points={{-108,-69},{-108,-64},{-84,-64}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(subControlBus1, subControlBus) annotation (Line(
        points={{100,-42},{108,-42},{108,-54},{-12,-54},{-12,-42},{-20,-42}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(subControlBus1, subControlBus2) annotation (Line(
        points={{100,-42},{108,-42},{108,-76},{100,-76}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(toggleButton.buttonState, subControlBus2.MLG_HCLO400) annotation (
        Line(
        points={{94,-83},{98,-83},{98,-76},{100,-76}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(not2.u, subControlBus1.MLG_HCLO400) annotation (Line(
        points={{66.6,-45},{98,-45},{98,-42},{100,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(rightGearDown.status, subControlBus2.MLG_ZEFD401) annotation (Line(
        points={{89,-72},{89,-76},{100,-76}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(LeftGearDown.status, subControlBus2.MLG_ZEFD400) annotation (Line(
        points={{71,-72},{71,-76},{100,-76}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(not3.u, LeftMGPhysics.y) annotation (Line(
        points={{-29.2,-30},{-26,-30},{-26,62},{-28.8,62}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not3.y, potential.u) annotation (Line(
        points={{-38.4,-30},{-40,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not4.y, potential1.u) annotation (Line(
        points={{81.6,-30},{80,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not4.u, RightMGPhysics.y) annotation (Line(
        points={{90.8,-30},{94,-30},{94,62},{91.2,62}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(toggleButton1.buttonState, subControlBus2.MLG_HCLO410) annotation (
        Line(
        points={{94,-93},{100,-93},{100,-76}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(or1.y, combined.u) annotation (Line(
        points={{-78,24.4},{-78,32},{-72,32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(or2.y, combined1.u) annotation (Line(
        points={{42,24.4},{42,32},{48,32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(potential.m, powerByGravity.m) annotation (Line(
        points={{-42,-23.4},{-42,-20},{-34,-20},{-34,0},{-40,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(potential.f, powerByGravity.f) annotation (Line(
        points={{-58,-23.4},{-58,-20},{-66,-20},{-66,0},{-60,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(potential1.m, powerByGravity1.m) annotation (Line(
        points={{78,-23.4},{78,-20},{86,-20},{86,0},{80,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(potential1.f, powerByGravity1.f) annotation (Line(
        points={{62,-23.4},{62,-20},{54,-20},{54,0},{60,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(combined.f, extendJack.f) annotation (Line(
        points={{-54,38.6},{-54,42},{-48,42},{-48,52},{-52,52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(combined.m, extendJack.m) annotation (Line(
        points={{-70,38.6},{-70,42},{-78,42},{-78,52},{-72,52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(combined1.m, extendJack1.m) annotation (Line(
        points={{50,38.6},{50,42},{42,42},{42,52},{48,52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(combined1.f, extendJack1.f) annotation (Line(
        points={{66,38.6},{66,42},{74,42},{74,52},{68,52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not5.y, powerByGravity.open) annotation (Line(
        points={{-44.3,-11},{-48,-11},{-48,-4}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not5.u, subControlBus.MLG_HCLO410) annotation (Line(
        points={{-37.4,-11},{-20,-11},{-20,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(not6.y, powerByGravity1.open) annotation (Line(
        points={{75.7,-11},{72,-11},{72,-4}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not6.u, subControlBus1.MLG_HCLO410) annotation (Line(
        points={{82.6,-11},{100,-11},{100,-42}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
              -100},{140,100}}),
                           graphics={
          Polygon(
            points={{0,-10},{0,80},{100,80},{100,-50},{50,-50},{50,-10},{0,-10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-120,-10},{-120,80},{-20,80},{-20,-50},{-70,-50},{-70,-10},
                {-120,-10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-6,78},{64,72}},
            lineColor={0,0,255},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            textString="Right Main Landing Gear"),
          Text(
            extent={{-128,78},{-58,72}},
            lineColor={0,0,255},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            textString="Left Main Landing Gear"),
          Rectangle(
            extent={{60,-56},{100,-100}},
            lineColor={0,0,255},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{44,-56},{114,-62}},
            lineColor={0,0,255},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            textString="Control Panel")}), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-140,-100},{140,100}})),
      experiment(StopTime=60, Interval=0.05),
      __Dymola_experimentSetupOutput);
  end LandingGearSystem;

  model LandingGearExample
    "Interactive landing gear system with time based pseudo-physics."
    extends LandingGearSystem(redeclare SimLandingGear LeftMGPhysics,
        redeclare SimLandingGear RightMGPhysics);
    extends Modelica.Icons.Example;
    annotation (experiment(StopTime=60), __Dymola_experimentSetupOutput);
  end LandingGearExample;

  model SimLandingGear
    "Simulates the physical extension of a landing gear leg."
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO(nu=2);

    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
    Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=5)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    discrete Boolean down(start=false)
      "Latches on when gear reaches down position.";
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=down)
      annotation (Placement(transformation(extent={{26,-10},{46,10}})));
    Modelica.Blocks.Logical.Pre pre1
      annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  algorithm
    when onDelay.y then
      down:=true;
    end when;

  equation
    connect(or1.u1, u[1]) annotation (Line(
        points={{-58,0},{-71,0},{-71,35},{-100,35}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(or1.u2, u[2]) annotation (Line(
        points={{-58,-8},{-71,-8},{-71,-35},{-100,-35}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(or1.y, onDelay.u) annotation (Line(
        points={{-35,0},{-12,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pre1.u, booleanExpression.y) annotation (Line(
        points={{60,0},{47,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pre1.y, y) annotation (Line(
        points={{83,0},{94,0},{94,0},{115,0}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(visible=DynamicSelect(true,not or1.y and not down),
            extent={{-68,60},{28,38}},
            lineColor={215,215,215},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Ellipse(visible=DynamicSelect(true,not or1.y and not down),
            extent={{4,92},{88,8}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Ellipse(visible=DynamicSelect(true,not or1.y and not down),
            extent={{22,74},{70,26}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Ellipse(visible=DynamicSelect(false,or1.y and not down),
            extent={{-18,24},{66,-60}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={255,128,0}),
          Ellipse(visible=DynamicSelect(false,or1.y and not down),
            extent={{0,6},{48,-42}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={255,128,0}),
          Rectangle(visible=DynamicSelect(false,down),
            extent={{-48,11},{48,-11}},
            lineColor={215,215,215},
            fillColor={0,255,0},
            fillPattern=FillPattern.Solid,
            origin={-44,11},
            rotation=90),
          Ellipse(visible=DynamicSelect(false,down),
            extent={{-84,-10},{0,-94}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={0,255,0}),
          Ellipse(visible=DynamicSelect(false,down),
            extent={{-66,-28},{-18,-76}},
            lineColor={215,215,215},
            fillPattern=FillPattern.Solid,
            fillColor={0,255,0})}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics));
  end SimLandingGear;
end Examples;
