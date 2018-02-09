within EU_CleanSky.EDS.SafetyLib.Internal;
model GenderChangerF
  "A female-female dipole used to change the gender when needed. Use with moderation."

  Interfaces.LogicFlowF f annotation (Placement(transformation(extent={{-102,-2},
            {-98,2}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.LogicFlowF f1 annotation (Placement(transformation(extent={{98,-2},
            {102,2}}), iconTransformation(extent={{90,-8},{110,12}})));
protected
  encapsulated model PairGenderChanger
    "A male-male dipole used to change the gender in a LogicPair. Internal use only."
    import LogicPairN = EU_CleanSky.EDS.SafetyLib.Internal.LogicPairF;
    import EU_CleanSky.EDS.SafetyLib;
    SafetyLib.Internal.LogicPairF
               f annotation (Placement(transformation(extent={{-86,-6},{-74,6}}),
          iconTransformation(extent={{-90,-10},{-110,10}})));
    SafetyLib.Internal.LogicPairF
               f1 annotation (Placement(transformation(extent={{86,-6},{74,6}}),
          iconTransformation(extent={{90,-10},{110,10}})));
  equation

    connect(f.FtoM,f1.MtoF) annotation (Line(
        points={{-80,0},{-80,40},{80,40},{80,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(f.MtoF,f1.FtoM) annotation (Line(
        points={{-80,0},{-80,-40},{80,-40},{80,0}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Icon(graphics={Rectangle(
            extent={{-100,60},{100,-60}},
            lineColor={255,0,255},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={175,175,175}), Text(
            extent={{-96,24},{94,-18}},
            lineColor={0,0,255},
            textString="%name")}),      Diagram(graphics));
  end PairGenderChanger;
  PairGenderChanger high annotation (Placement(transformation(extent={{-10,38},
            {10,62}})));

  PairGenderChanger low  annotation (Placement(transformation(extent={{-10,18},
            {10,42}})));
  PairGenderChanger leak annotation (Placement(transformation(extent={{-10,-2},
            {10,22}})));
  PairGenderChanger open annotation (Placement(transformation(extent={{-10,-22},
            {10,2}})));
  PairGenderChanger reverse
                         annotation (Placement(transformation(extent={{-10,-42},
            {10,-18}})));
  PairGenderChanger ground
                         annotation (Placement(transformation(extent={{-10,-62},
            {10,-38}})));
equation
  connect(f.high, high.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,50},{-10,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.low, low.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,30},{-10,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.leak, leak.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,10},{-10,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.open, open.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,-10},{-10,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.reverse, reverse.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,-30},{-10,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.ground, ground.f) annotation (Line(
      points={{-100,0},{-56,0},{-56,-50},{-10,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(high.f1,f1. high) annotation (Line(
      points={{10,50},{56,50},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(low.f1,f1. low) annotation (Line(
      points={{10,30},{56,30},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leak.f1,f1. leak) annotation (Line(
      points={{10,10},{56,10},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(open.f1,f1. open) annotation (Line(
      points={{10,-10},{56,-10},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(reverse.f1,f1. reverse) annotation (Line(
      points={{10,-30},{56,-30},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ground.f1,f1. ground) annotation (Line(
      points={{10,-50},{56,-50},{56,0},{100,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={175,175,175})}), Diagram(graphics));
end GenderChangerF;
