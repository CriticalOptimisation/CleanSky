within EU_CleanSky.EDS.Utilities.OptimisedSplit.Interfaces;
connector WireSet
  "Connection of a load implemented by multiple wires in parallel on the supply side, and with an unknown power split on the load side."
  parameter Integer n=2 "Maximum number of wires in parallel.";

  Modelica.Electrical.Analog.Interfaces.Pin pin[n] "Arrat of MSL pins"
   annotation (Placement(transformation(extent={{-100,-100},{100,100}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(extent={{-100,100},{60,-60}},
            lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                  Rectangle(
          extent={{-60,60},{100,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}),
    Documentation(info="<html>
<p>The connection between two WireSet connectors ensures the equality of voltages, but only ensures that power is globally the same for currents. The current splitting must be defined by other equations. In this library, optional i=0 equations are added until the currents are all known.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end WireSet;
