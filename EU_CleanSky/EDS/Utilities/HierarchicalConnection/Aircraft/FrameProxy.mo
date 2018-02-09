within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft;
model FrameProxy "Local proxy of a global mechanical interface"
  extends Aircraft.Icons.InputOutputProxy;
  parameter S nr "The number of the frame to connect to in the frame array.";
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{
            90,-10},{110,10}})));
protected
  outer HierarchicalConnector hierarchy "Link from proxy to actual connector"         annotation (Placement(transformation(extent={{-76,-24},
            {-66,24}}),
        iconTransformation(extent={{-100,80},{-80,100}})), missingInnerMessage=
        "This class contains an \"outer HierarchicalConnector hierarchy\" declaration. Insert an \"Aircraft.System\" component higher in the component tree to get the matching inner declaration.");

  // Plug medium types are not reconfigurable in FrameProxy because
  // the choice of fluid is not relevant for a Frame. No fluid circulates anyway.
public
  Internal.Plug plug
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation
    connect(frame, hierarchy.frame[nr]) annotation (Line(
      points={{100,0},{-71,0}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(plug.h, hierarchy) annotation (Line(
      points={{-20,20},{-44,20},{-44,0},{-71,0}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-20},
            {100,20}}), graphics={Text(
          extent={{46,20},{94,-20}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString=DynamicSelect("%nr",String(nr)))}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>Does not check due to a bug in Dymola caused by the use of unspecified enumerations. The class checks if enumeration S is defined with at last one value.</p>
<p>In derived classes where S is overloaded, the class checks OK.</p>
</html>"));
end FrameProxy;
