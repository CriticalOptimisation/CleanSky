within EU_CleanSky.EDS.Utilities.HierarchicalConnection.Aircraft;
package Interfaces
  "New physically based ports, all are icon variations of MSL connectors."
  extends Modelica.Icons.InterfacesPackage;
  connector HydrPort "Hydraulic Fluid Connector"
    extends Modelica.Fluid.Interfaces.FluidPort;
    annotation (defaultComponentName="port_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Sphere),Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Sphere)}));
  end HydrPort;

  connector AirPort "Hydraulic Fluid Connector"
    extends Modelica.Fluid.Interfaces.FluidPort;
    annotation (defaultComponentName="port_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid)}));
  end AirPort;

  connector FuelPort "Fuel Fluid Connector"
    extends Modelica.Fluid.Interfaces.FluidPort;
    annotation (defaultComponentName="port_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={213,255,170},
            fillPattern=FillPattern.Sphere),Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={213,255,170},
            fillPattern=FillPattern.Sphere)}));
  end FuelPort;

  expandable connector Data "Global avionics busses"
    extends Modelica.Icons.SignalBus;
  end Data;
end Interfaces;
