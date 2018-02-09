within EU_CleanSky.EDS.Utilities.HierarchicalConnection.AircraftExample;
package MySubsystem1 "All the models describing a subsystem of type 1"
  model Views
    "A subsystem with three components inside. Electrical and mechanical views."
    extends HC.PartialContext(ssType="MySubsystem2");
    MechanicalView mechanicalView
      annotation (Placement(transformation(extent={{-80,20},{-20,80}})));
    ElectricalView electricalView
      annotation (Placement(transformation(extent={{20,20},{80,80}})));
  end Views;

  model MechanicalView "Mechanical view of MySubsystem2"
    import EU_CleanSky.EDS.Utilities.HierarchicalConnection;
    extends HierarchicalConnection.Aircraft.MechanicalView;
    HierarchicalConnection.AircraftExample.MySubsystem2.HC.Proxies.Subsystem_Str
      subsystem_Str
      annotation (Placement(transformation(extent={{-60,-2},{-40,2}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox(
      r={0,0,0.25},
      lengthDirection(displayUnit="1") = {1,0,0},
      length=1,
      width=0.40,
      height=0.25,
      density(displayUnit="kg/l") = 1000,
      color={0,128,0})
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(subsystem_Str.frame, bodyBox.frame_a) annotation (Line(
        points={{-40,0},{20,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end MechanicalView;

  model ElectricalView "Electrical View of Subsystem2"
    extends HC.ElectricalView;
    HC.Proxies.Subsystem_28V subsystem_28V
      annotation (Placement(transformation(extent={{-90,58},{-70,62}})));
    HC.Proxies.Subsystem_0V subsystem_0V
      annotation (Placement(transformation(extent={{-90,-62},{-70,-58}})));
    HC.Proxies.Heater heater
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    HC.Proxies.Heater heater1
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    HC.Proxies.Heater heater2
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Modelica.Electrical.Analog.Basic.Resistor wire1(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-40,30})));
    Modelica.Electrical.Analog.Basic.Resistor wire2(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-40,-30})));
    Modelica.Electrical.Analog.Basic.Resistor wire3(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,30})));
    Modelica.Electrical.Analog.Basic.Resistor wire4(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-30})));
    Modelica.Electrical.Analog.Basic.Resistor wire5(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={40,30})));
    Modelica.Electrical.Analog.Basic.Resistor wire6(R=0.05) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={40,-30})));
  equation
    connect(subsystem_28V.pin, wire1.p) annotation (Line(
        points={{-70,60},{-40,60},{-40,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_28V.pin, wire3.p) annotation (Line(
        points={{-70,60},{0,60},{0,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_28V.pin, wire5.p) annotation (Line(
        points={{-70,60},{40,60},{40,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_0V.pin, wire2.n) annotation (Line(
        points={{-70,-60},{-40,-60},{-40,-40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_0V.pin, wire4.n) annotation (Line(
        points={{-70,-60},{0,-60},{0,-40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_0V.pin, wire6.n) annotation (Line(
        points={{-70,-60},{40,-60},{40,-40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater2.pin_n, wire6.p) annotation (Line(
        points={{40,-10},{40,-20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater1.pin_n, wire4.p) annotation (Line(
        points={{0,-10},{0,-20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater.pin_n, wire2.p) annotation (Line(
        points={{-40,-10},{-40,-20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater.pin_p, wire1.n) annotation (Line(
        points={{-40,10},{-40,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater1.pin_p, wire3.n) annotation (Line(
        points={{0,10},{0,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(heater2.pin_p, wire5.n) annotation (Line(
        points={{40,10},{40,20}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end ElectricalView;

  package HC
    "Hierarchical connector describing internal interfaces of an electrical Subsystem"
    extends Aircraft(
    redeclare type S = Subsys_StructureConnections,
    redeclare type E = Subsys_ElectricalConnections);

    type Subsys_ElectricalConnections = enumeration(
        H1_28V "Central heater +",
        H1_0V "Central heater -",
        H2_28V "Left hand side heater +",
        H2_0V "Left hand side heater -",
        H3_28V "Right hand side heater +",
        H3_0V "Right hand side heater -",
        Subsys28V "Subsystem power supply +",
        Subsys0V "Subsystem power supply -") "Electrical connections list";

    type Subsys_StructureConnections = enumeration(
        Plate "Plate") "List of relevant structural interfaces";

    redeclare package extends Icons

      model Heater "Heater icon for use in Proxies"

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,60},{100,-100}},
                lineColor={0,0,255},
                fillColor={156,166,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-78,40},{80,40}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-78,18},{80,18}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-78,-8},{80,-8}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-48,14},{-48,62},{-20,34},{-20,90}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-14,14},{-14,62},{14,34},{14,90}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{20,14},{20,62},{48,34},{48,90}},
                color={255,0,0},
                smooth=Smooth.None)}));
      end Heater;

      model Subsystem "A subsystem with more resistors and a heater"

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{0,0}},
                lineColor={0,0,255},
                fillColor={156,166,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,0},{100,-100}},
                lineColor={0,0,255},
                fillColor={156,166,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,80},{98,0}},
                lineColor={0,0,255},
                fillColor={156,166,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,60},{78,60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{20,38},{78,38}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{34,44},{34,82},{62,56},{62,96}},
                color={255,0,0},
                smooth=Smooth.None)}));
      end Subsystem;

      model Structure
        "Electrical connection to structure icon used for proxies"

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),                                                                  graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-76,-18},{74,-18}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=0.5),
              Line(
                points={{42,-18},{8,-64}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{12,-18},{-22,-64}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-18,-18},{-52,-64}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-52,-18},{-86,-64}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{2,54},{2,-18}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=0.5),
              Line(
                points={{74,-18},{40,-64}},
                color={0,0,255},
                smooth=Smooth.None)}));
      end Structure;

      model powerPos "power supply positive pin"

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={255,0,0},
                fillColor={252,252,252},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5),
              Rectangle(
                extent={{-70,20},{70,-20}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,20},{70,-20}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid,
                origin={0,2},
                rotation=90)}));
      end powerPos;

      model powerNeg "power supply negative pin"

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={252,252,252},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5), Rectangle(
                extent={{-70,20},{70,-20}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid)}));
      end powerNeg;
    end Icons;

    package Proxies "Short definitions of proxies"
      extends Modelica.Icons.VariantsPackage;
      // One day I'll draw a specific package icon...

      // Proxies for the 28V power distribution diagram

      // Proxies for the ground interconnect diagram

      // Proxies for the structure diagram

      model Subsystem_Str "Subsystem attachment"
        extends FrameProxy annotation(IconMap(primitivesVisible=false));
        extends Icons.Structure;
      end Subsystem_Str;

      model Heater_28V "Positive pin of 28V heater"
        extends PinProxy annotation(IconMap(primitivesVisible=false));
        extends Icons.Heater;
      end Heater_28V;

      model Heater_0V "Negative pin of 28V heater"
        extends PinProxy annotation(IconMap(primitivesVisible=false));
        extends Icons.Heater;
      end Heater_0V;

      model Subsystem_28V "Positive pin of subsystem"
        extends PinProxy(final nr=E.Subsys28V) annotation(IconMap(primitivesVisible=false));
        extends Icons.powerPos;
      end Subsystem_28V;

      model Subsystem_0V "Negative pin of subsystem"
        extends PinProxy(final nr=E.Subsys0V) annotation(IconMap(primitivesVisible=false));
        extends Icons.powerNeg;
      end Subsystem_0V;

      model Heater "Heater proxy for electrical schematics"
        extends Icons.Heater;
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
            Placement(transformation(extent={{-10,90},{10,110}}),
              iconTransformation(extent={{-10,90},{10,110}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
            Placement(transformation(extent={{-10,-110},{10,-90}}),
              iconTransformation(extent={{-10,-110},{10,-90}})));
        Heater_28V heater_28V
          annotation (Placement(transformation(extent={{-40,58},{-20,62}})));
        Heater_0V heater_0V
          annotation (Placement(transformation(extent={{-40,-62},{-20,-58}})));
      equation
        connect(heater_0V.pin, pin_n) annotation (Line(
            points={{-20,-60},{0,-60},{0,-100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(heater_28V.pin, pin_p) annotation (Line(
            points={{-20,60},{0,60},{0,100}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics));
      end Heater;
    end Proxies;

  end HC;

  model Subsystem1 "A kind of subsystem with 2 heaters and a Subsystem2 in it"
    extends MySubsystem2.HC.System(redeclare Views content(ssType="Subsystem2"));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b acStructure
      "Mechanical interface to the part of the aircraft structure the subsystem is attached to"
      annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={0,-98}), iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={0,-100})));
    HC.Proxies.Subsystem_Str subsystem_Str
      annotation (Placement(transformation(extent={{-36,-78},{-16,-74}})));
    HC.Proxies.Subsystem_28V subsystem_28V
      annotation (Placement(transformation(extent={{40,58},{60,62}})));
    HC.Proxies.Subsystem_0V subsystem_0V
      annotation (Placement(transformation(extent={{-40,58},{-60,62}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
          transformation(extent={{-90,90},{-70,110}}), iconTransformation(extent={
              {-90,90},{-70,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
          transformation(extent={{70,90},{90,110}}), iconTransformation(extent={{70,
              90},{90,110}})));
  equation
    connect(subsystem_Str.frame, acStructure) annotation (Line(
        points={{-16,-76},{0,-76},{0,-98}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(subsystem_0V.pin, pin_p) annotation (Line(
        points={{-60,60},{-80,60},{-80,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(subsystem_28V.pin, pin_n) annotation (Line(
        points={{60,60},{80,60},{80,100}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Subsystem1;
end MySubsystem1;
