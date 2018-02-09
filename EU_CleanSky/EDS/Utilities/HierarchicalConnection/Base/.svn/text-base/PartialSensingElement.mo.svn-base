within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
partial model PartialSensingElement
  "The main interface of the sensing elements. Derive and add sensors from the library."
  extends Icons.SensingElement;

  HierarchicalConnector internal
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  HierarchicalConnector hierarchy
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p>This base model only provides the sensor icon from the Modelica Standard Library and the &QUOT;internal&QUOT; and &QUOT;hierarchy&QUOT; connectors.Due to the mandatory redefinition of the connector type, and some limitations in the graphical interface of the tools, it might be preferable to copy the definitions in the new sensor classes, rather then inherit them with an extends clause. Some tools will not use the user defined connector in the diagram layer, so the user will not have the possibility to connect directly to individual connector components. It is only a graphical issue, and the user will be offered the possibility to type in the name of the desired component, but the diagrams are not as clear.</p>
<p>In any case, the user defined sensor classes must have the same components, with the type updated to the user defined hierarchical connector type.</p>
</html>"));
end PartialSensingElement;
