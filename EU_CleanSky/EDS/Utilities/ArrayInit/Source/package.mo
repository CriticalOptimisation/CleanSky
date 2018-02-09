within EU_CleanSky.EDS.Utilities.ArrayInit;
package Source "Easily initialise parameters of array components, using a custom contructor with an additional data source argument."
extends Base;


replaceable record Source "Data source"
  replaceable parameter Boolean 'hidden'
    "Prevent Dymola bug from removing Source as a formal parameter in constructor";
end Source;

//    replaceable partial function Ctor
//      extends CtorSourceType;
//    end Ctor;


replaceable function SourceCtor
  "Allow the creation of an empty default source from a function call"
  output Source s('hidden'=true) "dummy output";
algorithm
  annotation (preferredView="info");
end SourceCtor;

end Source;
