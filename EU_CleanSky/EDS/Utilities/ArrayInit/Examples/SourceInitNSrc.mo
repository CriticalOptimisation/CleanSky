within EU_CleanSky.EDS.Utilities.ArrayInit.Examples;
model SourceInitNSrc
  extends Modelica.Icons.Example;
  package MyArrayInit
    extends ArrayInit.Source;
    // Declare the custom set of parameters
    redeclare record extends Params
      parameter Real strength;
      parameter String name;
    end Params;
    // Declare custom function to initialise component parameters based on the index in the table i.
    function MyCtor
      extends CtorSrcType;
    algorithm
      p.strength := 1.0/i;
      p.name := "Component number " + String(i);
    end MyCtor;
  end MyArrayInit;
  // Declare custom model extending custom parameters. In a real case, connectors and equations would be added.
  //model MyModel = MyArrayInit.Params;
  // Declare array of models, each begin initialised by a dedicated call to Ctor.
  MyArrayInit.Params table[2]=MyArrayInit.InitNSrc(size(table, 1), ctor=
      MyArrayInit.MyCtor);
  MyArrayInit.Params component=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor);
equation

  annotation (Documentation(info="<html>
<p>Example using the <code>InitNSrc</code> and <code>InitOneSrc</code> functions, and a constructor implementing the function interface CtorSrcType from the library.</p>
</html>"));
end SourceInitNSrc;
