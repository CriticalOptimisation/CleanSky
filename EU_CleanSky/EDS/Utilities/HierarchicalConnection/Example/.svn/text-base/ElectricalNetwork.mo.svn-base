within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example;
model ElectricalNetwork
  "Test model of System aggregate library. Specializes System."
  extends HierarchicalDCPowerConn.System(redeclare MySystem content(ssType=
          "ElectricalNetwork"));
  extends Modelica.Icons.Example;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(Interval=10),
    __Dymola_experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end ElectricalNetwork;
