within EU_CleanSky.EDS.SafetyLib;
model Merge "Two P-sides connected to a N-side"

  Interfaces.LogicFlowF f           annotation (Placement(transformation(extent={{-102,38},{-98,42}}),
        iconTransformation(extent={{-106,-6},{-94,6}})));
protected
  Internal.LogicPairF openF
    annotation (Placement(transformation(extent={{-82,138},{-78,142}})));
  Internal.LogicPairF leakF
    annotation (Placement(transformation(extent={{-82,98},{-78,102}})));
  Internal.LogicPairF revF
    annotation (Placement(transformation(extent={{-82,58},{-78,62}})));
  Internal.LogicPairF groundF
    annotation (Placement(transformation(extent={{-82,-22},{-78,-18}})));
  Internal.LogicPairF lowF
    annotation (Placement(transformation(extent={{-82,-62},{-78,-58}})));
  Internal.LogicPairF highF "P-side high logic pair internal connector."
    annotation (Placement(transformation(extent={{-82,18},{-78,22}})));
public
  Interfaces.LogicFlowM m2           annotation (Placement(transformation(extent={{98,98},{102,102}}),
        iconTransformation(extent={{-6,74},{6,86}})));
protected
  Internal.LogicPairM openM2
    annotation (Placement(transformation(extent={{82,148},{78,152}})));
  Internal.LogicPairM leakM2
    annotation (Placement(transformation(extent={{82,128},{78,132}})));
  Internal.LogicPairM revM2
    annotation (Placement(transformation(extent={{82,108},{78,112}})));
  Internal.LogicPairM highM2
    annotation (Placement(transformation(extent={{82,88},{78,92}})));
  Internal.LogicPairM groundM2
    annotation (Placement(transformation(extent={{82,68},{78,72}})));
  Internal.LogicPairM lowM2
    annotation (Placement(transformation(extent={{82,48},{78,52}})));
public
  Interfaces.LogicFlowM m1           annotation (Placement(transformation(extent={{98,-22},{102,-18}}),
        iconTransformation(extent={{94,-6},{106,6}})));
protected
  Internal.LogicPairM openM1
    annotation (Placement(transformation(extent={{82,28},{78,32}})));
  Internal.LogicPairM leakM1
    annotation (Placement(transformation(extent={{82,8},{78,12}})));
  Internal.LogicPairM revM1
    annotation (Placement(transformation(extent={{82,-12},{78,-8}})));
  Internal.LogicPairM highM1
    annotation (Placement(transformation(extent={{82,-32},{78,-28}})));
  Internal.LogicPairM groundM1
    annotation (Placement(transformation(extent={{82,-52},{78,-48}})));
  Internal.LogicPairM lowM1
    annotation (Placement(transformation(extent={{82,-72},{78,-68}})));
public
  Internal.TwoToOneOr oneToTwoOr1
    annotation (Placement(transformation(extent={{-54,90},{-34,110}})));
  Internal.TwoToOneAnd oneToTwoAnd
    annotation (Placement(transformation(extent={{-54,130},{-34,150}})));
  Internal.And3 H3 "three high in"
    annotation (Placement(transformation(extent={{6,-86},{-6,-74}})));
  Internal.And3 L3 "three low in"
    annotation (Placement(transformation(extent={{6,-106},{-6,-94}})));
  Internal.Or3 Lside
    annotation (Placement(transformation(extent={{6,-146},{-6,-134}})));
  Internal.Or3 Hside
    annotation (Placement(transformation(extent={{6,-126},{-6,-114}})));
  Modelica.Blocks.Logical.Pre preH3
    annotation (Placement(transformation(extent={{-14,-86},{-26,-74}})));
  Modelica.Blocks.Logical.Pre preL3
    annotation (Placement(transformation(extent={{-14,-106},{-26,-94}})));
  Modelica.Blocks.Logical.Pre preHside
    annotation (Placement(transformation(extent={{-14,-126},{-26,-114}})));
  Modelica.Blocks.Logical.Pre preLside
    annotation (Placement(transformation(extent={{-14,-146},{-26,-134}})));
  Modelica.Blocks.Logical.Not notH3
    annotation (Placement(transformation(extent={{-34,-86},{-46,-74}})));
  Modelica.Blocks.Logical.Not notL3
    annotation (Placement(transformation(extent={{-34,-106},{-46,-94}})));
  Internal.AndOrN           andor
    annotation (Placement(transformation(extent={{-34,54},{-46,66}})));
  Internal.AndOrP andor2
    annotation (Placement(transformation(extent={{14,104},{26,116}})));
  Internal.AndOrP andor3
    annotation (Placement(transformation(extent={{14,-16},{26,-4}})));
  Internal.AndOr andor4
    annotation (Placement(transformation(extent={{14,48},{26,60}})));
  Internal.AndOr andor5
    annotation (Placement(transformation(extent={{14,-48},{26,-36}})));
  Internal.AndOr andor1 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-74,-78})));
  Modelica.Blocks.Logical.Not noRevPin
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-60,40})));
  Internal.AndOr andor6
    annotation (Placement(transformation(extent={{14,88},{26,100}})));
  Internal.AndOr andor7
    annotation (Placement(transformation(extent={{14,-32},{26,-20}})));
  Modelica.Blocks.Logical.Not notH1
    annotation (Placement(transformation(extent={{48,52},{36,64}})));
  Modelica.Blocks.Logical.Not notH2
    annotation (Placement(transformation(extent={{48,-44},{36,-32}})));
  Internal.AndOr andor8
    annotation (Placement(transformation(extent={{-34,18},{-46,30}})));
protected
  Boolean f1f2GroundXor "n1.ground.MtoF xor n2.ground.MtoF";
  Boolean f1mGroundXor "n1.ground.MtoF xor p.ground.FtoM";
  Boolean f2mGroundXor "n2.ground.MtoF xor p.ground.FtoM";
  Boolean tempM "Intermediate result for p.ground.MtoF";
  Boolean tempF1 "Intermediate result for n1.ground.FtoM";
  Boolean tempF2 "Intermediate result for n2.ground.FtoM";
  Boolean threeGround "True when all three ground inputs are true";
  Boolean f1f2PotentialXor "xor of high,low n1,n2 inputs";
  Boolean f1mPotentialXor "xor of high,low n1,p inputs";
  Boolean f2mPotentialXor "xor of high,low n2,p inputs;";

  function xor
    input Boolean u1;
    input Boolean u2;
    output Boolean y;
  algorithm
    y := (u1 and not u2) or (u2 and not u1);
    annotation(Inline=true);
  end xor;
initial equation
  pre(f.ground.MtoF)=false;
  pre(m1.ground.FtoM)=false;
  pre(m2.ground.FtoM)=false;
  pre(f.low.MtoF)=false;
  pre(m1.low.FtoM)=false;
  pre(m2.low.FtoM)=false;
  pre(f.high.MtoF)=false;
  pre(m1.high.FtoM)=false;
  pre(m2.high.FtoM)=false;
equation
  // Equations for ground propagation are complex and difficult to express graphically
  // because ground outputs depend on ground inputs, but also low and high inputs.

  // Three ground signals on inputs
  threeGround = pre(f.ground.MtoF) and pre(m1.ground.FtoM) and pre(m2.ground.FtoM);
  // simple propagation and three ground exception
  tempM  = ((m1.ground.FtoM or m2.ground.FtoM) and not pre(f.ground.MtoF)) or threeGround;
  tempF1 = ((f.ground.MtoF or pre(m2.ground.FtoM)) and not pre(m1.ground.FtoM)) or threeGround;
  tempF2 = ((f.ground.MtoF or pre(m1.ground.FtoM)) and not pre(m2.ground.FtoM)) or threeGround;
  // xor of ground inputs
  f1f2GroundXor = xor(m1.ground.FtoM,m2.ground.FtoM);
  f1mGroundXor  = xor(pre(m1.ground.FtoM),f.ground.MtoF);
  f2mGroundXor  = xor(pre(m2.ground.FtoM),f.ground.MtoF);
  // xor of potential inputs
  f1f2PotentialXor = xor(m1.low.FtoM,m2.low.FtoM) or xor(m1.high.FtoM,m2.high.FtoM);
  f1mPotentialXor  = xor(pre(m1.low.FtoM),f.low.MtoF) or xor(pre(m1.high.FtoM),f.high.MtoF);
  f2mPotentialXor  = xor(pre(m2.low.FtoM),f.low.MtoF) or xor(pre(m2.high.FtoM),f.high.MtoF);
  // exceptions: ground is set on output in aa few other cases
  f.ground.FtoM  = tempM  or (pre(f.ground.MtoF)  and f1f2GroundXor and f1f2PotentialXor and not xor(pre(f.low.MtoF) or pre(f.high.MtoF),f1f2GroundXor));
  m1.ground.MtoF = tempF1 or (pre(m1.ground.FtoM) and f2mGroundXor  and f2mPotentialXor  and not xor(pre(m1.low.FtoM) or pre(m1.high.FtoM), f2mGroundXor));
  m2.ground.MtoF = tempF2 or (pre(m2.ground.FtoM) and f1mGroundXor  and f1mPotentialXor  and not xor(pre(m2.low.FtoM) or pre(m2.high.FtoM), f1mGroundXor));
  connect(f.high,highF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.ground,groundF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,-20},{-80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.low,lowF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,-60},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.reverse,revF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.leak,leakF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,100},{-80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.open,openF)  annotation (Line(
      points={{-100,40},{-90,40},{-90,140},{-80,140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m2.open,openM2)
                         annotation (Line(
      points={{100,100},{90,100},{90,150},{80,150}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakM2,m2. leak)
                         annotation (Line(
      points={{80,130},{90,130},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM2,m2. high)
                         annotation (Line(
      points={{80,90},{90,90},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundM2,m2. ground)
                             annotation (Line(
      points={{80,70},{90,70},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM2,m2. low)
                       annotation (Line(
      points={{80,50},{90,50},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revM2,m2. reverse)
                           annotation (Line(
      points={{80,110},{90,110},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m1.open,openM1)
                         annotation (Line(
      points={{100,-20},{90,-20},{90,30},{80,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakM1,m1. leak)
                         annotation (Line(
      points={{80,10},{90,10},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM1,m1. high)
                         annotation (Line(
      points={{80,-30},{90,-30},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundM1,m1. ground)
                             annotation (Line(
      points={{80,-50},{90,-50},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM1,m1. low)
                       annotation (Line(
      points={{80,-70},{90,-70},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revM1,m1. reverse)
                           annotation (Line(
      points={{80,-10},{90,-10},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(H3.u2,highM1.FtoM) annotation (Line(
      points={{7.2,-84.8},{66,-84.8},{66,-30},{80,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM2.FtoM, H3.u1) annotation (Line(
      points={{80,90},{64,90},{64,-80},{7.2,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM2.FtoM, L3.u1) annotation (Line(
      points={{80,50},{68,50},{68,-100},{7.2,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM1.FtoM, L3.u2) annotation (Line(
      points={{80,-70},{70,-70},{70,-104.8},{7.2,-104.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Lside.u2,lowM1.FtoM) annotation (Line(
      points={{7.2,-144.8},{70,-144.8},{70,-70},{80,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Lside.u1,lowM2.FtoM) annotation (Line(
      points={{7.2,-140},{68,-140},{68,50},{80,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM1.FtoM, Hside.u2) annotation (Line(
      points={{80,-30},{66,-30},{66,-124.8},{7.2,-124.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM2.FtoM, Hside.u1) annotation (Line(
      points={{80,90},{64,90},{64,-120},{7.2,-120}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(H3.u3,highF.MtoF) annotation (Line(
      points={{7.2,-75.2},{14,-75.2},{14,-56},{-48,-56},{-48,-36},{-68,-36},{
          -68,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Hside.u3,highF.MtoF) annotation (Line(
      points={{7.2,-115.2},{14,-115.2},{14,-56},{-48,-56},{-48,-36},{-68,-36},{
          -68,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preLside.u, Lside.y) annotation (Line(
      points={{-12.8,-140},{-6.6,-140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preHside.u, Hside.y) annotation (Line(
      points={{-12.8,-120},{-6.6,-120}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.u, L3.y) annotation (Line(
      points={{-12.8,-100},{-6.6,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF.MtoF, Lside.u3) annotation (Line(
      points={{-80,-60},{12,-60},{12,-135.2},{7.2,-135.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF.MtoF, L3.u3) annotation (Line(
      points={{-80,-60},{12,-60},{12,-95.2},{7.2,-95.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.u, H3.y) annotation (Line(
      points={{-12.8,-80},{-6.6,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH3.u, preH3.y) annotation (Line(
      points={{-32.8,-80},{-26.6,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notL3.u, preL3.y) annotation (Line(
      points={{-32.8,-100},{-26.6,-100}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preL3.y, andor4.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,58.44},{12.8,58.44}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preLside.y, andor4.u2) annotation (Line(
      points={{-26.6,-140},{-56,-140},{-56,-46},{-2,-46},{-2,49.56},{12.8,
          49.56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preLside.y, andor5.u2) annotation (Line(
      points={{-26.6,-140},{-56,-140},{-56,-46.44},{12.8,-46.44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.y, andor5.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,-37.56},{12.8,
          -37.56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(noRevPin.u,revF.MtoF) annotation (Line(
      points={{-60,47.2},{-60,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preLside.y, andor1.u2) annotation (Line(
      points={{-26.6,-140},{-78.44,-140},{-78.44,-85.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor1.y,lowF.FtoM) annotation (Line(
      points={{-77.96,-70.8},{-77.96,-68.4},{-80,-68.4},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.y, andor1.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-90},{-69.56,-90},{-69.56,-85.2}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(lowM1.MtoF, andor5.y) annotation (Line(
      points={{80,-70},{40,-70},{40,-45.96},{27.2,-45.96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor4.y,lowM2.MtoF) annotation (Line(
      points={{27.2,50.04},{53.6,50.04},{53.6,50},{80,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor6.y,highM2.MtoF) annotation (Line(
      points={{27.2,90.04},{53.6,90.04},{53.6,90},{80,90}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor6.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,98.44},{12.8,98.44}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(andor7.y,highM1.MtoF) annotation (Line(
      points={{27.2,-29.96},{53.6,-29.96},{53.6,-30},{80,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH1.u,revM2.FtoM) annotation (Line(
      points={{49.2,58},{56,58},{56,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH2.u,revM1.FtoM) annotation (Line(
      points={{49.2,-38},{56,-38},{56,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor6.u2, preHside.y) annotation (Line(
      points={{12.8,89.56},{0,89.56},{0,-58},{-54,-58},{-54,-120},{-26.6,-120}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preHside.y, andor7.u2) annotation (Line(
      points={{-26.6,-120},{-54,-120},{-54,-58},{0,-58},{0,-30.44},{12.8,-30.44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor7.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,-21.56},{12.8,-21.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(highF.FtoM, andor8.y) annotation (Line(
      points={{-80,20},{-63.6,20},{-63.6,20.04},{-47.2,20.04}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preHside.y, andor8.u2) annotation (Line(
      points={{-26.6,-120},{-54,-120},{-54,-58},{0,-58},{0,19.56},{-32.8,19.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(leakF, oneToTwoOr1.f) annotation (Line(
      points={{-80,100},{-54,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoOr1.m2,leakM2)  annotation (Line(
      points={{-34,104},{-24,104},{-24,130},{80,130}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakM1, oneToTwoOr1.m1) annotation (Line(
      points={{80,10},{-24,10},{-24,96},{-34,96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(openF, oneToTwoAnd.f) annotation (Line(
      points={{-80,140},{-54,140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoAnd.m1,openM1)  annotation (Line(
      points={{-34,136},{-22,136},{-22,30},{80,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoAnd.m2,openM2)  annotation (Line(
      points={{-34,144},{-22,144},{-22,150},{80,150}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor2.m,revM2)  annotation (Line(
      points={{26,109.88},{54,109.88},{54,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor3.m,revM1)  annotation (Line(
      points={{26,-10.12},{54,-10.12},{54,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revF, andor.f) annotation (Line(
      points={{-80,60},{-59,60},{-59,59.88},{-46,59.88}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH2.y, andor5.u1) annotation (Line(
      points={{35.4,-38},{31.3,-38},{31.3,-38.04},{27.2,-38.04}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor7.u1,revM1. FtoM) annotation (Line(
      points={{27.2,-22.04},{56,-22.04},{56,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH1.y, andor4.u1) annotation (Line(
      points={{35.4,58},{31.3,58},{31.3,57.96},{27.2,57.96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor6.u1,revM2. FtoM) annotation (Line(
      points={{27.2,97.96},{56,97.96},{56,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(noRevPin.y, andor8.u1) annotation (Line(
      points={{-60,33.4},{-60,27.96},{-47.2,27.96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor1.u1,revF. MtoF) annotation (Line(
      points={{-70.04,-70.8},{-70.04,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notL3.y, andor3.u2) annotation (Line(
      points={{-46.6,-100},{-52,-100},{-52,-62},{2,-62},{2,-14.44},{12.8,
          -14.44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH3.y, andor.u2) annotation (Line(
      points={{-46.6,-80},{-50,-80},{-50,-64},{4,-64},{4,55.56},{-32.8,55.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(notL3.y, andor2.u2) annotation (Line(
      points={{-46.6,-100},{-52,-100},{-52,-62},{2,-62},{2,105.56},{12.8,
          105.56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor2.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,114.44},{12.8,114.44}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preH3.y, andor3.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,-5.56},{12.8,-5.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preL3.y, andor8.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,28.44},{-32.8,28.44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.y, andor.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,64.44},{-32.8,
          64.44}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (defaultComponentName="merge",
        Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-150},{
            100,150}}),             graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,40},{-100,-40},{100,-40},{100,40},{40,40},{40,80},{-40,80},
              {-40,40},{-60,40},{-100,40}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-130,34},{130,-24}},
          textString="%name",
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,127,0})}),
    Documentation(info="<html>
<p>Merge and Split allow arbitrary graph topologies for system architectures. Unlike all the other components of the library, these have 3 ports. Unlike the standard two-port link component Merge and Split cannot leak, because the effect of a leak would depend on which branch is affected. If the failure mode is needed, Merge should be combined with Link elements on each branch which can leak.Split and Marge are key to the correct simulation of the functional behaviour of non trivial system architectures.</p>
</html>"));
end Merge;
