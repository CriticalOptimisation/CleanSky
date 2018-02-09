within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft.Internal;
model UnitFramePlug
  "A model giving \"loose end\" boundary conditions to one Frame interface in HierarchicalConnector"
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
//   final parameter Modelica.SIunits.Resistance R=1e9 "Terminating resistor";
//   final parameter Modelica.Fluid.Types.HydraulicResistance Rh=1e9 "Leak to vacuum hydraulic resistance for all fluids";
  Utilities.PrintOnce printOnce(redeclare Boolean print=warn,
    msg="is a lone proxy. Please remove it from your model.",
    warn=true,
    name=true,
    uplevel=2,
    useInput=false)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  Boolean warn;
public
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}}), iconTransformation(extent={{-16,
            -16},{16,16}})));

equation
  // Unconnected frame boundary conditions

  //  The Mechanics.Multibody library relies on overdefined connectors.
  //  Because the connector from the MSL is already overdetermined the Roots are likely to be elsewhere in the model,
  //  in an aircraft structure diagram. When the Root is here, the Plug or the Proxy is probably unconnected.
  //  The accounting is not done exactly in the same way when checking Plug (21 equations with just the Frame part)
  //  and when checking a model containing only an unconnected Plug.
  //  With just one Plug in a model, the checker finds that r_0 is not used.

  Connections.potentialRoot(frame.R, 20000 - cardinality(frame));
  // Open boundary condition is "no torque applied".
  // Normal case: t=0
  // Unconnected case: the Plug will not be root unless there is a lone Plug, a lone Proxy or groups of
  //                   these connected together and to nothing else having Frame connectors. In that
  //                   eventuality the orientation will be set to a default value to avoid nuisance errors.
  if Connections.isRoot(frame.R) then
    // printOnce.u is a signal, but only the first time it becomes true causes a message to be printed.
    warn = true;
    frame.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
  else
    // zero torque opposing externally applied rotation
    warn = false;
    frame.t = zeros(3);
  end if;

  // Open boundary condition is "no force applied".
  // Normal case: f=0
  // Unconnected case: one of the interconnected floating Frames will be Root and may set a position.
  //                   it is only when just Plugs are floating together that one of them will set a position.
  if Connections.isRoot(frame.R) then
    // Provide position reference
    frame.r_0 = zeros(3);
  else
    frame.f = zeros(3);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.5), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{0,-40},{20,40}}), graphics={Line(
          points={{0,40},{20,40},{20,-40},{0,-40}},
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
end UnitFramePlug;
