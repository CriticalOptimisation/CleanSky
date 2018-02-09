within EU_CleanSky.EDS.Utilities.ArrayInit.Examples;
model BaseInitN "Test of InitFcnN array initialiser."
  extends Modelica.Icons.Example;

  package MyArrayInit
    extends Base;
    // Declare the custom set of parameters
    redeclare record extends Params
      parameter Real strength;
      parameter String name;
    end Params;
    // Declare custom function to initialise component parameters based on the index in the table i.
    function MyCtor
      extends CtorType;
    algorithm
      p.strength := 1.0/i;
      p.name := "Component number " + String(i);
    end MyCtor;
    // It is of course possible to define several different constructor functions for the same parameter set.
    // Each call to one the InitFcnX functions must specify which constructor is used.
  end MyArrayInit;

  // Declare custom model extending custom parameters. In a real case, connectors and equations would be added.
  model MyModel = MyArrayInit.Params;
  // Declare array of models, each begin initialised by a dedicated call to PInit.
  MyModel table[3]=MyArrayInit.InitN(3, MyArrayInit.MyCtor);
  MyModel one=MyArrayInit.InitOne(MyArrayInit.MyCtor);
equation

  annotation (
    Documentation(info="<html>
<p>Show use of functions <code>ArrayInit.Base.InitN</code> and <code>ArrayInit.Base.InitOne</code> to perform custom initialisation of components, either standalone or in an array.</p>
</html>"),
    experiment(__Dymola_NumberOfIntervals=2),
    __Dymola_experimentSetupOutput);
end BaseInitN;
