within EU_CleanSky.EDS.SafetyLib;
model ControlledBooster
  "A controlled power source emitting high potential when a low potential is applied and the boolean input is true."
  parameter Modelica.Blocks.Interfaces.BooleanOutput initialState=false
    "If true, function is failed at T=0" annotation(Dialog(tab="Failure Modes"));
  parameter Real lambda=0.1 "Loss of function probability (per hour)" annotation(Dialog(tab="Failure Modes"));
  parameter Boolean useInput=true
    "Booster operates as soon as low potential is present on - when input is not used.";

  parameter Gender gender=EU_CleanSky.EDS.SafetyLib.Gender.male
    "Gender of high potential output."                                                                                                     annotation(Dialog(group="Connections"),Evaluate=true);
//   parameter Boolean useSinkInterface=false
//     "If true, the component has P (filled) interface type, otherwise it has N (hollow) interface type."
//     annotation (Dialog(tab="Failure Modes"),Evaluate=true);
  replaceable model Law =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Failure probability law" annotation(Dialog(tab="Failure Modes"));

  Interfaces.LogicFlowM n annotation (Placement(transformation(extent={{78,38},{
            82,42}}), iconTransformation(extent={{74,60},{86,72}})));
  Interfaces.LogicFlowF nOut if gender == EU_CleanSky.EDS.SafetyLib.Gender.female
                          annotation (Placement(transformation(extent={{-82,38},
            {-78,42}}), iconTransformation(extent={{-86,60},{-74,72}})));
  Interfaces.LogicFlowM pOut if gender == EU_CleanSky.EDS.SafetyLib.Gender.male
                          annotation (Placement(transformation(extent={{-76,38},
            {-72,42}}), iconTransformation(extent={{-86,60},{-74,72}})));
  Modelica.Blocks.Interfaces.BooleanInput u if useInput annotation (Placement(
        transformation(extent={{108,-28},{92,-12}}), iconTransformation(extent={{-108,-8},
            {-92,8}})));
protected
  Sources.ControlledHiPotential p1(gender=gender)
    annotation (Placement(transformation(extent={{-30,10},{-50,30}})));
  Internal.And3               and1
    annotation (Placement(transformation(extent={{24,-24},{16,-16}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-44,-44},{-36,-36}})));
  FailureMode loss(initialFailure=initialState, redeclare model Law = Law,
    lambda=lambda)
    annotation (Placement(transformation(extent={{-72,-52},{-48,-28}})));
  Sources.HiPotential p2(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  PolarisedLoad        load(useOpen=false, useLeak=false,
    useReverseInterface=true)
    annotation (Placement(transformation(extent={{60,50},{40,30}})));
  Modelica.Blocks.Sources.BooleanExpression trueExpr(y=true) if not useInput;
equation
  /* Conditional equations */
  connect(u, and1.u1) annotation (Line(
      points={{100,-20},{24.8,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(trueExpr.y, and1.u1) annotation (Line(
      points={{41,-60},{60,-60},{60,-20},{24.8,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pOut, p1.m) annotation (Line(
      points={{-74,40},{-74,20},{-50,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(nOut, p1.f) annotation (Line(
      points={{-80,40},{-80,20},{-50,20}},
      color={255,0,255},
      smooth=Smooth.None));
  /* Equations */
  connect(and1.y, p1.u) annotation (Line(
      points={{15.6,-20},{0,-20},{0,20},{-30,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, and1.u2) annotation (Line(
      points={{-35.6,-40},{40,-40},{40,-23.2},{24.8,-23.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(loss.y, not1.u) annotation (Line(
      points={{-53.04,-40},{-44.8,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.powered, and1.u3) annotation (Line(
      points={{44,36},{44,-16.8},{24.8,-16.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.m, n) annotation (Line(
      points={{60,40},{80,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p2.m, load.f) annotation (Line(
      points={{20,40},{40,40}},
      color={255,0,255},
      smooth=Smooth.None));
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})),
              defaultComponentName="boost",Icon(graphics={Rectangle(
          extent={{-100,60},{100,-100}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}), Text(
          extent={{-100,8},{100,-54}},
          lineColor={0,0,255},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-112,68},{-48,26}},
          lineColor={0,0,255},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="+"),
        Rectangle(
          extent={{72,50},{88,46}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
                                  Diagram(graphics),
    Documentation(info="<html>
<p>This component represents a function which boosts a circuit potential to high level, when a low level is present and the boolean input is true. It is typically for use in fluid power systems, or other systems in which ground potential is less than low potential. In a pump the low potential at the intake avoids cavitation.</p>
<p>The only failure modes associated with this function is the loss of the function : in this state, the + connector behaves like a cap. If the device must behaves like a short circuit when no power is applied (for instance a centrifugal pump) it must be associed with a Link component in parallel.</p>
<p>Since this function delivers power and there is only one input, the input represents the availability of suitable power. </p>
</html>"));
end ControlledBooster;
