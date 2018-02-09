within EU_CleanSky.EDS.Utilities.ArrayInit.Source;
final function InitOneSrc
  "Constructor of a single component instance, exactly like the sole component in an array of size 1."
  //input Integer n=1 "number of components";
  input Source source=SourceCtor();
  input CtorSrcType ctor;
  output Params p;
algorithm
  p := InitOne(function ctor(source=source));
  annotation (preferredView="info");
end InitOneSrc;
