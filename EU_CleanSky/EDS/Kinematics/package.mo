within EU_CleanSky.EDS;
package Kinematics "Flight Kinematics modeled following closely the JSBSim FDM"



annotation (Documentation(info="<html>
<p>TheEarth extends from Modelica.Mechanics.MultiBody.World. Some models defined in this library require the additional capabilities provided by TheEarth. Otherwise, TheEarth is compartible with World and all the components from the multibody mechanics package of the standard library can work with it. </p>
<h5>Replaceable Gravity Model</h5>
<p>In particular, the World defines a replaceable function gravityAcceleration which is by default a spherical gravity field. This model is invalid close to the Earth surface, and in particular the gravity vector always points directly to the center of the Earth, rather than in the local &QUOT;down&QUOT; direction. The model is nevertheless correct on the equator, if g is adjusted for the latitude zero. Because people on the equator are farther from the center of the Earth than people on the poles, the gravity is lower on the equator. In the EU_CleanSky implementation of TheEarth, the MSL standardGravityAcceleration is used with a corrected mue constant, such that g=9.7803267714 on the equator (taking into account centrifugal effect).</p>
<p>The new value of mue is marked final, because a completely different gravity function would need to be written in order to have a valid gravity field far from the equator. The current solution is also invalid for space trajectories in high orbits, where the effect of gravitational field disturbances dissipate. The long distance gravitational field of Earth is correctly approximated by the average field of a point mass, with the default value of mue. This library, which models the rotation of the Earth, is intended for use on aircraft flight and possibly rockets. The gravity would not be correct on a geostationary orbit for instance.</p>
<h5>Frame visualiser</h5>
<p>The FrameVisualiser component can be attached to any Frame interface. In the Animation window, three arrow will show the orientation of the frame in space. </p>
</html>"));
end Kinematics;
