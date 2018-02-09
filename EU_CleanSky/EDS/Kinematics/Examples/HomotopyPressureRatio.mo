within EU_CleanSky.EDS.Kinematics.Examples;
model HomotopyPressureRatio
  "Tests of homotopy operator to solve the pressure ratio in air intake problem"
  // parameters
  parameter Modelica.SIunits.Area a0 = 0.0133; // 13 cm diameter duct
  parameter Modelica.SIunits.MassFlowRate m_flow=0.21566; // kg/s d'air
  // inputs
  // point de vol M0.744, FL450
  input Modelica.SIunits.AbsolutePressure pa = 14746;
  input Modelica.SIunits.Temp_K ts = 251.65; // en Kelvin
  input Modelica.SIunits.Velocity tas = 236.58; // Mach 0.744 at FL450
  // outputs
  output Modelica.SIunits.Density rhoa = pa /(287*ts); // 0.204 kg/m3 (air)
  output Modelica.SIunits.AbsolutePressure pb = pa * pressureRatio;
  output Real pressureRatio(start=1);
  output Real densityRatio(start=1); // taux de compression volumique
  output Real areaRatio(start=1); // ratio of flow tube cross section ainf/a
  output Modelica.SIunits.Area a(start=a0);
  output Modelica.SIunits.Area ainf(start=a0);
  output Modelica.SIunits.PressureDifference dp = 0.5 * rhoa * tas^2;
  output Modelica.SIunits.AbsolutePressure pt = pa + dp;

  function AreaRatioPrototype
    input Modelica.SIunits.Area ainf;
    input Modelica.Mechanics.MultiBody.Frames.Orientation n
      "Relative orientation of ";
    output Real ratio;
  end AreaRatioPrototype;

  function DefaultAreaRatio
    extends AreaRatioPrototype;
    input Modelica.SIunits.Area a0;
  algorithm
    ratio := ainf/a0; // forces a to be a0.
  end DefaultAreaRatio;

  replaceable function AreaRatio = DefaultAreaRatio(a0=a0);
equation
  pressureRatio = pt/pa - dp/pa * areaRatio / densityRatio;
  pressureRatio = homotopy(actual=densityRatio^1.4, simplified=1.76903*densityRatio-0.76903);
  areaRatio = AreaRatio(ainf);
  m_flow = rhoa * ainf * tas;
  a = ainf/areaRatio;
end HomotopyPressureRatio;
