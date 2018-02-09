within EU_CleanSky.EDS.Kinematics.Examples;
model TestTrajectory2D
  "Example of geostationary satellite using Location model."
  extends Modelica.Icons.Example;
  inner TheEarth world(
    worldCentreAtSurface=true,
    surfaceLongitude=0,
    animateWorld=false)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Location location(forcePosition=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Satellite                                    satellite(forcePosition=true)
    annotation (Placement(transformation(extent={{9,-8},{-9,8}},
        rotation=90,
        origin={-80,1})));
  Trajectory2D trajectory2D(                    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Com_DassaultAviation/Programs/FftiRhns/EMM/Resources/P400_Trajectories.txt"),
    flyEast=false,
    startLongitude=0,
    tableName="HSBJ_E1")
    annotation (Placement(transformation(extent={{32,0},{20,12}})));
equation
  connect(satellite.CG, location.NEDframe) annotation (Line(
      points={{-79.04,0.28},{-45.4,0.28},{-45.4,0},{-11,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(trajectory2D.position, location.positionInput) annotation (Line(
      points={{19.4,6},{10,6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics),
    experiment(StopTime=50000),
    __Dymola_experimentSetupOutput);
end TestTrajectory2D;
