within EU_CleanSky.EDS.Utilities.ArrayInit.Source;
final function InitNSrc "Constructor of an array using a data source"
  input Integer n "Number of components in returned array";
  input Source source=SourceCtor() "Data source";
  input CtorSrcType ctor "Component constructor function";
  output Params a[n];
algorithm
  //a := array(ctor(i, source) for i in 1:n);
  //a := ctor(1:n, source);
  //a := InitFcnN(n, function ctor(s=source));
  for i in 1:n loop
    a[i] := ctor(i, source);
  end for;
  annotation (preferredView="info",
              Documentation(info="<html>
<p>The Source package allows the use of parameter constructors which accept a data source as their second input.  T</p>
</html>"));
end InitNSrc;
