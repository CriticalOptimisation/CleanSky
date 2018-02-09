within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
partial model PartialProxy
  "The connector proxy. Extend it to give access to all the parts of the hierarchical connector."

protected
  outer HierarchicalConnector hierarchy
    "All the models and levels of the model hierarchy, up to System model are connected by this connector."
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}}),
        iconTransformation(extent={{-100,80},{-80,100}})), missingInnerMessage=
        "This class must only be extended from to create component models.\nPopulate your own derivative from \"PartialSubsystem\" with Components and \"Subsystems\".\n\"PartialSubsystem\" provides the correponding \"inner HierarchicalConnector hierarchy\" component.");
  annotation (
    missingInnerMessage=
        "This component is designed for insertion in a System or Subsystem. See HierachicalConnection documentation.",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p>Extend a classic connector (for instance a standard physical connector fromt the Modelica Standard Library) and this component, then add the connection or the line of Modelica code which will connect the inherited connector to a defined area of the hierarchical connector. Users of this core library who define a new hierarchical connector should also deliver a library of connector proxies giving access to each part of the hierarchical connector. The hierarchical connector can be a flat dictionary, even an expandable connector, or a structured connector. If it is structured, one of the most productive approaches is to structure in a flat collection of connector arrays, and to define enumeration types for each array. This approach makes it possible to develop only one connector proxy per array, with a parameter defining the array postion which becomes available.</p>
</html>"));

end PartialProxy;
