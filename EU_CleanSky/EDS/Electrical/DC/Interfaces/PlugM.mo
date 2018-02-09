within EU_CleanSky.EDS.Electrical.DC.Interfaces;
connector PlugM
  "A male electrical power supply connector with two wires, one of each polarity."
  WireM     p "Positive pin";
  WireF     n "Negative pin";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={170,213,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>The male plug shall be used for power supply connectors on loads. Equipment which may carry power like batteries shall have sockets or female plugs instead.</p>
<p>Due to the nature of the underlying representation, the male / female characterisation of the Electrical skin cannot match the male / female characterisation of the underlying graph. In the underlying graph, the male / female feature provides edge orientation, in order to create an oriented acyclic graph</p>
<p>The Electrical.DC skin makes it easy to design a network in which the positive power supply and the negative power supply have an identical layout allowing, for instance, twisted pair power distribution. </p>
</html>"));
end PlugM;
