within EU_CleanSky.EDS.Electrical.Examples;
model TestElectricalFunction2
  "Run the electrical function without initial failures."
  import EU_CleanSky.EDS.Electrical.DC.*;

  DC.DCFunction   electricalFunction
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  EU_CleanSky.EDS.SafetyLib.ControlledPower power
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  DC.Sources.GenericIdealSource DCSource
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Sources.BooleanExpression deliverDCPower(y=true)
    annotation (Placement(transformation(extent={{-72,70},{-52,90}})));
equation
  connect(power.m, load.m) annotation (Line(
      points={{2,-23.4},{2,0},{-4,0},{-4,20},{0,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(power.f, load.f) annotation (Line(
      points={{18,-23.4},{18,0},{24,0},{24,20},{20,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(electricalFunction.functionPowered, power.u) annotation (Line(
      points={{-40,15.6},{-40,-30},{0,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(deliverDCPower.y, DCSource.deliverDCPower) annotation (Line(
      points={{-51,80},{-40,80},{-40,59.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(DCSource.plug, electricalFunction.plug) annotation (Line(
      points={{-40,40},{-40,24}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end TestElectricalFunction2;
