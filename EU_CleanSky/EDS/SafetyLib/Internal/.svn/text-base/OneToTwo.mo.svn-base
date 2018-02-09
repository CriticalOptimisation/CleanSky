within EU_CleanSky.EDS.SafetyLib.Internal;
partial model OneToTwo
  "A partial model having one P-type LogicPair and 2 N-type LogicPairs"

  LogicPairM m
    annotation (Placement(transformation(extent={{-102,-2},{-98,2}}),
        iconTransformation(extent={{-80,-20},{-120,20}})));
  LogicPairF f1
    annotation (Placement(transformation(extent={{98,-42},{102,-38}}),
        iconTransformation(extent={{120,-20},{80,-60}})));
  LogicPairF f2
    annotation (Placement(transformation(extent={{98,38},{102,42}}),
        iconTransformation(extent={{120,20},{80,60}})));
initial equation
  // It is mandatory to delay propagation of signals when direction is reversed
  // in the Directed Acyclic Graph. Initial values of pre(x) is false.
  pre(f1.MtoF)=false;
  pre(f2.MtoF)=false;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={Polygon(
          points={{-100,20},{0,20},{100,60},{100,20},{50,0},{100,-20},{100,
              -60},{0,-20},{-100,-20},{-100,20}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end OneToTwo;
