within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base.Icons;
model InputOutputProxy
  "Suggested icon for simple proxies giving access to one member of hierarchical connector"

  annotation (
    defaultComponentName="input1",
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics),
    Icon(coordinateSystem(extent={{-100,-20},{100,20}},preserveAspectRatio=
            false), graphics={Polygon(
          points={{-100,20},{-100,-20},{80,-20},{100,0},{80,20},{-100,20}},
          lineColor={0,0,255},
          smooth=Smooth.None), Text(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          textString="%name")}));
end InputOutputProxy;
