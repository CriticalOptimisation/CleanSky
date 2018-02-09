within EU_CleanSky.EDS.Utilities.HierarchicalConnection;
encapsulated package Base "A self-contained package library users can extend."
import Modelica;


extends Modelica.Icons.BasesPackage;


replaceable connector HierarchicalConnector
  "The connector type for the hierarchical connection."

  annotation (
    defaultComponentPrefixes="inner",
    defaultComponentName="hierarchy",
    Placement(transformation(extent={{-100,80},{-80,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Diagram(coordinateSystem(extent={{-20,-100},{20,100}}, preserveAspectRatio=
            false), graphics={Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-40,-100},{40,-114}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end HierarchicalConnector;


annotation (Documentation(info="<html>
<p>This library contains the core functionality of the HierarchicalConnection library. It is an encapsulated package, which make no reference to other parts of the EU_CleanSky libraries. </p>
<p>Users may elect to work on the Advanced library rather than the Base library, which is more complicated to use. Tools limitations are the main factor making this library harder to use than it should, especially wrong representation of replaceable connectors in the diagram layer in derived packages.</p>
</html>"));
end Base;
