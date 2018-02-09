within EU_CleanSky.EDS.Utilities.HierarchicalConnection.AircraftExample.F7X;
type F7X_ElectricalConnections = enumeration(
    Battery28V "28V Battery",
    Battery0V "0V Battery",
    HeaterLH28V "Left hand side heater +",
    HeaterLH0V "Left hand side heater -",
    HeaterRH28V "Right hand side heater +",
    HeaterRH0V "Right hand side heater -",
    Subsys28V "Subsystem power supply +",
    Subsys0V "Subsystem power supply -",
    F33Gnd "Structure bonding frame 33",
    F45Gnd "Structure bonding frame 45") "Electrical connections list";
