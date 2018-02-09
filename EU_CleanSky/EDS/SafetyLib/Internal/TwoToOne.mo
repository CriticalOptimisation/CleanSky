within EU_CleanSky.EDS.SafetyLib.Internal;
partial model TwoToOne
  "A partial model having two P-type LogicPair and 1 N-type LogicPairs"

  LogicPairF f
    annotation (Placement(transformation(extent={{-102,-2},{-98,2}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  LogicPairM m1
    annotation (Placement(transformation(extent={{98,-42},{102,-38}}),
        iconTransformation(extent={{80,-20},{120,-60}})));
  LogicPairM m2
    annotation (Placement(transformation(extent={{98,38},{102,42}}),
        iconTransformation(extent={{80,20},{120,60}})));
initial equation
  // It is mandatory to delay propagation of signals when direction is reversed
  // in the Directed Acyclic Graph. Initial values of pre(x) is false.
  pre(m1.FtoM)=false;
  pre(m2.FtoM)=false;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={Polygon(
          points={{-100,20},{0,20},{100,60},{100,20},{50,0},{100,-20},{100,
              -60},{0,-20},{-100,-20},{-100,20}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end TwoToOne;
