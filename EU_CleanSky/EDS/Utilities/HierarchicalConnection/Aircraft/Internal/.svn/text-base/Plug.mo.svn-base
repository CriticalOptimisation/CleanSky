within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.Internal;
model Plug
  "A model giving \"closed pipe\" or \"open wire\" boundary conditions to each interface in HierarchicalConnector"
  import EU_CleanSky.EDS.Utilities.HierarchicalConnection;

  // The plug is a component which connects to all the connectors in the
  // hierarchical connector called "hierarchy". It is not strictly mandatory
  // on finished models, but it allows proxy models to be balanced.
  // The Modelica checker does not complain about unconnected variables in the
  // hierarchical connector.

  // The nature of the fluids declared in this connector has no impact on the
  // results because there is no flow. However the library checks type
  // concordance upon connect, and the types here must match the types used
  // in the hierarchical connector.
  HierarchicalConnector h     annotation (hideResult=true, Placement(
        transformation(extent={{-100,-50},{-80,50}}), iconTransformation(extent=
           {{-102,-10},{-98,10}})));
//   final parameter Modelica.SIunits.Resistance R=1e9 "Terminating resistor";
//   final parameter Modelica.Fluid.Types.HydraulicResistance Rh=1e9 "Leak to vacuum hydraulic resistance for all fluids";

  UnitFramePlug framePlug[S]
    annotation (Placement(transformation(extent={{0,-6},{4,6}})));
  PinConverter pinConverter[E]
    annotation (Placement(transformation(extent={{20,10},{0,30}})));
equation
  // Unconnected frame boundary conditions

  // Each Frame connector must be individually connected, otherwise a call to 'cardinality' in
  // UnitFramePlug does not work properly.
  for e in S loop
    connect(framePlug[e].frame, h.frame[e]) annotation (Line(
        points={{0,0},{-90,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
  end for;
  // Each rootedPin connector must be individually connected, otherwise a call to 'cardinality' in
  // PinConverter does not work properly.
  for e in E loop
    connect(pinConverter[e].rootedPin, h.pin[e]) annotation (Line(
      points={{0,20},{-40,20},{-40,0},{-90,0}},
      color={0,0,255},
      smooth=Smooth.None));
  end for;
  /*
  // Nearly open pin boundary conditions : R is very large
   for e loop
     h.pin[e].i = h.pin[e].v/R;
   end for;

  // Nearly plugged pipes boundary conditions to vacuum
  // Each loop is an equation. In order to make automatic analysis easier,
  // a distinct loop is defined for *_outflow and m_flow.
   for e loop
     h.hyd[e].m_flow = h.hyd[e].p/Rh;
   end for;
   for e loop
     h.hyd[e].h_outflow = HydraulicFluid.h_default;
     h.hyd[e].Xi_outflow = HydraulicFluid.X_default[1:HydraulicFluid.nXi];
     h.hyd[e].C_outflow = zeros(HydraulicFluid.nC);
   end for;
   for e loop
     h.air[e].m_flow = h.air[e].p/Rh;
   end for;
   for e loop
     h.air[e].h_outflow = AirMedium.h_default;
     h.air[e].Xi_outflow = AirMedium.X_default[1:AirMedium.nXi];
     h.air[e].C_outflow = zeros(AirMedium.nC);
   end for;
   for e loop
     h.fuel[e].m_flow = h.fuel[e].p/Rh;
   end for;
   for e loop
     h.fuel[e].h_outflow = FuelMedium.h_default;
     h.fuel[e].Xi_outflow = FuelMedium.X_default[1:FuelMedium.nXi];
     h.fuel[e].C_outflow = zeros(FuelMedium.nC);
   end for;
*/

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.5), graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics={Line(
          points={{-100,40},{-80,40},{-80,-40},{-100,-40}},
          color={255,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>The Plug is present in each Proxy. It must not be used directly by library users.</p>
<p>A proxy essentially extracts to its external interface exactly one of the connectors available in the outer hierarchical connector. If the implementation is left that simple, Proxy components appear unbalanced due to the large number of unknowns in the hierarchical connector which are left undefined. Plug has exactly the same content as the hierarchical connector and connects directly to it, therefore giving boundary conditions to all the variables.</p>
<p>The boundary conditions are the following:</p>
<ul>
<li>Frame : Frame has 12 degrees of freedom including 6 flow variables for cut-force and cut-torque. The general idea is to set all flow variables to zero in order to define a &QUOT;no-flow&QUOT; or &QUOT;open&QUOT; boundary condition, so cut-Force is always equal to the null vector. The Plug may contain a Root of the Virtual Connection Graph. Frames which are used in the model, will find a Root in MSL components they are connected to. Exactly one of the Plugs will get a Root Frame for each Frame of the hierarchical connector which is left unconnected. Frame really has 21 unknowns, but its R component which has 12 scalar variables, is overdetermined and only has 3 degrees of freedom. The connection graph generated by the Hierarchical System is directly acyclic, since it follows the model hierarchy. The Root must define all 12 potential variables, and the equation doing that, sets the orientation of the Root Frame to the unit rotation. This is exactly like the orientation of Modelica.Mechanics.MultiBody.Parts.Fixed.frame_b. Non-Root Frames will have an orientation equal to the orientation of the Root, because orientation is defined by potential variables and plain equality. The boundary condition at Non-Root Frames shall only define 6 conditions including the 3 on cut-force: the non-Root Frames simply set the cut-torque to the null vector. In doing this, they let the Root Frame completely free to define the orientation.</li>
<li></li>
</ul>
</html>"));
end Plug;
