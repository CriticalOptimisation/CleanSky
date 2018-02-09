within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Base;
partial model PartialContext
  "A blank context diagram enhanced with the capability to handle proxies"

  inner HierarchicalConnector hierarchy
    "Connect to the System model hierarchy.";
  outer HierarchicalConnector internal
    "Implementation specific hidden connector." annotation (missingInnerMessage=
       "This class must only be used as the replaceable content of a \"Subsystem\".\nPut a \"Subsystem\" component in your model and replace the \"content\" component in diagram layer.\n\"Subsystem\" provides the correponding \"inner HierarchicalConnector internal\" component.");
  parameter String ssType="" "Type of this subsystem, redeclare final";
equation
  connect(hierarchy, internal);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,88},{-26,44}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,-40},{-26,-84}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,66},{-26,-62}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,32},{70,-14}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,68},{52,58}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,64},{52,-50}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-42},{72,-80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-56},{10,-66}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-120},{100,-160}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-100,156},{100,120}},
          lineColor={0,128,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="%ssType")}), Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics));
end PartialContext;
