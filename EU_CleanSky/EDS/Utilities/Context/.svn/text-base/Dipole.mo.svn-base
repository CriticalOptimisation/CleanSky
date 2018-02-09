within EU_CleanSky.EDS.Utilities.Context;
model Dipole

  Connector c1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Connector c2
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  Connections.branch(c1, c2);
  // create branch in connections graph
  c1.context = c2.context;
  // express equality, term by term.
  annotation (Documentation(info="<html>
<p>The dipole must be used inside application components having two or more poles, in order to interconnect the netlists on each pole and share the context among them. When there are more than 2 poles, they must be star connected using n-1 dipoles.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-100,40},{100,-38}},
          pattern=LinePattern.None,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),Text(
          extent={{-80,40},{80,-40}},
          pattern=LinePattern.None,
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid,
          textString="SHARE",
          lineColor={255,255,255})}));
end Dipole;
