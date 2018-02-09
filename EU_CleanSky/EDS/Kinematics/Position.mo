within EU_CleanSky.EDS.Kinematics;
record Position "Position record"
  Modelica.SIunits.Angle longitude;
  Modelica.SIunits.Angle latitude; // Always zero in this version
  Modelica.SIunits.Angle geodeticLatitude; // Always zero in this version
  Modelica.SIunits.Radius radius;  // Distance to the center of the Earth
  Modelica.SIunits.Distance geodeticAltitude; // Altitude géodétique
  annotation (Documentation(info="<html>
<p>The difference between geodetic latitude, and latitude is the difference between the WGS-84 elliptical model of the Earth and the much simpler spherical approximation. The latitude is the correct angle between the equatorial plane and the line going through the center of the Earth and the current position. The geodetic latitude is defined in terms of the orientation of the local Earth surface. They are equal on the equator and at the poles.</p>
<p>The connector is overdetermined.</p>
</html>"));
end Position;
