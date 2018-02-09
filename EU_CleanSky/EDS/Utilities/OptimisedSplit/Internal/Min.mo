within EU_CleanSky.EDS.Utilities.OptimisedSplit.Internal;
block Min "Compute the minimum value of a vector"
  extends Modelica.Blocks.Interfaces.PartialRealMISO;
  parameter Real weights[nu] = ones(nu) "Power sharing weights";
equation
  y = min(if weights[i]>0 then u[i] else Modelica.Constants.inf for i in 1:nu);
  annotation (Documentation(info="<html>
<p>This block finds the minimum value among the input vector, but disregards inputs which are weighted zero or less in the selection.</p>
</html>"));
end Min;
