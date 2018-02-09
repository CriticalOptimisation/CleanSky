within EU_CleanSky.EDS.Utilities;
encapsulated partial package HierarchicalConnection "This library provides the capability to create default hidden connections between a model and its components."
import Modelica;
import EU_CleanSky.EDS.Utilities;
import IntelligentPin;


annotation (Documentation(info="<html>
<p>This library provides a customisable way to automatically connect the hidden connector _HChiddenConn a System model to the same name hidden connector in its immediate Component children. It also works between subsystems, since the Subsystem models based upon PartialSubsystem inherit the properties of System and PartialComponent . </p>
<p>The created connection topology is a tree similar to the Modelica model hierarchy, joining all the Components to the hidden connector of the top level System model.</p>
<p>In order to use this library, a short package definition must be defined in which the empty connector type C is replaced by an application specific connector.</p>
<p><h4><font color=\"#008000\">Simple use:</font></h4></p>
<p>The simplest way to get a simulable model is a four-step process:</p>
<p><ol>
<li>Create your own application-specific package based upon<code> HierarchicalConnection</code></li>
<li><ol>
<li>Right click on<code> HierarchicalConnection</code> and choose &QUOT;New/Extend From...&QUOT;.</li>
<li>Provide a suitable package name and short documentation line for the new application-specific package.</li>
</ol></li>
<li>Define your own customised connector</li>
<li><ol>
<li>Right click on the new package and select &QUOT;New/Connector...&QUOT;.</li>
<li>Type in the name &QUOT;HierarchicalConnector&QUOT;</li>
<li>The tool should detect that a connector with that name already exists in the base package, and should propose to use <code><font style=\"color: #0000ff; \">redeclare&nbsp;</font></code>semantics</li>
<li>Check the generated code. The correct syntax is: <code><font style=\"color: #0000ff; \">redeclare connector extends</font>&nbsp;<font style=\"color: #ff0000; \">HierarchicalConnector</font> \"doc string\"; <font style=\"color: #0000ff; \">end</font>&nbsp;<font style=\"color: #ff0000; \">HierarchicalConnector</font>;</li>
<li>Apply your usual method to define the connector content: &QUOT;Edit/Variables/New Variable...&QUOT; or drag and drop from a library</li>
</ol></li>
<li>Create proxies based upon <ocde><font style=\"color: #ff0000; \">PartialProxy</font></code></li>
<li><ol>
<li>Open the &QUOT;extends Base&QUOT; base package and right click on <ocde><font style=\"color: #ff0000; \">PartialProxy</font></code></li>
<li>Give your proxy model a name, and fill in the documentation string</li>
<li>In the icon layer, add suitable connectors to the new model. The already present green square is the HierarchicalConnector. It is an internal connector</li>
<li>Create graphically the necessary connections between the HierarchicalConnector and the new interface connectors. The Modelica tool may be looking at the original definition of the connector, which is empty, and may not display the variables you have just added. In that case, just type in the name of the variable you want to connect to.</li>
</ol></li>
<li>Create your model</li>
<li><ol>
<li>You can either extend your model from the <code><font style=\"color: #ff0000; \">System</font></code> partial model in the Base package, or start from an empty model. Remember that <code><font style=\"color: #ff0000; \">Subsystem</font></code> instances from your customised hierarchical connection library can only be used in the scope of a <code><font style=\"color: #ff0000; \">System</font></code>. It is your choice to use the hierarchical connection in some parts of your model, and use ordinary connections in other parts.</li>
<li>Model representing subsystems must extend from <code><font style=\"color: #ff0000; \">PartialSubsystem</font></code>. You can only use your proxies inside a <code><font style=\"color: #ff0000; \">PartialSubsystem</font></code>.</li>
<li>To insert an instance of a subsystem in your model, just drag it into your diagram. However, if you want to create a node in the hierarchical connection tree, you must first insert graphically an instance of <code><font style=\"color: #ff0000; \">Subsystem</font></code> from your customised library, then you open it and graphically replace its replaceable <code><font style=\"color: #ff0000; \">content</font></code> with the chosen subsystem from your application. The icon of the <code><font style=\"color: #ff0000; \">Subsystem</font></code> instance can be customised using the parameters to display the information you need to see during simulations.
</ol></li>

</ol></p>
<p><h4><font color=\"#008000\">A more advanced model:</font></h4></p>
<p>The library contains an example of a more complex system, showing the use of intermediate subsystems. Like the whole System, the models of subsystems must be derived from <code>EU_CleanSky.EDS.Utilities.HierarchicalConnection.PartialSubsystem</code>. There is a small difference when the subsystems are used in a complex system. Instead of putting them in the diagram using drag and drop, the <code>EU_CleanSky.EDS.Utilities.HierarchicalConnection.Subsystem</code> library component should be used everytime. Using subsystems is a simple three-step graphical operation:</p>
<p><ol>
<li>Drag and drop the <code>Subsystem</code> library component into your diagram.</li>
<li>Right click on the newly created subsystem and select &QUOT;Show Component&QUOT; from the context menu.</li>
<li>Right click on the replaceable model &QUOT;content&QUOT;, and select your Subsystem model in the list that appears when selecting &QUOT;Change Class.../All Matching Choices&QUOT;.</li>
</ol></p>
<p><h4><font color=\"#008000\">More features:</font></h4></p>
<p>The library is used to create anonymous Subsystem models created by derivation of the <code>Subsystem</code> library component, and replacement of the &QUOT;content&QUOT; by a customised <code>PartialSubsystem</code>. While this approach adds intermediate levels to the model hierarchy, it does not add extra classes to your application library. There is a technical reason for these intermediate level, and they are currently inavoidable, but they can offer a handy summary of interface behaviour of their content.</p>
</html>"));
end HierarchicalConnection;
