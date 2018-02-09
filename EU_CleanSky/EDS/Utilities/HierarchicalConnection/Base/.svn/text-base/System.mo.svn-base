within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
partial model System
  "Partial top level model includes the required inner definition.  "

  parameter String ssType="";

  replaceable PartialContext content(ssType=ssType)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  inner HierarchicalConnector internal
    "The hidden connector used to establish hierarchical connections.";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(extent={{-100,
            -100},{100,100}}, preserveAspectRatio=false), graphics));
end System;
