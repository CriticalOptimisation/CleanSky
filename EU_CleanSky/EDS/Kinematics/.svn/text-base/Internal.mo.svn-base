within EU_CleanSky.EDS.Kinematics;
package Internal
  extends Modelica.Icons.InternalPackage;
  block MakePosition "Creates a Position record from Real inputs"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    Modelica.Blocks.Interfaces.RealInput radius
      "Distance to the center of the Earth" annotation (Placement(transformation(
            extent={{-120,40},{-80,80}}), iconTransformation(extent={{-120,40},{-80,
              80}})));
    Modelica.Blocks.Interfaces.RealInput lon "Longitude" annotation (Placement(
          transformation(extent={{-120,-80},{-80,-40}}),
                                                       iconTransformation(extent={{-120,-80},{-80,-40}})));
    Interfaces.PositionOutput position
      annotation (Placement(transformation(extent={{92,-10},{112,10}}), iconTransformation(extent={{82,-20},{120,18}})));

  protected
    outer TheEarth world;
  equation
    position.longitude = lon;
    position.latitude = 0;
    position.geodeticLatitude = 0;
    position.radius = radius;
    position.geodeticAltitude = radius-world.a; // Height above WGS-84 ellipsoid representing the mean sea level.

     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                           graphics), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(info="<html>
<p>This component is used in the Location model to calculate latitude, longitude and altitude for an object moving near the earth or on the surface.</p>
<p>CAUTION: the current implementation only works for motion at zero latitude (at or above the equator). This restriction matches similar restrictions in Location and in the definitions of the gravitational field in TheEarth. The long distance gravitational field of the Earth can be approximated as the field of a point mass with spherical symmetry, but this is not true of the gravitational field near the surface, where aircraft are. Near the surface the gravitational field is affected by the elliptical shape (it is stronger at the poles, but not as strong as it would due to the shorter distance to the centre of the Earth in the spherical field model).</p>
<p>Calculate the geodetic latitude base on AIAA Journal of Guidance and Control paper, </p>
<p>&QUOT;Improved Method for Calculating Exact Geodetic Latitude and Altitude&QUOT;, and </p>
<p>&QUOT;Improved Method for Calculating Exact Geodetic Latitude and Altitude, Revisited&QUOT;, </p>
<p>author: I. Sofair </p>
<p><br>A good implementation is available in JSBSim::FGLocation.cpp:391, but since this implementation is restricted to flights with latitude = 0, the calculation is a lot simpler.</p>
</html>"));
  end MakePosition;

  model FixedArrowAxis
    "The arrow head color can be independently controlled (statically) by a parameter."
    extends Modelica.Mechanics.MultiBody.Visualizers.FixedArrow(arrowHead(color=headColor));
    parameter Modelica.Mechanics.MultiBody.Types.Color headColor={0,0,0};
  end FixedArrowAxis;

      partial model PartialLumpedFlow
    "Base class for a lumped 3D momentum balance"

        outer Modelica.Fluid.System system "System properties";

        replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component";

        parameter Boolean allowFlowReversal = system.allowFlowReversal
      "= true to allow flow reversal, false restricts to design direction (m_flow >= 0)"
          annotation(Dialog(tab="Assumptions"), Evaluate=true);

        // Inputs provided to the flow model
        input Modelica.SIunits.Length pathLength "Length flow path";

        // Variables defined by the flow model
        Medium.MassFlowRate m_flow(
           min=if allowFlowReversal then -Modelica.Constants.inf else 0,
           start = m_flow_start,
           stateSelect = if momentumDynamics ==Modelica.Fluid.Types.Dynamics.SteadyState
                                                                           then StateSelect.default else
                                     StateSelect.prefer)
      "mass flow rates between states";

        // Parameters
        parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
      "Formulation of momentum balance"
          annotation(Dialog(tab="Assumptions", group="Dynamics"), Evaluate=true);

        parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
      "Start value of mass flow rates"
          annotation(Dialog(tab="Initialization"));

        // Total quantities
        Modelica.SIunits.Momentum I[3] "Momenta of flow segments";

        // Source terms and forces to be defined by an extending model (zero if not used)
        Modelica.SIunits.Force Ib_flow[3] "Flow of momentum across boundaries";
        Modelica.SIunits.Force F_p[3] "Pressure force";
        Modelica.SIunits.Force F_fg[3]= {0,0,0} "Friction and gravity force"; // neglected

        Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation (Placement(
              transformation(extent={{-16,-114},{16,-82}}), iconTransformation(
              extent={{-16,-16},{16,16}},
              rotation=90,
              origin={0,-100})));
      equation
        // Total quantities
        I = m_flow*pathLength; // devrait être une intégrale le long du path, en 3D

        // Momentum balances
        if momentumDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          0 = Ib_flow - F_p - F_fg;
        else
          der(I) = Ib_flow - F_p - F_fg;
        end if;

      initial equation
        if momentumDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
          m_flow = m_flow_start;
        elseif momentumDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
          der(m_flow) = 0;
        end if;

        annotation (
           Documentation(info="<html>
<p>
Interface and base class for a momentum balance, defining the mass flow rate <code><b>m_flow</b></code>
of a given <code>Medium</code> in a flow model.
</p>
<p>
The following boundary flow and force terms are part of the momentum balance and must be specified in an extending model (to zero if not considered):
</p>
<ul>
<li><code><b>Ib_flow</b></code>, the flow of momentum across model boundaries,</li>
<li><code><b>F_p[m]</b></code>, pressure force, and</li>
<li><code><b>F_fg[m]</b></code>, friction and gravity forces.</li>
</ul>
<p>
The length of the flow path <code><b>pathLength</b></code> is an input that needs to be set in an extending class to complete the model.
</p>
</html>"));
      end PartialLumpedFlow;

  function resolveRelative_der
    "Derivative of function Frames.resolveRelative(..)"
    import Modelica.Mechanics.MultiBody.Frames;
    extends Modelica.Icons.Function;
    input Real v1[3] "Vector in frame 1";
    input Frames.Orientation R1
      "Orientation object to rotate frame 0 into frame 1";
    input Frames.Orientation R2
      "Orientation object to rotate frame 0 into frame 2";
    input Real v1_der[3] "= der(v1)";
    output Real v2_der[3] "Derivative of vector v resolved in frame 2";
  algorithm
    v2_der := Frames.resolveRelative(v1_der+cross(R1.w,v1), R1, R2)
              - cross(R2.w, Frames.resolveRelative(v1, R1, R2));

    /* skew(w) = T*der(T'), -skew(w) = der(T)*T'

     v2 = T2*(T1'*v1)
     der(v2) = der(T2)*T1'*v1 + T2*der(T1')*v1 + T2*T1'*der(v1)
             = der(T2)*T2'*T2*T1'*v1 + T2*T1'*T1*der(T1')*v1 + T2*T1'*der(v1)
             = -w2 x (T2*T1'*v1) + T2*T1'*(w1 x v1) + T2*T1'*der(v1)
             = T2*T1'*(der(v1) + w1 x v1) - w2 x (T2*T1'*v1)
  */
    annotation(Inline=true, Documentation(info="<html>
<p>This function was copied here from the MSL, because the original function Modelica.Mechanics.MultiBody.Frames.Internal.resolveRelative_der() is tagged &QUOT;Internal&QUOT;, and is therefore not part of the official API. The function is used to perform speed calculations in the North East Down frame supplied by the Location object. The local wind is a vector given in the same NED frame by TheEarth.</p>
</html>"));
  end resolveRelative_der;

  block DecodePosition "Limited implementation of position decode"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    Interfaces.PositionInput positionInput annotation (Placement(transformation(
            extent={{-108,-10},{-88,10}}), iconTransformation(extent={{-118,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealOutput lon "Longitude" annotation (Placement(
          transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{80,40},{120,80}})));
    Modelica.Blocks.Interfaces.RealOutput lat "Latitude" annotation (Placement(
          transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{80,-20},{120,20}})));
    Modelica.Blocks.Interfaces.RealOutput radius
      "Distance to the centre of the Earth" annotation (Placement(transformation(
            extent={{80,-80},{100,-60}}), iconTransformation(extent={{80,-80},{120,-40}})));
  equation
    lon = positionInput.longitude;
    lat = positionInput.latitude;
    radius = positionInput.radius;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                           graphics={
          Text(
            extent={{-4,80},{70,38}},
            lineColor={0,0,127},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="LON"),
          Text(
            extent={{-10,20},{64,-22}},
            lineColor={0,0,127},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="LAT"),
          Text(
            extent={{-4,-40},{70,-82}},
            lineColor={0,0,127},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="RAD")}));
  end DecodePosition;

  block CombiTable1Ds
    "Table look-up in one dimension (matrix/file) with one input and n outputs"
    extends Modelica.Blocks.Interfaces.SIMO(final nout=size(columns, 1));
    parameter Boolean tableOnFile=false
      "= true, if table is defined on file or in function usertab"
      annotation (Dialog(group="Table data definition"));
    parameter Real table[:, :] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0,2])"
      annotation (Dialog(group="Table data definition",enable=not tableOnFile));
    parameter String tableName="NoName"
      "Table name on file or in function usertab (see docu)"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter String fileName="NoName" "File where matrix is stored"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile,
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
            caption="Open file in which table is present")));
    parameter Boolean verboseRead=true
      "= true, if info message that file is loading is to be printed"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter Integer columns[:]=2:size(table, 2)
      "Columns of table to be interpolated"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation"
      annotation (Dialog(group="Table data interpretation"));
  protected
    Modelica.Blocks.Types.ExternalCombiTable1D tableID=
        Modelica.Blocks.Types.ExternalCombiTable1D(
          if tableOnFile then tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          columns,
          smoothness) "External table object";
    parameter Real tableOnFileRead(fixed=false)
      "= 1, if table was successfully read from file";

    function readTableData "Read table data from ASCII text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external"C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead)
        annotation (Library={"ModelicaStandardTables"});
    end readTableData;

    function getTableValue "Interpolate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      input Real tableAvailable
        "Dummy input to ensure correct sorting of function calls";
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (Library={"ModelicaStandardTables"});
      annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
    end getTableValue;

    function getTableValueNoDer
      "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      input Real tableAvailable
        "Dummy input to ensure correct sorting of function calls";
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (Library={"ModelicaStandardTables"});
    end getTableValueNoDer;

    function getDerTableValue
      "Derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      input Real tableAvailable
        "Dummy input to ensure correct sorting of function calls";
      input Real der_u;
      output Real der_y;
      external"C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
        annotation (Library={"ModelicaStandardTables"});
    end getDerTableValue;

  initial algorithm
    if tableOnFile then
      tableOnFileRead := readTableData(tableID, false, verboseRead);
    else
      tableOnFileRead := 1.;
    end if;
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;
    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = getTableValueNoDer(tableID, i, u, tableOnFileRead);
      end for;
    else
      for i in 1:nout loop
        y[i] = getTableValue(tableID, i, u, tableOnFileRead);
      end for;
    end if;
    annotation (
      Documentation(info="<html>
<p>This is exactly the same class as Modelica.Blocks.Tables.CombiTable1Ds, with higher order derivatives defined.The smooth interpolation works with precalculated Akima splines. </p>
<p>Akima, Hiroshi. A new method of interpolation and smooth curve fitting based on local procedures. </p>
<p>J. ACM 17, 4 (Oct. 1970), 589-602. (http://dl.acm.org/citation.cfm?id=321609)</p>
<p>It is a polynomial interpolation of order 3. The formulation could be derived several times, but the C library only offers the first derivative. </p>
<p>The key issue with this implementation is the hiding of discontinuities to the Modelica solver (the functions behave like a smooth() operator).</p>
<p>This class offers extra derivatives for the LinearSegments smoothness type. Those 2nd order and higher derivatives are always zero, but they are implemented in such a way as to create integration discontinuities in the solver every time the first order derivative (the slope) changes.</p>
<p><b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>. Via parameter <b>columns</b> it can be defined how many columns of the table are interpolated. If, e.g., icol={2,4}, it is assumed that one input and 2 output signals are present and that the first output interpolates via column 2 and the second output interpolates via column 4 of the table matrix. </p>
<p>The grid points and function values are stored in a matrix &QUOT;table[i,j]&QUOT;, where the first column &QUOT;table[:,1]&QUOT; contains the grid points and the other columns contain the data to be interpolated. Example: </p>
<pre>   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).</pre>
<ul>
<li>The interpolation is <b>efficient</b>, because a search for a new interpolation starts at the interval used in the last call.</li>
<li>If the table has only <b>one row</b>, the table value is returned, independent of the value of the input signal.</li>
<li>If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e., u &GT; table[size(table,1),1] or u &LT; table[1,1], the corresponding value is also determined by linear interpolation through the last or first two points of the table.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>The table matrix can be defined in the following ways: </p>
<ol>
<li>Explicitly supplied as <b>parameter matrix</b> &QUOT;table&QUOT;, and the other parameters have the following values: </li>
<pre>   tableName is &QUOT;NoName&QUOT; or has only blanks,
   fileName  is &QUOT;NoName&QUOT; or has only blanks.</pre>
<li><b>Read</b> from a <b>file</b> &QUOT;fileName&QUOT; where the matrix is stored as &QUOT;tableName&QUOT;. Both ASCII and MAT-file format is possible. (The ASCII format is described below). The MAT-file format comes in four different versions: v4, v6, v7 and v7.3. The library supports at least v4, v6 and v7 whereas v7.3 is optional. It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg; by command </li>
<pre>   save tables.mat tab1 tab2 tab3</pre>
<p>or Scilab by command </p>
<pre>   savematfile tables.mat tab1 tab2 tab3</pre>
<p>when the three tables tab1, tab2, tab3 should be used from the model.</p>
<p>Note, a fileName can be defined as URI by using the helper function <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</p>
<li>Statically stored in function &QUOT;usertab&QUOT; in file &QUOT;usertab.c&QUOT;. The matrix is identified by &QUOT;tableName&QUOT;. Parameter fileName = &QUOT;NoName&QUOT; or has only blanks. Row-wise storage is always to be preferred as otherwise the table is reallocated and transposed. See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package documentation for more details.</li>
</ol>
<p>When the constant &QUOT;NO_FILE_SYSTEM&QUOT; is defined, all file I/O related parts of the source code are removed by the C-preprocessor, such that no access to files takes place. </p>
<p>If tables are read from an ASCII-file, the file needs to have the following structure (&QUOT;-----&QUOT; is not part of the file content): </p>
<pre>-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------</pre>
<p>Note, that the first two characters in the file need to be &QUOT;#1&QUOT; (a line comment defining the version number of the file format). Afterwards, the corresponding matrix has to be declared with type (= &QUOT;double&QUOT; or &QUOT;float&QUOT;), name and actual dimensions. Finally, in successive rows of the file, the elements of the matrix have to be given. The elements have to be provided as a sequence of numbers in row-wise order (therefore a matrix row can span several lines in the file and need not start at the beginning of a line). Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4). Number separators are spaces, tab ( ), comma (,), or semicolon (;). Several matrices may be defined one after another. Line comments start with the hash symbol (#) and can appear everywhere. Other characters, like trailing non comments, are not allowed in the file. </p>
<p>MATLAB is a registered trademark of The MathWorks, Inc. </p>
</html>"),
      Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}},
        initialScale=0.1),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,20.0},{-30.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,0.0},{-30.0,20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-20.0},{-30.0,0.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-40.0},{-30.0,-20.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,0},{-58,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,64}},
            textString="1 dimensional linear table interpolation",
            lineColor={0,0,255}),
          Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                0,0,0}),
          Line(points={{0,40},{0,-40}}, color={0,0,0}),
          Rectangle(
            extent={{-54,40},{-28,20}},
            lineColor={0,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,20},{-28,0}},
            lineColor={0,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,0},{-28,-20}},
            lineColor={0,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,-20},{-28,-40}},
            lineColor={0,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-52,56},{-34,44}},
            textString="u",
            lineColor={0,0,255}),
          Text(
            extent={{-22,54},{2,42}},
            textString="y[1]",
            lineColor={0,0,255}),
          Text(
            extent={{4,54},{28,42}},
            textString="y[2]",
            lineColor={0,0,255}),
          Text(
            extent={{0,-40},{32,-54}},
            textString="columns",
            lineColor={0,0,255})}));
  end CombiTable1Ds;

  function earthGravityAcceleration "CleanSky equatorial gravity model."
    extends Modelica.Icons.Function;
    extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
    input Modelica.SIunits.Position earth[3]
      "Position of the centre of the Earth in world frame.";
  protected
    Real mue(unit="m3/s2") = 3.9925e14 "Field constant of point gravity field"
                                              annotation(Dialog);
      Modelica.SIunits.Distance dr[3] = r-earth;
  algorithm
  gravity := -(mue/(dr*dr))*(dr/Modelica.Math.Vectors.length(dr));
    annotation(Inline=true, Documentation(info="<html>
<p>This function implements a point gravity model with spherical mass. Since the Earth is not spherical, this model is an approximation. The gravitational constant value has been tuned to give the best approximation for trajectories which stay close to the equatorial line. The accuracy of the magnitude will be lower for higher orbits and the magnitude and orientation are very approximate for trajectories leaving equatorial latitudes.</p>
<p>Do not forget that the Earth is rotating. The usual &QUOT;flat world&QUOT; average &QUOT;g&QUOT; constant includes the centrifuge effect of Earth rotation as well as gravity. An object stationary in Earth Centred Inertial frame of reference is actually moving westwards at Mach 1.4 in order to follow the Sun.  </p>
</html>"));
  end earthGravityAcceleration;
end Internal;
