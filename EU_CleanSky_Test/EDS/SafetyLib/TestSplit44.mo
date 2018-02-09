within EU_CleanSky_Test.EDS.SafetyLib;
model TestSplit44 "Split low / Merge two loads to one sink"
  import EU_CleanSky.EDS.SafetyLib;

  EU_CleanSky.EDS.SafetyLib.Split split1
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load2(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,-10})));
  EU_CleanSky.EDS.SafetyLib.Cap sink(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  EU_CleanSky.EDS.SafetyLib.PolarisedLoad load1(
    semantics=EU_CleanSky.EDS.SafetyLib.Semantics.electrical,
    useLeak=false,
    useOpen=false,
    final useReverseInterface=true)
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  EU_CleanSky.EDS.SafetyLib.Sources.HiPotential sinkP(gender=EU_CleanSky.EDS.SafetyLib.Gender.male)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-50})));
  EU_CleanSky.EDS.SafetyLib.Sources.LoPotential logicFlowPCap(gender=
        EU_CleanSky.EDS.SafetyLib.Gender.female)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  EU_CleanSky.EDS.SafetyLib.Link link(useOpen=false, useLeak=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
equation
  connect(split1.f2, load2.minusM) annotation (Line(
      points={{-10,32},{-10,16},{-10,0},{-10,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sink.p, load1.plusF) annotation (Line(
      points={{60,40},{40,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(split1.f1, load1.minusM) annotation (Line(
      points={{0,40},{20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(load2.plusF, sinkP.m) annotation (Line(
      points={{-10,-20},{-10,-30},{-10,-30},{-10,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.n, split1.m) annotation (Line(
      points={{-40,40},{-20,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(link.p, logicFlowPCap.f) annotation (Line(
      points={{-60,40},{-80,40}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(NumberOfIntervals=2),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>When a leak is created in &QUOT;link2&QUOT;, the load continues to run although spent power is evacuated to the environment through the leak.</p>
<p>The condition for a load to be correctly powered from a power system are:</p>
<p><ul>
<li>It must receive a low signal on its N side and a high signal on its P side.</li>
<li>It must not receive a ground signal on both N and P.</li>
<li>It must not be traversed by an &QUOT;open&QUOT; signal in either direction, since that indicates a blocked flow / open circuit.</li>
</ul></p>
</html>"));
end TestSplit44;