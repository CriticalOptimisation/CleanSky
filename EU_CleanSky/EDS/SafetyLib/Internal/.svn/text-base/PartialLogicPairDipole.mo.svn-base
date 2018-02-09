within EU_CleanSky.EDS.SafetyLib.Internal;
partial model PartialLogicPairDipole
  "Provides icon and common appearance to internal components."

  LogicPairM m annotation (Placement(transformation(extent={{-102,-2},{-98,2}}),
        iconTransformation(extent={{-108,-8},{-92,8}})));
  LogicPairF f annotation (Placement(transformation(extent={{98,-2},{102,2}}),
        iconTransformation(extent={{92,-8},{108,8}})));
  parameter String varname="" annotation(choices(choice="leak"
        "Leak indication",                                                        choice="open"
        "Blockage / open circuit indication",                                                                                  choice="high"
        "High potential indication",                                                                                                    choice="low"
        "Low potential indication",                                                                                                    choice="gnd"
        "Ground / Natural potential indication", choice="rev"
        "Reverse flow indication"), Evaluate=true);
  parameter Boolean useStatus=false annotation(Evaluate=true);
  parameter Boolean useInput=false annotation(Evaluate=true);

  Modelica.Blocks.Interfaces.BooleanInput u if useInput==true "Local input"
        annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}),                            iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-64})));
  Modelica.Blocks.Interfaces.BooleanOutput s if useStatus==true "Status output"
                                                                                annotation (Placement(
        visible=useStatus,transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,66})));

protected
  Modelica.Blocks.Interfaces.BooleanInput local_u=false if useInput==false;
public
  Or3 or3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,20})));
equation
  connect(u, or3.u1) annotation (Line(
      points={{0,-100},{0,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(local_u, or3.u1);
  connect(m.FtoM, or3.u3) annotation (Line(
      points={{-100,0},{-8,0},{-8,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(f.MtoF, or3.u2) annotation (Line(
      points={{100,0},{8,0},{8,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or3.y, s) annotation (Line(
      points={{0,31},{0,100}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={192,192,192},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),      Text(
          extent={{-152,-22},{148,-62}},
          textString="%name",
          lineColor={255,255,255}),            Text(
          extent={{-148,58},{152,18}},
          lineColor={255,255,255},
          textString="%varname")}),   Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                              graphics));
end PartialLogicPairDipole;
