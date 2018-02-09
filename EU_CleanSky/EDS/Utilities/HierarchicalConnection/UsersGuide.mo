within EU_CleanSky.EDS.Utilities.HierarchicalConnection;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Info;
  annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>Hierarchical Connection offers a framework capable of transporting a physical connector everywhere in a model hierarchy. This is achieved using inner/outer connections to hidden connectors at a higher level, up to a level known as<a href=\"Modelica://EU_CleanSky.EDS.Utilities.HierarchicalConnection.System\"> System</a> level.</p>
<p>A given model may have more than one hierarchical connector, as long as they exist in distinct submodels, each of them being a System according to this library. The distinct hierarchies can rest side by side, or can be nested. When nested, they must be such that the System of one hierarchy is in a leaf submodel in another hierarchy. In this fashion, the definition of the hierarchical connector can be adapted to each level of definition of the model. It is not necessary to carry the same connector at airframe level and inside a component for instance.</p>
<p>In practical applications, the hierarchical connector will be an expandable connector or an application specific connector. Applications may provide application-specific libraries which make parts of the hierarchical connector graphically accessible.</p>
<p>The <a href=\"Modelica://EU_CleanSky.EDS.Utilities.HierarchicalConnection.Example.ElectricalNetwork\">Example</a> included show how various resistive loads can be transparently attached to a single electrical network, just by dragging them into the model. </p>
</html>"));
end UsersGuide;
