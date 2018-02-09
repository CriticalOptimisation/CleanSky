within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
partial model PartialSubsystem "The built-in subsystem model"
  //extends PartialProxy;
  parameter Integer significantDigits(
    min=1,
    max=3) = 2 "Number of significant digits to be shown"
    annotation (Dialog(tab="Sensors"));
  parameter String signal1Name="" annotation (Dialog(tab="Sensors"));
  parameter String signal2Name="" annotation (Dialog(tab="Sensors"));
  parameter String signal3Name="" annotation (Dialog(tab="Sensors"));
  parameter String signal4Name="" annotation (Dialog(tab="Sensors"));
  parameter String signal5Name="" annotation (Dialog(tab="Sensors"));

protected
  outer HierarchicalConnector hierarchy
    "All the models and levels of the model hierarchy, up to System model are connected by this connector."
    annotation (Placement(transformation(extent={{-90,90},{-70,110}}),
        iconTransformation(extent={{-100,80},{-80,100}})), missingInnerMessage=
        "This class must only be extended from to create component models.\nPopulate your own derivative from \"PartialSubsystem\" with Components and \"Subsystems\".\n\"PartialSubsystem\" provides the correponding \"inner HierarchicalConnector hierarchy\" component.");

  inner HierarchicalConnector internal
    "The hidden connector used to establish hierarchical connections."
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
public
  parameter String ssType="click here";

  replaceable PartialContext content(ssType=ssType)
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));

  parameter Integer nSensors(
    min=0,
    max=5) = 0 "The number of sensors." annotation (
    Evaluate=true,
    HideResult=true,
    Dialog(tab="Sensors"),
    choices(
      choice=0,
      choice=1,
      choice=2,
      choice=3,
      choice=4,
      choice=5));
  Modelica.Blocks.Interaction.Show.RealValue signal1(use_numberPort=true) if
    nSensors == 1 or nSensors == 2 or nSensors == 3 or nSensors == 4 or
    nSensors == 5
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Modelica.Blocks.Interaction.Show.RealValue signal2(use_numberPort=true) if
    nSensors == 2 or nSensors == 3 or nSensors == 4 or nSensors == 5
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Interaction.Show.RealValue signal3(use_numberPort=true) if
    nSensors == 3 or nSensors == 4 or nSensors == 5
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interaction.Show.RealValue signal4(use_numberPort=true) if
    nSensors == 4 or nSensors == 5
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Interaction.Show.RealValue signal5(use_numberPort=true) if
    nSensors == 5
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
equation

  /**/
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-74,102},{-46,96}},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="internal",
          lineColor={0,0,255}), Text(
          extent={{-72,-96},{-44,-102}},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255},
          textString="hierarchy")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-100},{100,-134}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-100,134},{100,100}},
          lineColor={0,128,0},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          textString="%ssType"),
        Text(
          visible=(nSensors == 5 or nSensors == 4 or nSensors == 3 or nSensors
               == 2 or nSensors == 1),
          extent={{30,46},{100,16}},
          lineColor={0,0,0},
          textString=DynamicSelect("0.0", String(signal1.showNumber,
              significantDigits=significantDigits))),
        Text(
          visible=(nSensors == 5 or nSensors == 4 or nSensors == 3 or nSensors
               == 2),
          extent={{30,18},{100,-12}},
          lineColor={0,0,0},
          textString=DynamicSelect("0.0", String(signal2.showNumber,
              significantDigits=significantDigits))),
        Text(
          visible=(nSensors == 5 or nSensors == 4 or nSensors == 3),
          extent={{30,-10},{100,-40}},
          lineColor={0,0,0},
          textString=DynamicSelect("0.0", String(signal3.showNumber,
              significantDigits=significantDigits))),
        Text(
          visible=(nSensors == 5 or nSensors == 4),
          extent={{30,-36},{100,-66}},
          lineColor={0,0,0},
          textString=DynamicSelect("0.0", String(signal4.showNumber,
              significantDigits=significantDigits))),
        Text(
          visible=(nSensors == 5),
          extent={{30,-62},{100,-92}},
          lineColor={0,0,0},
          textString=DynamicSelect("0.0", String(signal5.showNumber,
              significantDigits=significantDigits))),
        Text(
          extent={{-100,46},{38,16}},
          lineColor={0,0,0},
          textString="%signal1Name"),
        Text(
          extent={{-100,18},{38,-12}},
          lineColor={0,0,0},
          textString="%signal2Name"),
        Text(
          extent={{-100,-10},{38,-40}},
          lineColor={0,0,0},
          textString="%signal3Name"),
        Text(
          extent={{-100,-36},{38,-66}},
          lineColor={0,0,0},
          textString="%signal4Name"),
        Text(
          extent={{-100,-62},{38,-92}},
          lineColor={0,0,0},
          textString="%signal5Name")}),
    Documentation(info="<html>
<p>Subsystem defines a boudary separating inside components from the outside. </p>
<p>This class has two replaceable components: sensingElement et content. The sensing element has two connectors: the internal connector is inside and all the connectors extending PartialConnector connect to it. Power and data flow through the sensing element and arrive to the second connector. The second connector is outside and connects to the next higher level in the system hierarchy. Custom sensing elements can extract summaries (typically flow variables or power levels) which are displayed on the Subsystem icon. It is easy to track the power flows when navigating in a system.</p>
<p>The content replaceable component must extend PartialSubsystem. The inherited diagram will be empty, without interfaces nor pre-existing components. However there is a hidden hierarchical connector enabling the direct use of Subsystem instances in this diagram. Of course connectors extending PartialConnector will also work as expected in this context, making it possible to create both architecture views (a Subsystem spilt if smaller Subsystems) and functional views (showing how things are connected).</p>
</html>"));
end PartialSubsystem;
