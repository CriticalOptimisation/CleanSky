within EU_CleanSky.EDS.Utilities.ArrayInit.Source.UsersGuide;
model PositionOffsetExample "Position Offset Method"

  annotation (Documentation(info="<html>
<p>The modified example uses a simple Integer as the data source. The integer is used to offset the calculation of the parameters in the PInit function. In the example, the offset for table2 is equal to the size of table1, so initialisations continue as if table2 had been concatenated to the end of table1. There are no connections in this text only example.</p>
<p><br/>Note that the offset has been given a default value in the definition of Source. The declaration of table1 without an explicit offset uses this default value.</p>
<pre><code><font style=\"color: #0000ff; \">model</font>&nbsp;ArrayUtil_POM_Test&nbsp;
<font style=\"color: #006400; \">&nbsp;&nbsp;&QUOT;Example&nbsp;using&nbsp;position&nbsp;offset&nbsp;method&nbsp;to&nbsp;get&nbsp;different&nbsp;initialisation&nbsp;in&nbsp;different&nbsp;arrays.&QUOT;</font>
&nbsp;&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">Modelica.Icons.Example</font>;
&nbsp;&nbsp;<font style=\"color: #0000ff; \">package</font>&nbsp;MyArrayInit
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font><font style=\"color: #ff0000; \">ArrayInit</font>;
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;the&nbsp;custom&nbsp;set&nbsp;of&nbsp;parameters</font>
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">redeclare&nbsp;record</font>&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font>Params
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">parameter&nbsp;</font><font style=\"color: #ff0000; \">Real</font>&nbsp;strength;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">parameter&nbsp;</font><font style=\"color: #ff0000; \">String</font>&nbsp;name;
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>Params;
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #006400; \">//Declare&nbsp;custom&nbsp;data&nbsp;source</font>
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">redeclare&nbsp;record</font>&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font>Source
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">parameter&nbsp;</font><font style=\"color: #ff0000; \">Integer</font>&nbsp;offset=0&nbsp;<font style=\"color: #006400; \">&QUOT;position&nbsp;index&nbsp;offset&QUOT;</font>;
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>Source;
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;custom&nbsp;function&nbsp;to&nbsp;initialise&nbsp;component&nbsp;parameters&nbsp;based&nbsp;on&nbsp;the&nbsp;index&nbsp;in&nbsp;the&nbsp;table&nbsp;i.</font>
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">redeclare&nbsp;function</font>&nbsp;<font style=\"color: #0000ff; \">extends&nbsp;</font>PInit
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">algorithm&nbsp;</font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.strength&nbsp;:=&nbsp;1.0/(i&nbsp;+&nbsp;s.offset); <font style=\"color: #006400; \">//&nbsp;Initialisation&nbsp;algorithm&nbsp;is&nbsp;modified&nbsp;here.</font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p.name&nbsp;:=&nbsp;&QUOT;Component&nbsp;number&nbsp;&QUOT;&nbsp;+&nbsp;<font style=\"color: #ff0000; \">String</font>(i);
&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>PInit;
&nbsp;&nbsp;<font style=\"color: #0000ff; \">end&nbsp;</font>MyArrayInit;
&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;custom&nbsp;model&nbsp;extending&nbsp;custom&nbsp;parameters.&nbsp;In&nbsp;a&nbsp;real&nbsp;case,&nbsp;connectors&nbsp;and&nbsp;equations&nbsp;would&nbsp;be&nbsp;added.</font>
&nbsp;&nbsp;<font style=\"color: #0000ff; \">model</font>&nbsp;MyModel&nbsp;=&nbsp;<font style=\"color: #ff0000; \">MyArrayInit.Params</font>;
&nbsp;&nbsp;<font style=\"color: #006400; \">//&nbsp;Declare&nbsp;arrays&nbsp;of&nbsp;models,&nbsp;each&nbsp;begin&nbsp;initialised&nbsp;by&nbsp;a&nbsp;dedicated&nbsp;call&nbsp;to&nbsp;PInit.</font>
&nbsp;&nbsp;<font style=\"color: #ff0000; \">MyModel</font>&nbsp;table1[3]=<font style=\"color: #ff0000; \">MyArrayInit.Init</font>(table1);
&nbsp;&nbsp;<font style=\"color: #ff0000; \">MyModel</font>&nbsp;table2[5]=<font style=\"color: #ff0000; \">MyArrayInit.Init</font>(table2,&nbsp;<font style=\"color: #ff0000; \">MyArrayInit.Source</font>(offset=3));
<pre><font style=\"color: #0000ff; \">equation&nbsp;</font>
<font style=\"color: #0000ff; \">end&nbsp;</font>ArrayUtil_POM_Test;</code></pre>
<p><br/>The result plot show the parameter strength, which is defined as the inverse of the sum of position + offset, the offset being given by the data source.</p>
<p><img src=\"modelica://AutoSizedArrayOfModels3/cleanskyedsdav/trunk/EU_Cleansky/EDS/Utilities/Resources/PositionOffsetMethod.png\"/><code>
</html>"));
end PositionOffsetExample;
