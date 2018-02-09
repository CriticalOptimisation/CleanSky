within EU_CleanSky.EDS.Utilities.HierarchicalConnection.AircraftExample.F7X;
package Proxies "Short definitions of proxies"
  extends Modelica.Icons.VariantsPackage;
  // One day I'll draw a specific package icon...

  // Proxies for the 28V power distribution diagram
  model Battery_28V "Positive pin of 24V battery"
    extends PinProxy(final nr=E.Battery28V) annotation(IconMap(primitivesVisible=false));
    extends Icons.Battery;
  end Battery_28V;

  // Proxies for the ground interconnect diagram

  // Proxies for the structure diagram

  model Battery_0V "Negative pin of battery."
    extends PinProxy(final nr=E.Battery0V) annotation(IconMap(primitivesVisible=false));
    extends Icons.Battery;
  end Battery_0V;

  model Battery_Str "Battery attachment"
    extends FrameProxy annotation(IconMap(primitivesVisible=false));
    extends Icons.Battery;
  end Battery_Str;

  model Subsystem_Str "Subsystem attachment"
    extends FrameProxy annotation(IconMap(primitivesVisible=false));
    extends Icons.Subsystem;
  end Subsystem_Str;

  model Heater_28V "Positive pin of 28V heater"
    extends PinProxy annotation(IconMap(primitivesVisible=false));
    extends Icons.Heater;
  end Heater_28V;

  model Heater_0V "Negative pin of 28V heater"
    extends PinProxy annotation(IconMap(primitivesVisible=false));
    extends Icons.Heater;
  end Heater_0V;

  model F33Gnd_0V "Electrical bonding at frame 33"
    extends PinProxy(final nr=E.F33Gnd) annotation(IconMap(primitivesVisible=false));
    extends Icons.Bonding;
  end F33Gnd_0V;

  model F45Gnd_0V "Electrical bonding at frame 45"
    extends PinProxy(final nr=E.F45Gnd) annotation(IconMap(primitivesVisible=false));
    extends Icons.Bonding;
  end F45Gnd_0V;

  model Subsystem_28V "Positive pin of subsystem"
    extends PinProxy(final nr=E.Subsys28V) annotation(IconMap(primitivesVisible=false));
    extends Icons.Subsystem;
  end Subsystem_28V;

  model Subsystem_0V "Negative pin of subsystem"
    extends PinProxy(final nr=E.Subsys0V) annotation(IconMap(primitivesVisible=false));
    extends Icons.Subsystem;
  end Subsystem_0V;
end Proxies;
