within EU_CleanSky.EDS.Utilities.OptimisedSplit.Examples;
model SimpleExample
  "A high power circuit modelled as a single resistor is really two independent circuits, with distinct sources"
  extends Modelica.Icons.Example;
  MergedPower mergedPower(            n=3,
    weights={1,1,1},
    corrType=0)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.729)
                                                     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{30,-36},{50,-16}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=270)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,30})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=271)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=272)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
equation
  connect(mergedPower.n2, resistor.n) annotation (Line(
      points={{50,5},{54,5},{54,6},{60,6},{60,20},{80,20},{80,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mergedPower.p2, resistor.p) annotation (Line(
      points={{50,-5},{54,-5},{54,-6},{60,-6},{60,-20},{80,-20},{80,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, mergedPower.gnd) annotation (Line(
      points={{40,-16},{40,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, mergedPower.p1[1]) annotation (Line(
      points={{-40,40},{0,40},{0,4.33333},{30,4.33333}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(constantVoltage.n, mergedPower.n1[1]) annotation (Line(
      points={{-40,20},{-2,20},{-2,-5.66667},{30,-5.66667}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(constantVoltage1.p, mergedPower.p1[2]) annotation (Line(
      points={{-40,10},{-4,10},{-4,5},{30,5}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(constantVoltage1.n, mergedPower.n1[2]) annotation (Line(
      points={{-40,-10},{-4,-10},{-4,-5},{30,-5}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(constantVoltage2.p, mergedPower.p1[3]) annotation (Line(
      points={{-40,-20},{-8,-20},{-8,5.66667},{30,5.66667}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(constantVoltage2.n, mergedPower.n1[3]) annotation (Line(
      points={{-40,-40},{-6,-40},{-6,-4.33333},{30,-4.33333}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(ground1.p, constantVoltage2.n) annotation (Line(
      points={{-60,-40},{-50,-40},{-50,-40},{-40,-40}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(ground1.p, constantVoltage1.n) annotation (Line(
      points={{-60,-40},{-60,-10},{-40,-10}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(ground1.p, constantVoltage.n) annotation (Line(
      points={{-60,-40},{-60,20},{-40,20}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<p>L&apos;exemple doit &ecirc;tre utilis&eacute; pour valider compl&egrave;tement le composant MergerPower, et ses principaux constituants que sont PowerShareCalc et Min.</p>
<p>On peut d&eacute;river les cas tests de l&apos;exemple ou les faire manuellement. Dans les deux cas, les param&egrave;tres de l&apos;exemple sont:</p>
<p><ul>
<li>Les trois tensions d&apos;alimentations constantVoltage.V, constantVoltage1.V, constantVoltage2.V</li>
<li>Les trois poids mergedPower.weights[1:3]</li>
<li>Le type de correction appliqu&eacute; &agrave; la pond&eacute;ration mergedPower.corrType</li>
</ul></p>
<p>Cas &agrave; valider:</p>
<p><ul>
<li>Dans tous les exemples, la tension min retenue par le composant Min est 270V, donc la puissance totalPwr doit &ecirc;tre exactement 100kW.</li>
<li>270,270,270, {1,1,1}, corrType=X  --&GT; i1=i2=i3=123.4567A</li>
<li>270,271,272, {1,1,1}, corrType=1 --&GT; i1 &LT; i2 &LT; i3</li>
<li>Avec corrType=0, la puissance est r&eacute;partie selon la pond&eacute;ration donc le courant varie en proportion inverse.</li>
<li>270,271,272, {1,1,1}, corrType=0 --&GT; i3 &LT; i2 &LT; i1 = 123.4567A</li>
<li>V&eacute;rifier qu&apos;une pond&eacute;ration mise z&eacute;ro supprime toute influence de la tension concern&eacute;e sur le r&eacute;sultat:</li>
<li>270,271,X, {1,1,0}, corrType=X --&GT; toujours le m&ecirc;me r&eacute;sultat</li>
<li>Valider la prise en compte de poids n&eacute;gatifs, assimil&eacute;s &agrave; des poids nuls:</li>
<li>270,271,X, {1,1,-1}, corrType=X --&GT; toujours le m&ecirc;me r&eacute;sultat</li>
<li>Valider l&apos;absence d&apos;erreur quand la tension est nulle, avec pond&eacute;ration nulle ou non nulle</li>
<li>270,270,0, {1,1,1}, corrType=X --&GT; dans ce cas totalPwr = 0kW car la tension la plus basse avec un poids non nul est 0V, i1=i2=i3=0A</li>
<li>270,270,0, {1,1,0}, corrType=X --&GT; i1=i2=185.185A i3=0A </li>
</ul></p>
</html>"));
end SimpleExample;
