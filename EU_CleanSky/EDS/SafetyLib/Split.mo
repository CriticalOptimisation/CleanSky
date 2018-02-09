within EU_CleanSky.EDS.SafetyLib;
model Split "A M-side connected to two F-sides"

  Interfaces.LogicFlowM m           annotation (Placement(transformation(extent={{-102,38},{-98,42}}),
        iconTransformation(extent={{-106,-6},{-94,6}})));
protected
  Internal.LogicPairM openM
    annotation (Placement(transformation(extent={{-82,138},{-78,142}})));
  Internal.LogicPairM leakM
    annotation (Placement(transformation(extent={{-82,98},{-78,102}})));
  Internal.LogicPairM revM
    annotation (Placement(transformation(extent={{-82,58},{-78,62}})));
  Internal.LogicPairM groundM
    annotation (Placement(transformation(extent={{-82,-22},{-78,-18}})));
  Internal.LogicPairM lowM
    annotation (Placement(transformation(extent={{-82,-62},{-78,-58}})));
  Internal.LogicPairM highM "P-side high logic pair internal connector."
    annotation (Placement(transformation(extent={{-82,18},{-78,22}})));
public
  Interfaces.LogicFlowF f2           annotation (Placement(transformation(extent={{98,98},{102,102}}),
        iconTransformation(extent={{-6,-86},{6,-74}})));
protected
  Internal.LogicPairF openF2
    annotation (Placement(transformation(extent={{78,148},{82,152}})));
  Internal.LogicPairF leakF2
    annotation (Placement(transformation(extent={{78,128},{82,132}})));
  Internal.LogicPairF revF2
    annotation (Placement(transformation(extent={{78,108},{82,112}})));
  Internal.LogicPairF highF2
    annotation (Placement(transformation(extent={{78,88},{82,92}})));
  Internal.LogicPairF groundF2
    annotation (Placement(transformation(extent={{78,68},{82,72}})));
  Internal.LogicPairF lowF2
    annotation (Placement(transformation(extent={{78,48},{82,52}})));
public
  Interfaces.LogicFlowF f1           annotation (Placement(transformation(extent={{98,-22},{102,-18}}),
        iconTransformation(extent={{94,-6},{106,6}})));
protected
  Internal.LogicPairF openF1
    annotation (Placement(transformation(extent={{78,28},{82,32}})));
  Internal.LogicPairF leakF1
    annotation (Placement(transformation(extent={{78,8},{82,12}})));
  Internal.LogicPairF revF1
    annotation (Placement(transformation(extent={{78,-12},{82,-8}})));
  Internal.LogicPairF highF1
    annotation (Placement(transformation(extent={{78,-32},{82,-28}})));
  Internal.LogicPairF groundF1
    annotation (Placement(transformation(extent={{78,-52},{82,-48}})));
  Internal.LogicPairF lowF1
    annotation (Placement(transformation(extent={{78,-72},{82,-68}})));
public
  Internal.OneToTwoOr oneToTwoOr1
    annotation (Placement(transformation(extent={{-54,90},{-34,110}})));
  Internal.OneToTwoAnd oneToTwoAnd
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
  Internal.AndOrP andor
    annotation (Placement(transformation(extent={{-34,54},{-46,66}})));
  Internal.AndOrN andor2
    annotation (Placement(transformation(extent={{14,104},{26,116}})));
  Internal.AndOrN andor3
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
        origin={-70,40})));
  Internal.AndOr andor6
    annotation (Placement(transformation(extent={{14,88},{26,100}})));
  Internal.AndOr andor7
    annotation (Placement(transformation(extent={{14,-32},{26,-20}})));
  Modelica.Blocks.Logical.Not notH1
    annotation (Placement(transformation(extent={{48,92},{36,104}})));
  Modelica.Blocks.Logical.Not notH2
    annotation (Placement(transformation(extent={{48,-28},{36,-16}})));
  Internal.AndOr andor8
    annotation (Placement(transformation(extent={{-34,18},{-46,30}})));
protected
  Boolean f1f2GroundXor "f1.ground.MtoF xor f2.ground.MtoF";
  Boolean f1mGroundXor "f1.ground.MtoF xor m.ground.FtoM";
  Boolean f2mGroundXor "f2.ground.MtoF xor m.ground.FtoM";
  Boolean tempM "Intermediate result for m.ground.MtoF";
  Boolean tempF1 "Intermediate result for f1.ground.FtoM";
  Boolean tempF2 "Intermediate result for f2.ground.FtoM";
  Boolean threeGround "True when all three ground inputs are true";
  Boolean f1f2PotentialXor "xor of high,low f1,f2 inputs";
  Boolean f1mPotentialXor "xor of high,low f1,m inputs";
  Boolean f2mPotentialXor "xor of high,low f2,m inputs;";

  function xor
    input Boolean u1;
    input Boolean u2;
    output Boolean y;
  algorithm
    y := (u1 and not u2) or (u2 and not u1);
    annotation(Inline=true);
  end xor;
initial equation
  pre(m.ground.FtoM)=false;
  pre(f1.ground.MtoF)=false;
  pre(f2.ground.MtoF)=false;
  pre(m.low.FtoM)=false;
  pre(f1.low.MtoF)=false;
  pre(f2.low.MtoF)=false;
  pre(m.high.FtoM)=false;
  pre(f1.high.MtoF)=false;
  pre(f2.high.MtoF)=false;
equation
  // Equations for ground propagation are complex and difficult to express graphically
  // because ground outputs depend on ground inputs, but also low and high inputs.

  // Three ground signals on inputs
  threeGround = pre(m.ground.FtoM) and pre(f1.ground.MtoF) and pre(f2.ground.MtoF);
  // simple propagation and three ground exception
  tempM  = ((f1.ground.MtoF or f2.ground.MtoF) and not pre(m.ground.FtoM)) or threeGround;
  tempF1 = ((m.ground.FtoM or pre(f2.ground.MtoF)) and not pre(f1.ground.MtoF)) or threeGround;
  tempF2 = ((m.ground.FtoM or pre(f1.ground.MtoF)) and not pre(f2.ground.MtoF)) or threeGround;
  // xor of ground inputs
  f1f2GroundXor = xor(f1.ground.MtoF,f2.ground.MtoF);
  f1mGroundXor  = xor(pre(f1.ground.MtoF),m.ground.FtoM);
  f2mGroundXor  = xor(pre(f2.ground.MtoF),m.ground.FtoM);
  // xor of potential inputs
  f1f2PotentialXor = xor(f1.low.MtoF,f2.low.MtoF) or xor(f1.high.MtoF,f2.high.MtoF);
  f1mPotentialXor  = xor(pre(f1.low.MtoF),m.low.FtoM) or xor(pre(f1.high.MtoF),m.high.FtoM);
  f2mPotentialXor  = xor(pre(f2.low.MtoF),m.low.FtoM) or xor(pre(f2.high.MtoF),m.high.FtoM);
  // exceptions: ground is set on output in aa few other cases
  m.ground.MtoF  = tempM  or (pre(m.ground.FtoM)  and f1f2GroundXor and f1f2PotentialXor and not xor(pre(m.low.FtoM) or pre(m.high.FtoM),f1f2GroundXor));
  f1.ground.FtoM = tempF1 or (pre(f1.ground.MtoF) and f2mGroundXor  and f2mPotentialXor  and not xor(pre(f1.low.MtoF) or pre(f1.high.MtoF), f2mGroundXor));
  f2.ground.FtoM = tempF2 or (pre(f2.ground.MtoF) and f1mGroundXor  and f1mPotentialXor  and not xor(pre(f2.low.MtoF) or pre(f2.high.MtoF), f1mGroundXor));
  connect(m.high,highM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.ground,groundM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,-20},{-80,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.low,lowM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,-60},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.reverse,revM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.leak,leakM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,100},{-80,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(m.open,openM)  annotation (Line(
      points={{-100,40},{-90,40},{-90,140},{-80,140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f2.open,openF2)
                         annotation (Line(
      points={{100,100},{90,100},{90,150},{80,150}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakF2,f2. leak)
                         annotation (Line(
      points={{80,130},{90,130},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF2,f2. high)
                         annotation (Line(
      points={{80,90},{90,90},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundF2,f2. ground)
                             annotation (Line(
      points={{80,70},{90,70},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF2,f2. low)
                       annotation (Line(
      points={{80,50},{90,50},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revF2,f2. reverse)
                           annotation (Line(
      points={{80,110},{90,110},{90,100},{100,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f1.open,openF1)
                         annotation (Line(
      points={{100,-20},{90,-20},{90,30},{80,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakF1,f1. leak)
                         annotation (Line(
      points={{80,10},{90,10},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF1,f1. high)
                         annotation (Line(
      points={{80,-30},{90,-30},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(groundF1,f1. ground)
                             annotation (Line(
      points={{80,-50},{90,-50},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF1,f1. low)
                       annotation (Line(
      points={{80,-70},{90,-70},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(revF1,f1. reverse)
                           annotation (Line(
      points={{80,-10},{90,-10},{90,-20},{100,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(leakM, oneToTwoOr1.m) annotation (Line(
      points={{-80,100},{-54,100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoOr1.f1,leakF1)  annotation (Line(
      points={{-34,96},{-24,96},{-24,10},{80,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoOr1.f2,leakF2)  annotation (Line(
      points={{-34,104},{-24,104},{-24,130},{80,130}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoAnd.m,openM)  annotation (Line(
      points={{-54,140},{-80,140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoAnd.f2,openF2)  annotation (Line(
      points={{-34,144},{-22,144},{-22,150},{80,150}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(oneToTwoAnd.f1,openF1)  annotation (Line(
      points={{-34,136},{-22,136},{-22,30},{80,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(H3.u2,highF1. MtoF) annotation (Line(
      points={{7.2,-84.8},{66,-84.8},{66,-30},{80,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF2.MtoF, H3.u1) annotation (Line(
      points={{80,90},{64,90},{64,-80},{7.2,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF2.MtoF, L3.u1) annotation (Line(
      points={{80,50},{68,50},{68,-100},{7.2,-100}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowF1.MtoF, L3.u2) annotation (Line(
      points={{80,-70},{70,-70},{70,-104.8},{7.2,-104.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Lside.u2,lowF1. MtoF) annotation (Line(
      points={{7.2,-144.8},{70,-144.8},{70,-70},{80,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Lside.u1,lowF2. MtoF) annotation (Line(
      points={{7.2,-140},{68,-140},{68,50},{80,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF1.MtoF, Hside.u2) annotation (Line(
      points={{80,-30},{66,-30},{66,-124.8},{7.2,-124.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highF2.MtoF, Hside.u1) annotation (Line(
      points={{80,90},{64,90},{64,-120},{7.2,-120}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(H3.u3,highM. FtoM) annotation (Line(
      points={{7.2,-75.2},{14,-75.2},{14,-56},{-48,-56},{-48,-36},{-68,-36},{
          -68,20},{-80,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Hside.u3,highM. FtoM) annotation (Line(
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
  connect(lowM.FtoM, Lside.u3) annotation (Line(
      points={{-80,-60},{12,-60},{12,-135.2},{7.2,-135.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lowM.FtoM, L3.u3) annotation (Line(
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
  connect(notL3.y, andor.u2) annotation (Line(
      points={{-46.6,-100},{-52,-100},{-52,-62},{2,-62},{2,55.56},{-32.8,
          55.56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,64.44},{-32.8,64.44}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(revM, andor.m) annotation (Line(
      points={{-80,60},{-63,60},{-63,59.88},{-46,59.88}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor2.f,revF2)  annotation (Line(
      points={{26,109.88},{64,109.88},{64,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH3.y, andor2.u2) annotation (Line(
      points={{-46.6,-80},{-50,-80},{-50,-64},{4,-64},{4,105.56},{12.8,105.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(preL3.y, andor2.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,114.44},{12.8,
          114.44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor3.f,revF1)  annotation (Line(
      points={{26,-10.12},{64,-10.12},{64,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.y, andor3.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-66},{6,-66},{6,-5.56},{12.8,-5.56}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(notH3.y, andor3.u2) annotation (Line(
      points={{-46.6,-80},{-50,-80},{-50,-64},{4,-64},{4,-14.44},{12.8,-14.44}},
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
  connect(noRevPin.u,revM. FtoM) annotation (Line(
      points={{-70,47.2},{-70,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(noRevPin.y, andor1.u1) annotation (Line(
      points={{-70,33.4},{-70.04,33.4},{-70.04,-70.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preLside.y, andor1.u2) annotation (Line(
      points={{-26.6,-140},{-78.44,-140},{-78.44,-85.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor1.y,lowM. MtoF) annotation (Line(
      points={{-77.96,-70.8},{-77.96,-68.4},{-80,-68.4},{-80,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preL3.y, andor1.u3) annotation (Line(
      points={{-26.6,-100},{-30,-100},{-30,-90},{-69.56,-90},{-69.56,-85.2}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(lowF1.FtoM, andor5.y) annotation (Line(
      points={{80,-70},{40,-70},{40,-45.96},{27.2,-45.96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor5.u1,revF1. MtoF) annotation (Line(
      points={{27.2,-38.04},{56,-38.04},{56,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor4.y,lowF2. FtoM) annotation (Line(
      points={{27.2,50.04},{53.6,50.04},{53.6,50},{80,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor4.u1,revF2. MtoF) annotation (Line(
      points={{27.2,57.96},{56,57.96},{56,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(andor6.y,highF2. FtoM) annotation (Line(
      points={{27.2,90.04},{53.6,90.04},{53.6,90},{80,90}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor6.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,98.44},{12.8,98.44}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(andor7.y,highF1. FtoM) annotation (Line(
      points={{27.2,-29.96},{53.6,-29.96},{53.6,-30},{80,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH1.u,revF2. MtoF) annotation (Line(
      points={{49.2,98},{56,98},{56,110},{80,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH1.y, andor6.u1) annotation (Line(
      points={{35.4,98},{31.3,98},{31.3,97.96},{27.2,97.96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH2.u,revF1. MtoF) annotation (Line(
      points={{49.2,-22},{56,-22},{56,-10},{80,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(notH2.y, andor7.u1) annotation (Line(
      points={{35.4,-22},{31.3,-22},{31.3,-22.04},{27.2,-22.04}},
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

  connect(andor8.u1,revM. FtoM) annotation (Line(
      points={{-47.2,27.96},{-60,27.96},{-60,60},{-80,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(highM.MtoF, andor8.y) annotation (Line(
      points={{-80,20},{-63.6,20},{-63.6,20.04},{-47.2,20.04}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preHside.y, andor8.u2) annotation (Line(
      points={{-26.6,-120},{-54,-120},{-54,-58},{0,-58},{0,19.56},{-32.8,19.56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(preH3.y, andor8.u3) annotation (Line(
      points={{-26.6,-80},{-28,-80},{-28,-68},{8,-68},{8,28.44},{-32.8,28.44}},
      color={255,0,255},
      smooth=Smooth.None));

  annotation (defaultComponentName="split",
        Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-150},{
            100,150}}),             graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,-40},{-100,40},{100,40},{100,-40},{40,-40},{40,-80},{-40,-80},{
              -40,-40},{-60,-40},{-100,-40}},
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
<p>Merge and Split allow arbitrary graph topologies for system architectures. Unlike all the other components of the library, these have 3 ports. Unlike the standard two-port link component Merge and Split cannot leak, because the effect of a leak would depend on which branch is affected. If the failure mode is needed, Split should be combined with Link elements on each branch which can leak.Split and Marge are key to the correct simulation of the functional behaviour of non trivial system architectures.</p>
</html>"));
end Split;
