within EU_CleanSky.EDS.SafetyLib;
package Sources "Positive and negative potential sources, and their combinations."
  extends Modelica.Icons.SourcesPackage;


annotation (Documentation(info="<html>
<p>The connectors gender defines an acyclic oriented graph going from source elements having only male (usually one) connectors to sink elements having only (usually one) female connector. </p>
<p>This standard sub-package contains all the user level elements having only one type of connector (either male or female). In the present implementation, the connector gender can usually be selected using a parameter.</p>
<p>In addition this sub-package contains components which deliver both high and low potential, and therefore are power sources. These components are shaped like batteries, with a male and a female connection port on the top side. A parameter can be used to reverse the positions of the + and - ports, in order to have the opposite genders.</p>
</html>"));
end Sources;
