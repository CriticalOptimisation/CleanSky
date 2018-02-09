within EU_CleanSky.EDS.Utilities.ArrayInit.Examples;
model CustomSourceInitFcnNSrc
  "Example using position offset method to get different initialisation in different arrays."
  extends Modelica.Icons.Example;
  package MyArrayInit
    import EU_CleanSky;
    extends EU_CleanSky.EDS.Utilities.ArrayInit.Source;

    // Declare the custom set of parameters
    redeclare record extends Params
      parameter Real strength;
      parameter String name;
    end Params;

    //Declare custom data source
    // Caution: Dymola will bug if all the parameters have default values.
    redeclare record extends Source('hidden'=false)
      parameter Integer offset "position index offset";
    end Source;

    // Declare custom constructor compatible with PInitType assuming a function partial application.
    function MyCtor
      extends CtorSrcType;
    algorithm
      p.strength := 1.0/(i + source.offset);
      // Initialisation algorithm is modified here.
      p.name := "Component number " + String(i);
    end MyCtor;

    // Optional: Declare default source constructor
    // Allows omitting source argument in calls to InitFcnXSrc.
    redeclare function SourceCtor
      output Source s "the data source to use";
    algorithm
      s.offset := 0;
    end SourceCtor;

  end MyArrayInit;
  // Declare custom model extending custom parameters. In a real case, connectors and equations would be added.
  model MyModel = MyArrayInit.Params;
  // Declare arrays of models, each begin initialised by a dedicated call to PInit.
  MyModel table1[3]=MyArrayInit.InitNSrc(size(table1, 1), ctor=MyArrayInit.MyCtor);
  // Omitted argument: source=MyArrayInit.Source(offset=0)

  MyModel table2[5]=MyArrayInit.InitNSrc(
      size(table2, 1),
      ctor=MyArrayInit.MyCtor,
      source=MyArrayInit.Source(offset=3));
  MyModel component=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor, source=
      MyArrayInit.Source(offset=8));
equation

  annotation (Documentation(info="<html>
<p>An example using a custom data source. Here the data source is a simple Integer, whose value affects the behaviour of the constructor. The data source record can be used to hold file reference, or database handles necessary to retrieve parameter values from files or other external data sources.</p>
</html>"));
end CustomSourceInitFcnNSrc;
