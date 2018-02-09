within EU_CleanSky.EDS.SafetyLib.Internal;
model And3 "Logical 'and': y = u1 and u2 and u3"
  extends Modelica.Blocks.Interfaces.partialBooleanSI2SO;
         Modelica.Blocks.Interfaces.BooleanInput u3
    "Connector of second Boolean input signal"
                                           annotation (Placement(
        transformation(extent={{-140,60},{-100,100}},   rotation=0)));
equation
  y = u1 and u2 and u3;
  annotation (defaultComponentName="and1",
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          textString="and"),
        Ellipse(
          extent={{-73,88},{-87,74}},
          lineColor=DynamicSelect({235,235,235}, if u3 > 0.5 then {0,255,0} else
                    {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u3 > 0.5 then {0,255,0} else
                    {235,235,235}),
          fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
                   extent={{-100,-100},{100,100}}),
                                    graphics),
    Documentation(info="<html>
<p>
The output is <b>true</b> if all inputs are <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
end And3;
