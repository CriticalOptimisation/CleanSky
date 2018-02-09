within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft;
model HydrProxy "Local proxy of a hydraulic connection point+"
  extends Aircraft.Icons.InputOutputProxy;
  parameter H nr
    "The number of the hydraulic connector to connect to in the connector array.";

  Interfaces.HydrPort port(redeclare package Medium = HydraulicFluid) annotation (Placement(transformation(extent={{90,-10},
            {110,10}}), iconTransformation(extent={{90,-10},{110,10}})));

protected
  outer HierarchicalConnector          hierarchy
    "Link from proxy to actual connector"                                                                                          annotation (Placement(transformation(extent={{-76,-24},
            {-66,24}}),
        iconTransformation(extent={{-100,80},{-80,100}})), missingInnerMessage=
        "This class contains an \"outer HierarchicalConnector hierarchy\" declaration. Insert an \"Aircraft.System\" component higher in the component tree to get the matching inner declaration.");
  // Plug medium types are not fully reconfigurable in HydrProxy because
  // the choice of fuel and air fluids is not relevant for a hydraulic fluid port.
public
  Internal.Plug plug
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
equation
  connect(plug.h, hierarchy) annotation (Line(
      points={{-40,20},{-56,20},{-56,0},{-71,0}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(port, hierarchy.hyd[nr])
    annotation (Line(
      points={{100,0},{-71,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-20},
            {100,20}}), graphics={Text(
          extent={{46,20},{94,-20}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%nr")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics));
end HydrProxy;
