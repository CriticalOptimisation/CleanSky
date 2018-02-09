within EU_CleanSky.EDS.Utilities.ArrayInit.Base;
final function InitN
  "Constructor of an array of size n, using a specific constructor function."
  input Integer n "Size of array to fill";
  input CtorType ctor;
  output Params a[n];
algorithm
  a := array(ctor(i) for i in 1:n);
  // Modelica specification allows vectorisation only for functions returning a scalar type.
  //a := ctor(1:n);
  annotation (
    Inline=true,
    preferredView="info",
    Documentation(info="<html>
<p>The usage principle is to extend the ArrayInit.Base package and inside it, redeclare a record containing the parameters needed by the application. The correct syntax for extending Params is:</p>
<pre>redeclare record extends Params;
...
end Params;</pre>
<p>The automatically generated derivative functions can then be used to initialise the parameters of any class derived from the extended <code>Params</code> record. It is possible to extend records into longer records, connectors, blocks or models/classes. It is also possible to put the core parameters of a model in a dedicated record, which is a component of that model. In that case a modifier<code> (params=InitN(...))</code> can be used to set the value of the parameters.</p>
<p><code>InitN()</code> returns an array of <code>n Params</code> records, which can be used in an assignment to initialise an array of components extending the<code> Params </code>record, or in a modifier as explained above. </p>
<p>See example <a href=\"Modelica://EU_CleanSky.EDS.Utilities.ArrayInit.Examples.BaseInitN\">BaseInitN</a>.</p>
</html>"));
end InitN;
