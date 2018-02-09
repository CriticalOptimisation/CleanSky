within EU_CleanSky.EDS.Kinematics;
model Fly
  "Change reference frame of atmospheric air from ECEF to aircraft relative environment"

  extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
    final allowFlowReversal = false,
    final dp_start = dp_nominal,
    m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small,
    m_flow(stateSelect = if momentumDynamics ==Modelica.Fluid.Types.Dynamics.SteadyState
                                                                           then StateSelect.default
                         else StateSelect.prefer));
  extends Internal.PartialLumpedFlow(
    final allowFlowReversal = false,
    final pathLength = 0,
    final momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyState);

  final parameter
    Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData data=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData(diameter_a=1,diameter_b=1,zeta1=0,zeta2=0,Re_turbulent=10000,D_Re=1)
    "Loss factor data";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=if system.use_eps_Re then system.m_flow_nominal else 1e2*system.m_flow_small
    "Nominal mass flow rate"
    annotation(Dialog(group="Nominal operating point"));

  // Advanced
  parameter Boolean from_dp = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

protected
  parameter Medium.ThermodynamicState state_nominal=Medium.setState_pTX(
                       Medium.reference_p,
                       Medium.reference_T,
                       Medium.reference_X)
    "Medium state to compute nominal pressure drop"                                        annotation(HideResult=true);
  parameter Modelica.SIunits.Pressure dp_nominal=
    Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.pressureLoss_m_flow(
                        m_flow_nominal, Medium.density(state_nominal), Medium.density(state_nominal), data, m_flow_small)
    "Nominal pressure loss";
  parameter Medium.AbsolutePressure dp_small = if system.use_eps_Re then dp_nominal/m_flow_nominal*m_flow_small else system.dp_small
    "Regularization of zero flow if |dp| < dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
  // Air intake
  parameter Modelica.SIunits.Area A0 "Front facing, flat air intake area";
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Advancing air intake"                                                       annotation (Placement(
        transformation(
        extent={{-16,-16},{16,16}},
        rotation=180,
        origin={80,0}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={60,0})));

  // Diagnostics
public
  parameter Boolean show_totalPressures = false
    "= true, if total pressures are included for plotting"
     annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
  Modelica.SIunits.AbsolutePressure p_total_a=port_a.p + 0.5*m_flow^2/((
      Modelica.Constants.pi/4*data.diameter_a^2)^2*Medium.density(state_a)) if
    show_totalPressures "Total pressure at port_a";
  Modelica.SIunits.AbsolutePressure p_total_b=port_b.p + 0.5*m_flow^2/((
      Modelica.Constants.pi/4*data.diameter_b^2)^2*Medium.density(state_a)) if
    show_totalPressures "Total pressure at port_a";
  parameter Boolean show_portVelocities = false
    "= true, if port velocities are included for plotting"
     annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
  Modelica.SIunits.Velocity v_a=port_a.m_flow/(Modelica.Constants.pi/4*data.diameter_a
      ^2*Medium.density(state_a)) "Fluid velocity into port_a";
  Modelica.SIunits.Velocity v_b=port_b.m_flow/(Modelica.Constants.pi/4*data.diameter_b
      ^2*Medium.density(state_a)) if show_portVelocities
    "Fluid velocity into port_b";

  // Variables
  Modelica.SIunits.Pressure p_dyn = 0.5*Medium.density(state_a)*v_a^2
    "maximum dynamic pressure";
  Real sigma "density ratio";
  Real pi "pressure ratio";
  Real alpha "cross section ratio";
  Modelica.SIunits.Area A_mean = Modelica.Constants.pi/4*(data.diameter_a^2+data.diameter_b^2)/2
    "mean cross flow area";

  Medium.ThermodynamicState state_b_des
    "Thermodynamic state at port b for flow a -> b";
  Medium.ThermodynamicState state_a_nondes
    "Thermodynamic state at port a for flow a <- b";

partial function AreaInterface
  input Real alpha "Areas ratio";
  input Modelica.SIunits.Position w[3]
      "aircraft referenced relative speed vector direction (normalised)";
  output Modelica.SIunits.Area Ainf "Intersected upstream cross section";
end AreaInterface;

function DefaultArea
  extends AreaInterface;
  input Modelica.SIunits.Area A0 "Geometric surface of flat intake";
  input Modelica.SIunits.Position n[3]
      "aircraft referenced air intake orientation";
algorithm
  Ainf := alpha*A0*w*Modelica.Math.Vectors.normalize(n); // dot product
end DefaultArea;

replaceable function area=DefaultArea(A0=A0, n=Modelica.Mechanics.MultiBody.Frames.axis(1));

  FrameVisualiser frameVisualiser
    annotation (Placement(transformation(extent={{48,-10},{28,10}})));
equation
  // Model is not valid with reverse flow
  Ib_flow = 0;
  F_p = A_mean*(Medium.pressure(state_b) - Medium.pressure(state_a));
  F_fg = A_mean*dp_fg;
  pi = port_b.p/port_a.p;
  sigma^1.4 = pi;
  alpha^2=sigma*(1-(pi-1)*port_a.p/p_dyn);

  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  // medium states for downstream properties, may want to change this neglecting the only difference from state_a, state_b, which is in pressure
  // This will remove the extra interaction variables
  state_b_des = Medium.setState_phX(port_b.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
  state_a_nondes = Medium.setState_phX(port_a.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

  connect(frameVisualiser.frame, frame_a) annotation (Line(
      points={{48,0},{80,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Documentation(info="<html>
<p>This model compute local dynamic air conditions near a flying subsonic aircraft. </p>
<p>Since height differences are neglected, the undisturbed local air conditions at the position of the aircraft should be used for port a. This port will typically be connected to the fluid port of an instance of the Air model. Momentum flow creates a drag force, which can be recovered on the Frame interface. The relative speed of air at port a is based on motion applied to this Frame interface. The inertial speed vector is converted to ECEF (earth surface relative) reference frame. There is a provision to add a wind vector which is also provided in ECEF reference frame. The resulting vector magnitude is <img src=\"modelica://EU_CleanSky/Images/equations/equation-lov83E7W.png\" alt=\"v_a\"/> . A replaceable function is provided, which takes the body relative normalised vector as an input, and calculates the air intake cross section. By default, this function is a dot product with the intake surface normal. The default is only appropriate for flat, almost front facing intakes where the operation will only apply small changes to the reference surface.</p>
<p>The model covers the flow area extending from infinity to the leading edge of an air intake, following the flow tube which is entering the intake. This part of the flow is isentropic in many cases. However, if the air intake is ingesting significant amounts of boundary layer flow, a different control surface placed upstream must be chosen, and a boundary layer, wall drag model has to be inserted. In the same fashion, for a supersonic flight, the control surface of port b must be placed before the first shock wave, because shocks are not isentropic and require specific equations. Only very simple and well characterised shock configurations can be handled in this fashion.</p>
<p>In these conditions and also with air intakes which have blunt leading edges, it might be difficult to know the actual intake area parameter value. This parameter is easy to determine for an air intake with sharp leading edges, which is operating normally. To make this case easier to solve, it is possible to define a function giving the apparent intake area as a function of the flow cross section ratio (the cross section increases as the flow slows down when it approaches the air intake). The default function has a constant intake area.</p>
<p>The model is acausal, but contains two presentations of the equations. Either the mass flow can be computed from the pressure difference, or the pressure increase can be computed from the mass flow. One of the methods might be faster, or easier to apply for the solver, depending on adjacent elements defining the boundary conditions.</p>
<p>The model consumes flow on port_a. The flow characteristics on port_a are expressed relative to an undisturbed local atmosphere. The Air model should be used, and will behave like a Modelica.Fluid.Sources.Boundary_pT source, providing air at the pressure and temperature prescribed by the Atmosphere definition for the current location. The Atmosphere definition is given by a set of functions in the outer TheEarth world instance.</p>
<p>The flow characteristics on port_b are expressed relative to the aircraft. In order to conserve flow kinetic energy, care should be taken to match the cross sections of successive components, at last until the kinetic energy has become negligible. A set of enhanced components calculating reactive forces are available to balance the dissipation of kinetic energy in high speed air intakes (wall drag and bends).</p>
<p>Based on environment data which is available on port_a if port_a is connected to an instance of Air, the model calculates:</p>
<p><img src=\"modelica://EU_CleanSky/Images/equations/equation-K1Hto7li.png\" alt=\"P_dyn=1/2*rho_a*v_a^2\"/></p>
<p>Note that in Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.BaseModelNonconstantCrossSectionArea v_a is an observable computed from m_flow, rho_a and diameter_a, whereas in this model it is typically m_flow which is computed from <img src=\"modelica://EU_CleanSky/Images/equations/equation-aRZU1yBx.png\" alt=\"rho_a\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-0x8r6d7n.png\" alt=\"A_inf\"/> and <img src=\"modelica://EU_CleanSky/Images/equations/equation-EtbmiOY7.png\" alt=\"v_a\"/> ,once <img src=\"modelica://EU_CleanSky/Images/equations/equation-0x8r6d7n.png\" alt=\"A_inf\"/> has been determined.</p>
<p>Then it solves 7 equations:</p>
<p>(1) <img src=\"modelica://EU_CleanSky/Images/equations/equation-8lBdtWAn.png\" alt=\"sigma=rho_b/rho_a\"/> definition of <img src=\"modelica://EU_CleanSky/Images/equations/equation-XdVx9vgh.png\" alt=\"sigma\"/></p>
<p>(2) <img src=\"modelica://EU_CleanSky/Images/equations/equation-wHxc3Ayh.png\" alt=\"sigma^gamma=P_b/P_a\"/> isentropic flow</p>
<p>(3) <img src=\"modelica://EU_CleanSky/Images/equations/equation-MSM3cvJN.png\" alt=\"[1-P_a/P_dyn*(sigma^gamma-1)]*sigma=(A_inf/A)^2\"/> Bernoulli&apos;s equation applied to the flow tube modelled by Fly.</p>
<p>(4) <img src=\"modelica://EU_CleanSky/Images/equations/equation-2dQUANNy.png\" alt=\"A_inf=Area(A_inf/A,-v_a/abs(v_a))\"/>, which defaults to <img src=\"modelica://EU_CleanSky/Images/equations/equation-qrKriyz1.png\" alt=\"A_inf=n * (-v_a/abs(v_a)) * A_0*(A_inf/A)\"/>, where n is the x axis of the Frame, allows a change in the effective area of the intake based on the operating condition of the intake. The second term is the body relative orientation of airflow at the intake taking into account wind and all aircraft motion (roll, yaw, pitch), but without taking into account the additional disturbance caused by the presence of the aircraft. Calculation of the local angle of attack and angle of sideslip should be made, and corrections based on CFD added, in order to properly take the local flow into account. For instance, masking during a sideslip, on a side mounted NACA scoop should be described here. The reverse function (4bis) must be defined too.</p>
<p>(4bis) <img src=\"modelica://EU_CleanSky/Images/equations/equation-n5OJ305p.png\" alt=\"A_inf/A=AreaRatio(A_inf,-v_a/abs(v))\"/> defaults to <img src=\"modelica://EU_CleanSky/Images/equations/equation-mpIuQHtB.png\" alt=\"A_inf/A = A_inf / (A_0*n*(-v_a/abs(v_a)))\"/></p>
<p>(5) <img src=\"modelica://EU_CleanSky/Images/equations/equation-K7DhdCuD.png\" alt=\"m_flow=rho_a*A_inf*v_a\"/> calculates the mass flow</p>
<p>(6) <img src=\"modelica://EU_CleanSky/Images/equations/equation-18CNR5gH.png\" alt=\"v_b=m_flow/(rho_b*A)\"/> calculates the air velocity at port_b (valid in the atmosphere, where the air density is non zero).</p>
<p>(7) <img src=\"modelica://EU_CleanSky/Images/equations/equation-BPjuItCB.png\" alt=\"A*(A_inf/A)=A_inf\"/></p>
<p>All the variables indexed by &apos;a&apos; should be computed by the Air model. They are static characteristics of the ambient air or simple geometric calculations based on aircraft motion and wind. Two typical boundary conditions are foreseen: </p>
<ul>
<li>known internal pressure (pressure is regulated). In that case, equations (2), (1), (3), (4), (7), (5) and (6) in that order allow the determination of <img src=\"modelica://EU_CleanSky/Images/equations/equation-Ft8m6OLG.png\" alt=\"sigma\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-Fxhh327l.png\" alt=\"rho_b\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-JVf6ddzr.png\" alt=\"A_inf\"/> over <img src=\"modelica://EU_CleanSky/Images/equations/equation-UYjvxeuS.png\" alt=\"A\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-JVf6ddzr.png\" alt=\"A_inf\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-UYjvxeuS.png\" alt=\"A\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-hEBM2O4n.png\" alt=\"m_flow\"/> and <img src=\"modelica://EU_CleanSky/Images/equations/equation-zGqohTaE.png\" alt=\"v_b\"/>.</li>
<li>known mass flow. In that case, equations (5), (4bis), (7), in that order allow the determination of <img src=\"modelica://EU_CleanSky/Images/equations/equation-JVf6ddzr.png\" alt=\"A_inf\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-JVf6ddzr.png\" alt=\"A_inf\"/> over <img src=\"modelica://EU_CleanSky/Images/equations/equation-UYjvxeuS.png\" alt=\"A\"/>, <img src=\"modelica://EU_CleanSky/Images/equations/equation-UYjvxeuS.png\" alt=\"A\"/>. It is then very difficult to calculate <img src=\"modelica://EU_CleanSky/Images/equations/equation-BRdSaqLq.png\" alt=\"sigma\"/> from equation (3), but the elevation to power 1.4 is quite linear, and it can be replaced by a linear homotopy operation. </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end Fly;
