within EU_CleanSky.EDS.Utilities.Context;
record Base "Netlist-local context shared among a number of components."
  //Data context;

  function equalityConstraint
    input Base c1;
    input Base c2;
    output Real residue[0]
      "No constraints. Unneeded connect equations will be suppressed.";
  algorithm

    annotation (Documentation(info="<html>
<p>This function is standardised by the Modelica specification. The presence of a function named &QUOT;equalityConstraint&QUOT; make the record and overconstrained record. The Modelica compiler will perform the connection graph analysis and transformation described in the specification.</p>
</html>"));
  end equalityConstraint;
  annotation (Documentation(info="<html>
<p>User defined records must be derived from this record, adding the required fields. All types are allowed.</p>
<p>From a Modelica point of view, this record (and all derived records) are &QUOT;overdetermined records&QUOT; since they contain an &QUOT;equalityConstraint&QUOT; function. When such records are used in a connector, the Modelica tool will remove superfluous equations which appear when the model topology has cycles.</p>
</html>"));
end Base;
