within EU_CleanSky.EDS.Utilities.HierarchicalConnection.AircraftExample;
package F7X 
  extends Aircraft(
  redeclare type S = F7X_StructureConnections,
  redeclare type E = F7X_ElectricalConnections);


  redeclare package extends Icons

    model Battery "Battery Icon used for proxies"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,60},{100,-80}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Solid,
              fillColor={156,166,255}),
            Text(
              extent={{-64,40},{-20,-6}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{30,40},{74,-6}},
              lineColor={0,0,255},
              textString="−")}));
    end Battery;

    model Heater "Heater icon for use in Proxies"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,60},{100,-100}},
              lineColor={0,0,255},
              fillColor={156,166,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-78,40},{80,40}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-78,18},{80,18}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-78,-8},{80,-8}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-48,14},{-48,62},{-20,34},{-20,90}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{-14,14},{-14,62},{14,34},{14,90}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{20,14},{20,62},{48,34},{48,90}},
              color={255,0,0},
              smooth=Smooth.None)}));
    end Heater;

    model Bonding "Electrical connection to structure icon used for proxies"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),                                                                    graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-76,-18},{74,-18}},
            color={0,0,255},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{42,-18},{8,-64}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{12,-18},{-22,-64}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-18,-18},{-52,-64}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-52,-18},{-86,-64}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{2,54},{2,-18}},
            color={0,0,255},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{74,-18},{40,-64}},
            color={0,0,255},
            smooth=Smooth.None)}));
    end Bonding;

    model Subsystem "A subsystem with more resistors and a heater"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-100,100},{0,0}},
              lineColor={0,0,255},
              fillColor={156,166,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,0},{100,-100}},
              lineColor={0,0,255},
              fillColor={156,166,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,80},{98,0}},
              lineColor={0,0,255},
              fillColor={156,166,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{20,60},{78,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{20,38},{78,38}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{34,44},{34,82},{62,56},{62,96}},
              color={255,0,0},
              smooth=Smooth.None)}));
    end Subsystem;
  end Icons;

end F7X;
