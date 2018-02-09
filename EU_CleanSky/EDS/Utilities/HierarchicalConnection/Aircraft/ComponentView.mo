within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft;
partial model ComponentView
  "Description of a component or a collection of components"
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.5), graphics={
        Rectangle(
          extent={{100,-100},{-100,100}},
          lineColor={0,0,0},
          fillColor={252,252,252},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,74},{16,32}},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135}),
        Rectangle(
          extent={{6,20},{84,-22}},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135}),
        Rectangle(
          extent={{6,-40},{84,-82}},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135}),
        Line(
          points={{-42,32},{-42,-90}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-62,58},{-100,58}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,0},{-42,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,-58},{-42,-58}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-100,-140},{100,-100}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={252,252,252},
          fillPattern=FillPattern.Solid,
          textString="%name",
          fontSize=12)}), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.5)));
end ComponentView;
