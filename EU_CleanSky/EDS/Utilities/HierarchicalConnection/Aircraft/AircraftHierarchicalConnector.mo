within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft;
connector AircraftHierarchicalConnector "Interface arrays"
  // Enumeration of aircraft level interfaces
  // E: Electrical pins
  // S: Structure frames
  // H: Hydraulic fluid connections
  // A: Bleed air connections
  // F: Fuel system connections
  // TODO: Thermal model wall and volume connections (two enums)

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame[S]
    annotation (Placement(transformation(extent={{4,44},{36,76}})));
  Internal.Pin                              pin[E]
    annotation (Placement(transformation(extent={{10,110},{30,90}})));
/*  
  // Fluid ports
  // The medium in HierarchicalConnector must match those in Plug. In order
  // to achieve that, both point directly to Aircraft level. If there is
  // a need to change the Medium
  Interfaces.HydrPort hyd[H](redeclare package Medium =
      Aircraft.HydraulicFluid)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={20,20})));
  Interfaces.AirPort air[A](redeclare package Medium = Aircraft.AirMedium)
                              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-20})));
  Interfaces.FuelPort fuel[F](redeclare package Medium = Aircraft.FuelMedium)
                                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-60})));
  // data port (expandable connector)
  Interfaces.Data data
  annotation (Placement(transformation(extent={{8,-112},{32,-88}})));
  */
   annotation (    defaultComponentPrefixes="inner",
    defaultComponentName="hierarchy",
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-20,
            -100},{20,100}}), graphics));
end AircraftHierarchicalConnector;
