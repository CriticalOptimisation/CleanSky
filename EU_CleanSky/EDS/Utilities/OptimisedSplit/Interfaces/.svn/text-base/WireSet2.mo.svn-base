within EU_CleanSky.EDS.Utilities.OptimisedSplit.Interfaces;
connector WireSet2
  "Connection of a load implemented by multiple wires in parallel on the supply side, and with an unknown power split on the load side."
  parameter Integer n=2 "Maximum number of wires in parallel.";

  Modelica.Electrical.Analog.Interfaces.Pin pin[n] "Arrat of MSL pins"
   annotation (Placement(transformation(extent={{-100,-100},{100,100}})));
 encapsulated function equalityConstraint
    "Return the constraint residue to express that two wire sets globally pass the same power"
    import WireSet =
      EU_CleanSky.EDS.Utilities.OptimisedSplit.Interfaces.WireSet2;
  input WireSet w1;
  input WireSet w2;
  output Real residue[1]
      "No constraints. Unneeded connect equations will be suppressed.";
 algorithm
  assert(w1.n == w2.n,"Internal error in OptimisedSplit library: WireSets must have the same value for n");
  residue[1]:=sum(w1.pin[k].i*w1.pin[k].v+w2.pin[k].i*w2.pin[k].v for k in 1:w1.n);
  annotation (Documentation(info="<html>
<p>This function is standardised by the Modelica specification. The presence of a function named &QUOT;equalityConstraint&QUOT; make the record and overconstrained record. The Modelica compiler will perform the connection graph analysis and transformation described in the specification.</p>
</html>"));
 end equalityConstraint;
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
end WireSet2;
