within EU_CleanSky.EDS.Utilities.OptimisedSplit;
package UsersGuide "User's Guide"
  import Modelica;


  extends Modelica.Icons.Info;


  annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p><a name=\"details_readonly\">T</a>he Wing Ice Protection System has to be split in several Subsystems each protecting a different area, not for redundancy, but simply because the whole system requires more power than is available on any single electrical network. </p>
<p>This is a particular situtation and when the function must survive a first electrical failure (loss of one engine or alternator), the optimisation of the number of subsystems and their sizes is more difficult. </p>
<p>Laws particular to each system: the system may have one or several degraded modes of operation, in which its critical power requirements are reduced to lessen the requirements on the surviving power sources. The critical power requirements are usually the maximum power requirements, but there is also the question of the amount of power that can be extracted from the engines, which could be lower in some situations (idling, acceleration phases, etc.). </p>
<p>The model has normal external sizing variables (the amount of power it needs to do its job globally, dependent upon aiframe size), and internal sizing variables controlling how this power is distributed among subsystems. These variables are called the free sizing variables. </p>
<p>The model has to run (compute how much power it draws from each supply) but only has a global ice protection power budget to start from, in the given simulated flight conditions. The physical model has to run when the free sizing variables are unknown. </p>
<p>It is here assumed that to find optimised values of the free sizing variables, the sizing loop will be modified to integrate a conjugate gradient algorithm. The target design situation involves an reconfiguration of the interconnections of electrical bus bars in failed power source situations. </p>
<p>The model involves an overdetermined connector since we have multiple wires capable of carrying the power, and we do not really know or care which wire actually carries it in a group of wires connecter to the same bus bar. Non connected electrical networks. The physical meaning of all the possible current distributions in the multiples wire mounted in parallel is exactly the same at this stage, as long as the sum is the same. </p>
<p>The system of equations will naturally be underdetermined, since the repartition equations will be missing. The implementation idea is to provide additional i=0 equations, which will be used by the solver to complete the equation sets. If there are n wires in parallel, the solver will add n-1 equations to balance the set of equations. For architecture level models, the voltage will always be the same, and for functional level models, the free sizing variables will be defined, leading to a known power distribution. </p>
<p>overConstrained connectors do not work for flow variables. We have to make a conversion component which will be used to convert between flow representation of current, and an articial potential representation of current which is used internally which great care in a string of serially connected components.</p>
</html>"));
end UsersGuide;
