within EU_CleanSky.EDS.Electrical.DC;
model DCFunction "A generic PolarizedLoad repackaged to have a plug interface."

// Model parameters

  replaceable model GlobalShortToGroundLaw =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Law of probability of a global short circuit to the ground."                                                  annotation (Dialog(tab="Failure Modes",group="Probability Laws"));
  replaceable model OpenCircuitLaw =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Law of probability of an open circuit."                                                  annotation (Dialog(tab="Failure Modes",group="Probability Laws"));
  replaceable model InternalShortLaw =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Law of probability of an internal short circuit of the power supplies"                             annotation (Dialog(tab="Failure Modes",group="Probability Laws"));
  replaceable model ShortPlusToGroundLaw =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Law of probability of a short circuit of the power supply positive wire to the ground."
                                                                                              annotation (Dialog(tab="Failure Modes",group="Probability Laws"));
  replaceable model ShortMinusToGroundLaw =
      EU_CleanSky.EDS.SafetyLib.Internal.ProbabilityDistribution.Continuous.Exponential
    "Law of probability of a short circuit of the power supply negative wire to the ground. This failure may not have significant consequences if the negative polarity is at ground potential."
                                                                                                        annotation (Dialog(tab="Failure Modes",group="Probability Laws"));
  parameter Real lambdaGlobalShortToGround=0
    "Probability of occurrence of a short circuit connecting both + and - power supplies to the ground"
                                                                                                        annotation (Dialog(tab="Failure Modes",group="Failure Probabilities"));
  parameter Real lambdaOpenCircuit=0
    "Probability of the \"open circuit\" mode of failure."
    annotation (Dialog(tab="Failure Modes",group="Failure Probabilities"));
  parameter Real lambdaInternalShort=0
    "Probability of occurrence of a short circuit between the power supply + and - wires."
                                                                                          annotation (Dialog(tab="Failure Modes",group="Failure Probabilities"));
  parameter Real lambdaShortPlusToGround=0
    "Probability of occurence of a short circuit of the positive supply wire to the ground."
    annotation (Dialog(tab="Failure Modes",group="Failure Probabilities"));
  parameter Real lambdaShortMinusToGround=0
    "Probability of occurrence of a short circuit of the negative power supply wire to the electrical ground."
    annotation (Dialog(tab="Failure Modes",group="Failure Probabilities"));

  parameter Modelica.Blocks.Interfaces.BooleanOutput
    initialFailureShortToGround=false
    "The component initially has a global short circuit to the ground." annotation (Dialog(tab="Failure Modes", group="Initial Failures"));
  parameter Modelica.Blocks.Interfaces.BooleanOutput
    initialFailureOpenCircuit=false "The component initially is cut open."
                                           annotation (Dialog(tab="Failure Modes", group="Initial Failures"));
  parameter Modelica.Blocks.Interfaces.BooleanOutput
    initialFailureInternalShort=false
    "The component initially has a global internal short circuit."
    annotation (Dialog(tab="Failure Modes", group="Initial Failures"));
  parameter Modelica.Blocks.Interfaces.BooleanOutput
    initialFailureShortPlusToGround=false
    "Set this boolean in order to have an initial short circuit of the positive wire to the ground."
    annotation (Dialog(tab="Failure Modes", group="Initial Failures"));
  parameter Modelica.Blocks.Interfaces.BooleanOutput initialFailureShortMinusToGround=false
    "Set this to true if the component has an initial short circuit of the negative power supply to the ground."
    annotation (Dialog(tab="Failure Modes", group="Initial Failures"));

// Model connectors

  Electrical.DC.Interfaces.PlugM plug
     annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,30},{10,50}})));

// Internal components
  import EU_CleanSky.EDS.SafetyLib;

  SafetyLib.PolarisedLoad load(useLeak=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  SafetyLib.Link short(useOpen=true, useLeak=true)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  SafetyLib.Link shortPlus(useOpen=false, useLeak=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,42})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-34,14},{-22,26}})));
  SafetyLib.Split split annotation (Placement(transformation(
        extent={{10,-9.99998},{-9.99999,10}},
        rotation=90,
        origin={-40,70})));
  SafetyLib.Merge merge annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={40,70})));
  Modelica.Blocks.Interfaces.BooleanOutput functionPowered
    "The function is electrically powered."         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-106}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-44})));

  // Failure modes
  SafetyLib.FailureMode ShortToGround(lambda=lambdaGlobalShortToGround,
      redeclare model Law = GlobalShortToGroundLaw,
    initialFailure = initialFailureShortToGround)
    "Component is globally shorted to the ground."
    annotation (Placement(transformation(extent={{110,6},{50,66}})));
  SafetyLib.FailureMode openCircuit(lambda=lambdaOpenCircuit, redeclare model
      Law = OpenCircuitLaw,
    initialFailure = initialFailureOpenCircuit)
    "The electrical circuit is disconnected."
    annotation (Placement(transformation(extent={{-90,-50},{-30,10}})));
  SafetyLib.FailureMode InternalShort(lambda=lambdaInternalShort, redeclare
      model Law = InternalShortLaw,
    initialFailure = initialFailureInternalShort)
    "The supply wires are internally short-circuited."
    annotation (Placement(transformation(extent={{-90,-10},{-30,50}})));
  SafetyLib.FailureMode ShortMinusToGround(
    lambda=lambdaShortPlusToGround,
    redeclare model Law = ShortMinusToGroundLaw,
    initialFailure=initialFailureShortPlusToGround)
    "Power supply + wire is shorted to ground."
    annotation (Placement(transformation(extent={{110,-20},{50,40}})));
  SafetyLib.FailureMode ShortPlusToGround(lambda=lambdaShortMinusToGround,
      initialFailure=initialFailureShortPlusToGround)
    "A short circuit of the negative power supply wire to the ground."
    annotation (Placement(transformation(extent={{-110,10},{-50,70}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={-10,50})));
  SafetyLib.Link shortMinus(useLeak=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,20})));
equation
  connect(split.f2, short.m)
                            annotation (Line(
      points={{-32,70},{-21,70},{-21,70},{-10,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(openCircuit.y, load.open) annotation (Line(
      points={{-42.6,-20},{-2.3,-20},{-2.3,-4},{-2,-4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(InternalShort.y, not1.u) annotation (Line(
      points={{-42.6,20},{-35.2,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load.powered, functionPowered)
                                  annotation (Line(
      points={{6,4},{6,10},{20,10},{20,-80},{0,-80},{0,-106}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.m, plug.p) annotation (Line(
      points={{-40,80},{-40,100},{0,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(merge.f, plug.n) annotation (Line(
      points={{40,80},{40,100},{0,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(short.f, merge.m2) annotation (Line(
      points={{10,70},{32,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.y, short.open) annotation (Line(
      points={{-10,56.6},{-10,60},{-2,60},{-2,66}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, or1.u2) annotation (Line(
      points={{-21.4,20},{-14.8,20},{-14.8,42.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ShortToGround.y, or1.u1) annotation (Line(
      points={{62.6,36},{-10,36},{-10,42.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ShortToGround.y, short.leak) annotation (Line(
      points={{62.6,36},{2.3,36},{2.3,66},{2,66}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(shortMinus.f, merge.m1) annotation (Line(
      points={{40,30},{40,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(shortMinus.m, load.f) annotation (Line(
      points={{40,10},{40,0},{10,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ShortMinusToGround.y, shortMinus.leak) annotation (Line(
      points={{62.6,10},{54,10},{54,22},{44,22}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ShortPlusToGround.y, shortPlus.leak) annotation (Line(
      points={{-62.6,40},{-44,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split.f1, shortPlus.m) annotation (Line(
      points={{-40,60},{-40,56},{-40,56},{-40,52}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(shortPlus.f, load.m) annotation (Line(
      points={{-40,32},{-40,0},{-10,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={Rectangle(extent={{-100,40},{100,-40}},
            lineColor={0,255,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,32},{100,-6}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),      Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                              graphics={Text(
          extent={{-24,102},{-6,90}},
          lineColor={255,0,255},
          textString="+")}),
    Documentation(info="<html>
<p>This is a model of the electrical side of a DC powered function. The model includes the most common failure modes of electrical circuits:</p>
</html>"));
end DCFunction;
