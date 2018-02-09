within EU_CleanSky.EDS.Utilities.ArrayInit.Base;
final function InitOne
  "Constructor of a single component instance, exactly like the sole component in an array of size 1, using a function formal parameter."
  //input Integer n=1 "number of components";
  input CtorType ctor;
  output Params p;
algorithm
  //long form is : a := array(Init(i, Source.'constructor'.fromReal(0.0)) for i in 1:n);
  p := ctor(1);
  annotation (preferredView="info", Documentation(info="<html>
<p>The usage principle is to extend the ArrayInit.Base package and inside it, redeclare a record containing the parameters needed by the application. The correct syntax for extending <code>Params</code> is:</p>
<pre>redeclare record extends Params;
...
end Params;
<p><code>InitOne()</code> returns the result of calling the constructor for postion<code> i=1</code>. If the constructor is a pure Modelica function, all the components initialised using the same constructor have the same set of parameters. The constructors are normally declared in the derivative package and extend from<code> CtorType</code>.</p>
</html>"));
end InitOne;
