within EU_CleanSky.EDS.Utilities.ArrayInit;
package UsersGuide "User's Guide"
extends Modelica.Icons.Info;


annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>Flexible models often rely on arrays to adjust their content to the conditions at the interface or the parameterisation. For instance the DynamicPhasor libary represents signals as an array of phasors. Each phasor component in the array must be initialised with the correct rank in order to capture the correct part of the input signal.</p>
<p>Unfortunately Modelica syntax does not give a lot of flexibility when writing array litterals. The chapter on litterals doesn&apos;t even cover arrays!</p>
<p>Modelica has a number of specialised array constructor functions, but they return arrays filled by scalar types. The general array constructor using the { } construct, can return arbitrary data types. </p>
<p>The correct way to do this, is to use a constructor function which will use the position of the component in the array to initialise the parameters of the components. The function will be called at the beginning of the simulation in order to initialise parameters. Another useful feature is to be able to pass the identification of a data source to the init function, in order to be able to get initialisation parameters from a database, for instance. The Source argument to the init function is an optional parameter. It the Source record is overloaded to contain data source identification, for instance the name of a file, the parameter will be available to initialise each component. The correct way to create an initialised array of component, with non-uniform values of the parameters is: </p>
<pre>
<code><font style=\"color: #0000ff; \">model</font>&nbsp;ArrayUtil_Test&nbsp;&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">Modelica.Icons.Example</font>;</code></p>
<code>&nbsp;&nbsp;<font style=\"color: #0000ff; \">package</font>&nbsp;MyArrayInit</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">ArrayInit</font>;</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;the&nbsp;custom&nbsp;set&nbsp;of&nbsp;parameters</font></code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">redeclare&nbsp;record</font>&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font>Params</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">parameter&nbsp;</font><font style=\"color: #ff0000; \">Real</font>&nbsp;strength;</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">parameter&nbsp;</font><font style=\"color: #ff0000; \">String</font>&nbsp;name;</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>Params;</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;custom&nbsp;function&nbsp;to&nbsp;initialise&nbsp;component&nbsp;parameters&nbsp;based&nbsp;on&nbsp;the&nbsp;index&nbsp;in&nbsp;the&nbsp;table&nbsp;i.</font></code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">function</font>&nbsp;MyCtor <font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">CtorType</font></code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">algorithm&nbsp;</font></code>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.strength&nbsp;:=&nbsp;1.0/i;
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.name&nbsp;:=&nbsp;&QUOT;Component&nbsp;number&nbsp;&QUOT;&nbsp;+&nbsp;<font style=\"color: #ff0000; \">String</font>(i);</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>MyCtor;</code>
<code>&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>MyArrayInit;</code>
<code>&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;custom&nbsp;model&nbsp;extending&nbsp;custom&nbsp;parameters.&nbsp;In&nbsp;a&nbsp;real&nbsp;case,&nbsp;connectors&nbsp;and&nbsp;equations&nbsp;would&nbsp;be&nbsp;added.</font></code>
<code>&nbsp;&nbsp;<font style=\"color: #0000ff; \">model</font>&nbsp;MyModel&nbsp;=&nbsp;<font style=\"color: #ff0000; \">MyArrayInit.Params</font>;</code>
<code>&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;array&nbsp;of&nbsp;models,&nbsp;each&nbsp;begin&nbsp;initialised&nbsp;by&nbsp;a&nbsp;dedicated&nbsp;call&nbsp;to&nbsp;PInit.</font></code>
<code>&nbsp;&nbsp;<font style=\"color: #ff0000; \">MyModel</font>&nbsp;table[3]=<font style=\"color: #ff0000; \">MyArrayInit.InitN</font>(3, MyArrayInit.MyCtor);</code>
<font style=\"color: #0000ff; \">equation&nbsp;</font>
<code><font style=\"color: #0000ff; \">end&nbsp;</font>ArrayUtil_Test;</code></pre>
<p>See <a href=\"Modelica://AutoSizedArrayOfModels3.ArrayInit.UsersGuide.AdvancedExamples\">Advanced Examples</a> for more complex situations.</p>
</html>"));
end UsersGuide;
