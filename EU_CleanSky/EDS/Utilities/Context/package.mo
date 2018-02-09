within EU_CleanSky.EDS.Utilities;
package Context 


replaceable record Data
  "Empty placeholder which must be replaced by user in derived package."

end Data;


annotation (preferredView="info", Documentation(info="<html>
<p>The correct method to use this package is to create a derivative package in which the Data record is replaced by another record having the required context information.</p>
<p>For example, a typical use would be:</p>
<pre><code><font style=\"color: #0000ff; \">package</font>&nbsp;AngleContext&nbsp;
<font style=\"color: #006400; \">&nbsp;&nbsp;&QUOT;Spreads&nbsp;angle&nbsp;information&nbsp;in&nbsp;a&nbsp;dynamic&nbsp;time&nbsp;phasor&nbsp;network.&QUOT;</font>
&nbsp;&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">Context</font>(<font style=\"color: #0000ff; \">redeclare&nbsp;record</font>&nbsp;Data&nbsp;=&nbsp;<font style=\"color: #ff0000; \">Angle</font>);
&nbsp;&nbsp;<font style=\"color: #0000ff; \">record</font>&nbsp;Angle
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #ff0000; \">Modelica.SIunits.Angle</font>&nbsp;theta&nbsp;<font style=\"color: #006400; \">&QUOT;Angle&nbsp;of&nbsp;fundamental&nbsp;AC&nbsp;signal&nbsp;information.&QUOT;</font>;
&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>Angle;
<font style=\"color: #0000ff; \">end&nbsp;</font>AngleContext;
</pre>
<p>In this example, the new record which is defined for the application specific context contains the shared variable <code>theta</code>. The classes defined in Context are automatically available in AngleContext. Partial classes are provided: <b>X</b><code>ToDataInterface</code> and <code>SourceInterface</code>.</p>
<p>The first one is a block which will provide additional equations defining the context when a source is chosen as a root. Its input is a record of type <code>>Data</code>. Since it is not immediately easy to declare a record definition expression, the <b>X</b><code>ToDataInterface</code> enable users to quickly write multiplexer blocks from basic types to the custom defined Data record type. One of these partial blocks has no predefined inputs, so users are free to add the necessary ones.</p>
<p>A new source called <code>ConstantFrequency</code> is also defined. It has to be an elementary component in which the context variables are set. The context variables are fully time-dependent, and can be dependent upon any time-dependant variable in the simulation.The context can contain continuous and discrete variables.</p>
<p>This package is not a solution capable of propagating parameters along the topology. Parameters cannot be propagated across connections. The only way to propagate parameters is hierarchically, since they can be defined by expressions using parameters of their parent class.</p>
</html>"));
end Context;
