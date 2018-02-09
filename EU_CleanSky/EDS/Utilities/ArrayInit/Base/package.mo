within EU_CleanSky.EDS.Utilities.ArrayInit;
package Base "Easily initialise parameters of array components. Base components."


replaceable record Params "Replaceable partial record."
  annotation (Documentation(info="<html>
<p>In order to use this library, this empty record must be redefined in a derived package and customised for your application. In this fashion, all the functions in the package are also derived to produce your customised parameters.</p>
</html>"));
end Params;

// Checks OK, but complains from algebraic loops in equation table = InitFcn(table, ctor)
// during translation.
//   final function InitFcn
//     "Constructor of an array using a specific function."
//     input Params[:] t "array to fill, used to get size only";
//     input PInitType ctor;
//     output Params[size(t, 1)] a;
//   algorithm
//     //long form is : a := array(Init(i, Source.'constructor'.fromReal(0.0)) for i in 1:n);
//     a := InitFcnN(size(t, 1), ctor);
//   end InitFcn;


annotation (preferredView="info");
end Base;
