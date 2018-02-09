within EU_CleanSky.EDS.Utilities.ArrayInit.Examples;
model TriangularMatrix
  "Demonstrates how storage for a triangular matrix can be allocated."
  extends Modelica.Icons.Example;

  package MyArrayInit
    extends Base;
    // Declare the custom set of parameters
    redeclare record extends Params
      Real data[n];
      parameter Integer n;
    end Params;
    // Declare custom function to initialise component parameters based on the index in the table i.
    function MyCtor
      //      extends Base.CtorType;
      input Integer i "the position in the array";
      output Params p(n=i) "the initialised record";
    algorithm
      for j in 1:i - 1 loop
        p.data[j] := 0.0;
      end for;
      p.data[i] := 1.0;
    end MyCtor;
    // Structural change impacts output parameter declaration in InitN
    function MyInitN
      input Integer n;
      input CtorType ctor;
      output Params[n] a(n=1:n);
    algorithm
      a := InitN(n, ctor);
    end MyInitN;
  end MyArrayInit;

  // Declare custom model extending custom parameters. In a real case, connectors and equations would be added.
  model Matrix "Storage for elements in a triangular or a symmetric matrix."
    parameter MyArrayInit.Params params;
  end Matrix;

  // Declare array of models, each begin initialised by a dedicated call to PInit.
  Matrix matrix[3](params=MyArrayInit.MyInitN(3, MyArrayInit.MyCtor));
  annotation (
    Documentation(info="<html>
<p>Demonstrates a case where the array position index is used to initialise an array size in<code> Params</code>. The example checks and compiles, but a warning says: </p>
<p><h4><font color=\"#008000\">Unsupported: Using array of records of unknown size in function.</p><p>That is not yet supported in dsmodel.c, and the function will fail if called in the model.</font></h4></p>
<p>and the function actually fails in the model.</p>
<p>The check shows that Dymola understands that <code>n</code> has different values in  each instance in the array of records <code>matrix</code>.</p>
<p>This example will be fully supported in future releases of Dymola.</p>
</html>"),
    experiment(__Dymola_NumberOfIntervals=2),
    __Dymola_experimentSetupOutput);
end TriangularMatrix;
