within EU_CleanSky.EDS.Utilities;
block PrintOnce "Print a message once if a condition occurs"
  extends .Modelica.Blocks.Icons.BooleanBlock;
  import Modelica.Utilities.Strings.substring;
  .Modelica.Blocks.Interfaces.BooleanInput u=print if useInput annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent=
           {{-120,-20},{-80,20}})));
  input Boolean print;
  parameter Boolean useInput=true
    "\"if false, hide boolean input connector. Use input Boolean print instead.\"";
  parameter String msg="Default message. Configure "+blockName+"!";
  parameter Boolean warn=false;
  parameter Boolean name=true;
  parameter Integer uplevel(min=0)=0;

  final parameter String blockName = getInstanceName();
  final parameter String instance = if name then substring(blockName,1,findLastN(blockName,".",n=uplevel+1)-1) else "";
  final parameter String warnStr=if warn then "Warning: " else "";
  encapsulated function findLastN
    "Find last occurrence of a string within another string"
    extends .Modelica.Icons.Function;
    import Modelica.Utilities.Strings.*;
    input String string "String that is analyzed";
    input String searchString "String that is searched for in string";
    input Integer n(min=1)=1 "Look for nth occurrence";
    input Integer startIndex(min=0) = 0
      "Start search at index startIndex. If startIndex = 0, start at length(string)";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored for the search";
    output Integer index
      "Index of the beginning of the last occurrence of 'searchString' within 'string', or zero if not present";
  protected
    Integer lenString=length(string);
    Integer lenSearchString=length(searchString);
    Integer iMax=lenString - lenSearchString + 1;
    Integer i;
    Integer j;
  algorithm
    i := if startIndex == 0 or startIndex > iMax then iMax else startIndex;
    j := n;
    index := 0;
    while i >= 1 loop
      if isEqual(
            substring(
              string,
              i,
              i + lenSearchString - 1),
            searchString,
            caseSensitive) then
        j := j - 1;
        if j == 0 then
          index := i;
          i := 0;
        end if;
      end if;
      i := i - 1;
    end while;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
index = Strings.<b>findLast</b>(string, searchString);
index = Strings.<b>findLast</b>(string, searchString,
                         startIndex=length(string), caseSensitive=true,
</pre></blockquote>
<h4>Description</h4>
<p>
Finds first occurrence of \"searchString\" within \"string\"
when searching from the last character of \"string\"
backwards, and return the corresponding index.
Start search at index \"startIndex\" (default = 0;
if startIndex = 0, search starts at length(string)).
If the optional argument \"caseSensitive\" is false, lower
and upper case are ignored for the search.
If \"searchString\" is not found, a value of \"0\" is returned.
</p>
</html>"));
  end findLastN;
protected
  Boolean done(start=false,fixed=true);
initial equation
  if print then
    Modelica.Utilities.Streams.print(warnStr+instance+" "+msg);
  end if;
equation
  when print and not pre(done) then
    Modelica.Utilities.Streams.print(warnStr+instance+" "+msg);
    done =  true;
  end when;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-96,98},{80,40}},
          lineColor={0,0,255},
          fontName="Courier New",
          textString="console $ _")}));
end PrintOnce;
