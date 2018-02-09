within EU_CleanSky.EDS.Utilities.OptimisedSplit.Internal;
model PowerShareCalc "Computes the amount of power taken from each supply"
  parameter Integer corrType(min=0, max=1)=0 "Tyoe of correction applied" annotation(choices(choice=0
        "Proportional",                                                                                             choice=1
        "Corrected by V²"));
  parameter Integer n=3 "Number of wires in wire set";
  // These parameters are free sizing variables in the optimisation loop.
  // Gradients will be computed numerically using small variations of these values.
  // Defaults to all ones.
  parameter Real weights[n] = ones(n) "Power sharing weights";

  Modelica.Blocks.Interfaces.RealInput totalPwr
    annotation (Placement(transformation(extent={{-132,40},{-92,80}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,94})));
  Modelica.Blocks.Interfaces.RealOutput i[n]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput voltages[n] "For correction"
     annotation (Placement(transformation(extent={{-132,-20},{-92,20}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-112,0})));
protected
  Real total "Used for weight normalisation";
  Real corrections[n] "corrective factors";
equation
  corrections = if corrType==0 then ones(n) else voltages .* voltages;
  total=sum(max(0.0,weights[j]) * corrections[j] for j in 1:n);
  for j in 1:n loop
    assert(corrType == 1 or weights[j] < Modelica.Constants.eps or abs(totalPwr) < Modelica.Constants.eps or abs(voltages[j]) > Modelica.Constants.eps,"Erroneous model: With static weights (corrType=0), voltage cannot cross zero on an input with a positive weight, if totalPwr is not zero at the same time.");
    // The chosen equation never changes during a simulation, but depends on index i.
    // Dymola hard codes the path at compile time, so corrType is not available for changing at runtime.
    if corrType == 1 then
      // weights are corrected by V_i², so totalPwr * weight * corrections / voltagea / total = totalPwr * weight * voltages / total
      i[j] = totalPwr * max(weights[j],0.0) * voltages[j] / total;
    else // corrType == 0
      assert(corrType == 0, "BUG: please update code for new corrType");
      // This test depends on one of the inputs, the solver can take care of that.
      if abs(totalPwr) < Modelica.Constants.eps then
        // strict proportional. Null voltage yields infinite current unless totalPwr is zero.
        i[j] = 0.0;
      else
        i[j] = totalPwr * max(0.0,weights[j]) / total / (if weights[j] < Modelica.Constants.eps then 1.0 else voltages[j]);
      end if;
    end if;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,84},{62,-84}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,74},{46,42}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-42,12},{-26,-8}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-6,12},{10,-8}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{36,12},{52,-8}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-42,-36},{-26,-56}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-6,-36},{10,-56}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{36,-36},{52,-56}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-100,-100},{100,-120}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name",
          lineColor={0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>The component computes the current drawn from each power supply in order to effect a repartition of power controlled by weights, and optionally given voltages. The current is computed as the share of power divided by voltage. The share of power must therefore be zero if the voltage is zero. Since the voltages are dynamic and the weights are static, this is only achievable consistently if the total power (totalPwr) is zero. </p>
<p>The component asserts that if one voltage is zero, the total power is also zero when static weight are used.</p>
<p>If corrected weights are used, the correction is dynamic and the corrected weights are the product of the static weights with the square of the voltage.</p>
</html>"));
end PowerShareCalc;
