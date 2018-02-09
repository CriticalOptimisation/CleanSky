within EU_CleanSky.EDS.Utilities.ArrayInit.Examples;
model AutomaticNumbering
  "Example using a library data source to give unique consecutive initialisation numbers to items."
  extends Modelica.Icons.Example;

  // External object type
  encapsulated class Sequence "An external object which counts up from one."
    extends ExternalObject;

    function constructor
      output InitialisationOrder ex;
    external"C" ex = ExternalObjectInstanceCounter_ctor() annotation (
        IncludeDirectory=
            "modelica://EU_CleanSky/EDS/Utilities/Resources/Include",
        LibraryDirectory=
            "modelica://EU_CleanSky/EDS/Utilities/Resources/Library",
        Include="#include \"ExternalObjectInstanceCounter.h\"",
        Library="ExternalObjectInstanceCounter");

    end constructor;

    function destructor
      input InitialisationOrder ex;
    external"C" ExternalObjectInstanceCounter_dtor(ex) annotation (
        IncludeDirectory=
            "modelica://EU_CleanSky/EDS/Utilities/Resources/Include",
        LibraryDirectory=
            "modelica://EU_CleanSky/EDS/Utilities/Resources/Library",
        Include="#include \"ExternalObjectInstanceCounter.h\"",
        Library="ExternalObjectInstanceCounter");

    end destructor;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-130,90},{80,-98}},
            lineColor={0,0,0},
            textString="C",
            fontName="Times New Roman",
            textStyle={TextStyle.Italic}),
          Line(
            points={{64,62},{64,4}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{40,40},{90,40}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{64,-18},{64,-76}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{40,-40},{90,-40}},
            color={0,0,0},
            smooth=Smooth.None)}));
  end Sequence;

  encapsulated function Sequence_Next
    "Creates the next counter and returns its id."
    input Integer n;
    output Integer y;
  external"C" y=  ExternalObjectInstanceCounter_next(n) annotation (
      IncludeDirectory="modelica://EU_CleanSky/EDS/Utilities/Resources/Include",
      LibraryDirectory="modelica://EU_CleanSky/EDS/Utilities/Resources/Library",
      Include="#include \"ExternalObjectInstanceCounter.h\"",
      Library="ExternalObjectInstanceCounter");

  end Sequence_Next;

  encapsulated function Sequence_Count "Count items in a group"
    import InitialisationOrder =
      EU_CleanSky.EDS.Utilities.ArrayInit.Examples.AutomaticNumbering.Sequence;
    import EU_CleanSky;
    input
      EU_CleanSky.EDS.Utilities.ArrayInit.Examples.AutomaticNumbering.Sequence
      ex;
    output Integer y;
  external"C" y=  ExternalObjectInstanceCounter_count(ex) annotation (
      IncludeDirectory="modelica://EU_CleanSky/EDS/Utilities/Resources/Include",
      LibraryDirectory="modelica://EU_CleanSky/EDS/Utilities/Resources/Library",
      Include="#include \"ExternalObjectInstanceCounter.h\"",
      Library="ExternalObjectInstanceCounter");

  end Sequence_Count;

  package MyArrayInit
    extends ArrayInit.Source;
    // Declare the custom set of parameters
    redeclare record extends Params
      parameter Integer number;
    end Params;

    //Declare custom data source
    // Caution: Dymola will bug if all the parameters have default values.
    redeclare record extends Source('hidden'=false)
      parameter String name "Name of source";
      parameter Integer id "counter identifier";
      parameter Sequence counter(id=id) "item counter in a group";
    end Source;

    // Declare custom constructor
    function MyCtor
      input Integer i "the position in the array";
      input Source source "the data source";
      output Params p "the initialised record";
    algorithm
      p.number := Sequence_Count(source.counter);
    end MyCtor;
  end MyArrayInit;
  // Declare custom model extending custom parameters. In a real case, connectors and equations would be added.

  model MyModel
    parameter MyArrayInit.Params params;
  end MyModel;
  // Data source 1
  constant MyArrayInit.Source source1(name="SRC1",id=1);
  // 1st data source for 1st sequence.
  constant MyArrayInit.Source source2(name="SRC2",id=2);
  // 2nd data source for independant 2nd sequence.

  MyModel component1(params=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor,
        source=source1));
  MyModel component2(params=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor,
        source=source2));
  MyModel component3(params=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor,
        source=source1));
  // Code below works but generates unexpected sequence numbers 3 and 6 (and 4 low level function calls rather than 2).
  // This behaviour results from flattening, which produces table[1]=function()[1]; table[2]=function()[2];
  // The first function call generates {3,4} and 3 is kept, and the second generates {5,6} and 6 is kept.
  //   MyModel table[2]=MyArrayInit.InitFcnNSrc(
  //       2,
  //       ctor=MyArrayInit.MyCtor,
  //       source=source1);
  // For any constructor which does not use the position in the table, it is possible to initialise each model
  // with a call to InitOneSrc. The following construct has the expected behaviour in Dymola. However unless
  // a tool implements correctly the "impure" function semantics, there is not certainty.
  MyModel[3] table(each params=MyArrayInit.InitOneSrc(ctor=MyArrayInit.MyCtor,
        source=source1));

  annotation (Documentation(info="<html>
<p>Constructors are passed the position in the current array <code>i</code>, or 1 if building an isolated component, and the source component. However in this example, the constructor does not use <code>i</code>. It relies instead on an external library which associates a dedicated storage memory to each source, and offers a <code>count()</code> function returning numbers in sequence. The constructor does not use the position in the current array, but rather calls <code>count()</code> on the current source. </p>
<p>Remember that Modelica is translated to flat Modelica, a form with only scalar variables. When these scalars are bound parameters, each is associated with a binding equation. When the equation is written in Modelica, Dymola can evaluate the parameters and their value is given as a litteral expression in the flat Modelica file. However in this example, the expression calls an external C function which is not available when the code is generated. The bound parameters are set by calls to the external library. In Dymola the parameters seems to be initialised in the order of the model code, and in depth-first search order for a hierarchical model.</p>
<p>Modelica sorts the parameters according to their interdependencies and will always initialise the source objects before their dependent parameters.</p>
</html>"));
end AutomaticNumbering;
