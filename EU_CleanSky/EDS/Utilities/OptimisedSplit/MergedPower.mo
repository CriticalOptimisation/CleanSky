within EU_CleanSky.EDS.Utilities.OptimisedSplit;
model MergedPower "Component with two electrical ports, including current"
  import Modelica;
  parameter Integer n=1 "Number of wires in each wire set";
  Modelica.Electrical.Analog.Interfaces.PositivePin p1[n]
    "Positive pin of the left port (potential p1.v > n1.v for positive voltage drop v1)"
                                                                                                      annotation (Placement(
        transformation(extent={{-110,40},{-90,60}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1[n]
    "Negative pin of the left port"              annotation (Placement(
        transformation(extent={{-90,-60},{-110,-40}}, rotation=0),
        iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-50})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    "Negative pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                       annotation (Placement(
        transformation(extent={{110,40},{90,60}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
    "Positive pin of the right port"              annotation (Placement(
        transformation(extent={{90,-60},{110,-40}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={75,0})));
  Internal.Min min(nu=n,weights=weights)
    annotation (Placement(transformation(extent={{19,-6},{31,6}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[n] annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,0})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={75,-30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={75,24})));
  Modelica.Blocks.Math.Gain gain(final k=0.5)
    annotation (Placement(transformation(extent={{40,-7},{54,7}})));
  Modelica.Electrical.Analog.Interfaces.Pin gnd
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent[n] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,0})));
  Internal.PowerShareCalc powerShareCalc(
    n=n,
    corrType=corrType,
    weights=weights)
    annotation (Placement(transformation(extent={{-30,10},{-50,-10}})));
  parameter Real weights[n]=ones(n) "Power sharing weights";
  parameter Integer corrType=0 "Tyoe of correction applied"  annotation(choices(choice=0
        "Proportional",                                                                                             choice=1
        "Corrected by V²"));
equation
  connect(voltageSensor.v, min.u) annotation (Line(
      points={{10,0},{19,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(powerSensor.nc, p2) annotation (Line(
      points={{75,-40},{75,-50},{100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage.p, powerSensor.pc) annotation (Line(
      points={{75,-10},{75,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage.p, powerSensor.pv) annotation (Line(
      points={{75,-10},{85,-10},{85,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage1.n, n2) annotation (Line(
      points={{75,34},{75,50},{100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage1.p, signalVoltage.n) annotation (Line(
      points={{75,14},{75,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(min.y, gain.u) annotation (Line(
      points={{32.02,0},{38.6,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, signalVoltage.v) annotation (Line(
      points={{54.7,0},{68,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, signalVoltage1.v) annotation (Line(
      points={{54.7,0},{60,0},{60,24},{68,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(powerSensor.nv, signalVoltage1.n) annotation (Line(
      points={{65,-30},{57,-30},{57,34},{75,34}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(gnd, signalVoltage.n) annotation (Line(
      points={{0,-100},{0,-80},{62,-80},{62,10},{75,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalCurrent.p, p1) annotation (Line(
      points={{-80,10},{-80,50},{-100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalCurrent.n, n1) annotation (Line(
      points={{-80,-10},{-80,-50},{-100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.v, powerShareCalc.voltages) annotation (Line(
      points={{10,0},{13,0},{13,-20},{-20,-20},{-20,0},{-28.8,0}},
      color={0,0,127},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(powerSensor.power, powerShareCalc.totalPwr) annotation (Line(
      points={{64,-22},{-40,-22},{-40,-9.4}},
      color={0,0,127},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(voltageSensor.p, p1) annotation (Line(
      points={{0,10},{0,50},{-100,50}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(voltageSensor.n, n1) annotation (Line(
      points={{0,-10},{0,-50},{-100,-50}},
      color={0,0,255},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(powerShareCalc.i, signalCurrent.i) annotation (Line(
      points={{-51,0},{-73,0}},
      color={0,0,127},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Polygon(
          points={{-120,53},{-110,50},{-120,47},{-120,53}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-136,50},{-111,50}}, color={160,160,164}),
        Polygon(
          points={{127,-47},{137,-50},{127,-53},{127,-47}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{111,-50},{136,-50}}, color={160,160,164}),
        Text(
          extent={{112,-44},{128,-29}},
          lineColor={160,160,164},
          textString="i2"),
        Text(
          extent={{118,52},{135,67}},
          lineColor={0,0,0},
          textString="i2"),
        Polygon(
          points={{120,53},{110,50},{120,47},{120,53}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{111,50},{136,50}}, color={0,0,0}),
        Line(points={{-136,-49},{-111,-49}}, color={160,160,164}),
        Polygon(
          points={{-126,-46},{-136,-49},{-126,-52},{-126,-46}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-127,-46},{-110,-31}},
          lineColor={160,160,164},
          textString="i1"),
        Text(
          extent={{-136,53},{-119,68}},
          lineColor={160,160,164},
          textString="i1")}),
    Documentation(revisions="<html>
<ul>
<li><i> 2014   </i> by Jean-Marc Le Peuv&eacute;dic<br> initially implemented<br></li>
<li><i> 2014   </i> by Jean-Marc Le Peuv&eacute;dic<br> disregard zero-weight inputs<br></li>
</ul>
</html>",
        info="<html>
<p>MergedPower merges power supplies from multiple networks without exchanging power between them. For the merged side, it includes a controlled voltage source whose voltage is the lowest of the split side voltages.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-44},{60,-44}},
                                        color={0,0,255}),
        Line(points={{-40,-64},{40,-64}},
                                        color={0,0,255}),
        Line(points={{-20,-84},{20,-84}},
                                        color={0,0,255}),
        Line(points={{0,-4},{0,-44}},color={0,0,255})}));
end MergedPower;
