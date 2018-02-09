within EU_CleanSky_Test.EDS.Utilities.HierarchicalConnection;
package Aircraft
  "Examples and test cases for the HierarchicalConnection.Aircraft package"
  extends Modelica.Icons.ExamplesPackage;
  model FrameProxy1
    extends Modelica.Icons.Example;
    import EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.S;
    EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.FrameProxy C0(nr=S.Default)
      "Remote access to ground frame"
      annotation (Placement(transformation(extent={{-60,38},{-40,42}})));
    EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.FrameProxy C0p(nr=S.Default)
      "Remote access to ground frame"
      annotation (Placement(transformation(extent={{-60,-42},{-40,-38}})));
    Modelica.Mechanics.MultiBody.Parts.Fixed fixed
      annotation (Placement(transformation(extent={{60,30},{40,50}})));
    Modelica.Mechanics.MultiBody.Parts.Body body(m=1, animation=true)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation aircraftSkeleton(r={0,0,1})
      annotation (Placement(transformation(extent={{0,30},{20,50}})));
    inner
      EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.HierarchicalConnector
      hierarchy annotation (Placement(transformation(extent={{68,-40},{72,-20}}),
          iconTransformation(extent={{-140,48},{-120,68}})));
    inner Modelica.Mechanics.MultiBody.World world
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  equation
    connect(aircraftSkeleton.frame_b, fixed.frame_b) annotation (Line(
        points={{20,40},{40,40}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(C0.frame_b, aircraftSkeleton.frame_a) annotation (Line(
        points={{-40,40},{0,40}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(C0p.frame_b, body.frame_a) annotation (Line(
        points={{-40,-40},{-20,-40}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Documentation(info="<html>
<p>EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.FrameProxy</p>
</html>"),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                           graphics={
          Rectangle(extent={{-92,92},{92,8}}, lineColor={0,0,255}),
          Text(
            extent={{-90,92},{-58,86}},
            lineColor={0,0,255},
            textString="Circuit Diagram"),
          Text(
            extent={{-90,-8},{-46,-14}},
            lineColor={0,128,0},
            textString="Subsystem Diagram"),
          Rectangle(extent={{-92,-8},{32,-88}}, lineColor={0,127,0})}));
  end FrameProxy1;

  model PinProxy1 "Test of PinProxy with a simple example"
    extends Modelica.Icons.Example;
    EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.PinProxy   C0
      "Remote access to ground frame"
      annotation (Placement(transformation(extent={{-60,58},{-40,62}})));
    EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.PinProxy   C0p
      "Remote access to ground frame"
      annotation (Placement(transformation(extent={{-60,-42},{-40,-38}})));
    inner Modelica.Mechanics.MultiBody.World world
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
    inner
      EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.HierarchicalConnector
      hierarchy annotation (Placement(transformation(extent={{68,-40},{72,-20}}),
          iconTransformation(extent={{-140,48},{-120,68}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=28)
      annotation (Placement(transformation(extent={{-20,50},{0,70}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
    EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.FrameProxy F0
      annotation (Placement(transformation(extent={{20,58},{40,62}})));
    Modelica.Mechanics.MultiBody.Parts.Fixed fixed
      annotation (Placement(transformation(extent={{80,50},{60,70}})));
  equation
    connect(constantVoltage.n, ground.p) annotation (Line(
        points={{0,60},{0,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(C0.pin, constantVoltage.p) annotation (Line(
        points={{-40,60},{-20,60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.n, ground1.p) annotation (Line(
        points={{0,-40},{0,-60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.p, C0p.pin) annotation (Line(
        points={{-20,-40},{-40,-40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realValue.numberPort, voltageSensor.v) annotation (Line(
        points={{-18.5,-60},{-10,-60},{-10,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(F0.frame_b, fixed.frame_b) annotation (Line(
        points={{40,60},{60,60}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics={
          Rectangle(extent={{-92,92},{92,8}}, lineColor={0,0,255}),
          Text(
            extent={{-90,92},{-58,86}},
            lineColor={0,0,255},
            textString="Circuit Diagram"),
          Text(
            extent={{-90,-8},{-46,-14}},
            lineColor={0,128,0},
            textString="Subsystem Diagram"),
          Rectangle(extent={{-92,-8},{32,-88}}, lineColor={0,127,0})}));
  end PinProxy1;
  annotation (Documentation(info="<html>
<p>Some models in EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft cannot be checked normally in Dymola.</p>
<p>The most common issue affects models having connection graphs of Frame connectors without any other kind of equation. They should have Connections.potentialRoot statements, but Dymola has a bug and does an internal error when they do. These statements are commented out in the Plug component.</p>
<p>The presence of a Plug component which acts as a very high impedance ground connection for all the physical connectors present in the Aircraft.HierarchicalConnector, is only related to model checking. In a future version, this component could be automatically disabled when the proxy is integrated in a model, using an outer parameter.</p>
<p>The examples below use Proxy components in situation and show that they do not prevent models from running, despite aborted class checks and other issues when considered alone.</p>
</html>"));
end Aircraft;
