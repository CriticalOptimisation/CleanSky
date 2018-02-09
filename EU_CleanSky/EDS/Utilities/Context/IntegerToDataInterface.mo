within EU_CleanSky.EDS.Utilities.Context;
partial block IntegerToDataInterface
  "Block computes an Data record from Integer inputs."
  extends .Modelica.Blocks.Interfaces.BlockIcon;

  parameter Integer n=0;
  .Modelica.Blocks.Interfaces.IntegerInput u[n] annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  DataOutput dataOutput annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  //dataOutput.xxx = u[1];
  annotation (preferredView="text", Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised)}));
end IntegerToDataInterface;
