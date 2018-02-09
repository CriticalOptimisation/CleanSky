within EU_CleanSky.EDS.Utilities.HierarchicalConnection;
partial package Aircraft "All the global aircraft circuits and paths."
  extends Base(redeclare connector HierarchicalConnector =
        AircraftHierarchicalConnector);

  // Replaceable type definitions: list the connections for each kind of circuit
  // Later replace with enumeration(:) (unspecified).
  // Unwise choice while testing: (1) removes all the equations. (2) support buggy in Dymola 2015FD01.


  replaceable type S = enumeration(:)
  "Enumeration of structure interface points (where equipment is attached)"
             annotation (Documentation(info="<html>
<p>This enumeration must be redeclared in order to include the names of all the connection points to the structure.</p>
</html>"));
                                         // All brackets supporting systems and equipement


  replaceable type E = enumeration(:)
  "Enumeration of electrical circuits end-points, where equipment is connected.";
                                         // All electric equipotentials (pins)


  replaceable type H = enumeration(
    Default)
  "Enumeration of hydraulic circuits end-points, where hydraulic equipment is connected.";
                                         // All hydraulic fluid line end points


  replaceable type A = enumeration(
    Default)
  "Enumeration of bleed air circuits end-points, where bleed air powered equipment is connected.";
                                         // All points where air enters or leaves other systems or bays (structures)


  replaceable type F = enumeration(
    Default)
  "Enumeration of fuel circuit end-points, where fuel system equipement is connected.";
                                         // All fuel line end points. Structural fuel tanks are multi-domain aspects of structural parts.

  // Extend Base definitions
  // redeclare connector extends HierarchicalConnector syntax triggers bugs
  // in Dymola, which can be avoided using a modifier on Base. 

  // MSL Connectors redefined with different icons to distinguish hydraulic fluid, air (cyan) and fuel (yellow)

  // Fluid ports
  // Each requires 2 statements to define: 
  // First a replaceable redeclaration of the Medium.
  // These declarations will be pre-initialised with reasonable defaults, but there isn't any
  // Modelica.Media model of aviation fuel or aviation hydraulic fluid in the MSL.


  replaceable package HydraulicFluid =
    Modelica.Media.Incompressible.Examples.Essotherm650 "Medium model"
                 annotation (choicesAllMatching=true);


  replaceable package AirMedium = Modelica.Media.Air.DryAirNasa "Medium model"
                 annotation (choicesAllMatching=true);


  replaceable package FuelMedium = Modelica.Media.Interfaces.PartialMedium
  "Medium model" annotation (choicesAllMatching=true);

  // Second a specialisation of FluidPort with the desired Medium


  annotation (Documentation(info="<html>
<p>This hierarchical connector facilitates the creation of aircraft platform global models. It includes mechanical interfaces for the structural attachment points, and access to all the global circuits:</p>
<ul>
<li>Air circulation</li>
<li>Ambient air connection to Thermal Model (missing)</li>
<li>Electrical circuits</li>
<li>Hydraulic circuits</li>
<li>Fuel circuits</li>
<li>Data and control</li>
</ul>
<p>The package is encapsulated because it is self contained. It is partial because it must be extended with lists of named access points to the structure and each circuit.</p>
<p>The access point lists can be left empty with no consequence if the aircraft model is limited to some aspects only. Because there are no equations in this package (no physics), parametering a multi-domain model to compute only on one or a few domains (e.g.: pure electrical simulation) is possible and has no consequence at all on the hierarchical connector (&agrave; tester: pas sur que Dymola accepte des interconnexions reli&eacute;es &agrave; rien du tout dont le potentiel est ind&eacute;fini...).</p>
</html>"));
end Aircraft;
