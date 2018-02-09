# CleanSky
Open Source software published by Clean Sky members

## What is Clean Sky ?

Clean Sky is the name of the largest aerospace research program in the seventh framework program of the European Union.
The program began in 2008 and still continues in 2018 under the Horizon 2020 EU research framework program. The goal of Clean Sky
was to support innovation that would enable a stabilization of aviation related CO2 emissions in the context of a fast growth of 
air traffic.

Because there are many ways to reach this goal, the scope of Clean Sky is very wide: it goes from fundamental technologies of airframes 
and aero engines, to artificial intelligence tools enabling smarter operations. Several projects addressed modeling of various aspects, 
and among those, Eco Design for Systems covered the modeling of energy flows and uses, with the ultimate goal of automating the 
drafting of requirement and the architectural design of integrated onboard energy subsystems.

## Why SafetyLib ?

2017 will be known in aerospace as the first ever year without a victim of a commercial airline accident. Only one airliner crashed, but
the flight was operated by the military. Such a good safety record does not come by accident. Airlines are safer than ever because they
follow strict safety processes, but also because the airplanes are very safe.

All commercial passenger transport airplanes used on regular airlines can continue to fly after the sudden failure of _any_ of their 
components. This is why they have two engines, dual wheel units and so on. It is not visible but each wing has multiple spars as well, so the
design is failure proof with respect to structural failures too. In addition, the probability of serious failures occuring in 
combination during the same flight is assessed, and monitored over time, so that it remains very small.

All these architectural features are heavily influenced by the rigorous safety assessment process, therefore a model of onboard systems 
was not complete without a model of their safety features, such as redondancies and independance. That's how SafetyLib came to be.

## What is SafetyLib ?

SafetyLib is a Modelica library which represents functional flows and functional losses. Modelica is a widely used, standard language 
created to describe dynamic systems. SafetyLib manipulates Boolean equations to model the functional status of components.

## How Does It Work ?

The current version of SafetyLib implements electrical and fluidic semantics, which are close cousins. When a particle of fluid is used in a circuit, it is stored, guided, pumped by physical
components.
The functional flow can be constructed as a graph of functions successively applied to an imaginary particle of fluid as it circulates 
in the system. If the flow reaches a point where is the divided in two branches, some particles of fluid will continue to the functions
fed by one branch, while others will continue to the functions of the other branch. Therefore, the graph of functions will also have
two branches, and will eventually look just like the real circuit.

As a Modelica library, SafetyLib implements a small number of functions:
* Split and Merge are used to describe fan-in and fan-out in a circuit;
* A link element, mostly interesting for its failure modes;
* A load elements which consumes power;
* A few variants of positive and negative potential sources, alone or in usual combinations;
* A cap element (obturator for a fluid circuit);
* A fault element.

Practical electrical circuits are regulated either in voltage or in current. For instance the 4-20 industrial signaling standard is
current regulated: as more receivers are added in series, the signal source must increase the voltage and therefore the power needed
to transmit information. In a model of this technology, the current loop would start at a positive potential source which means, when
it is active, that a correct value of current is emitted (either 4 mA for a zero, or 20 mA for a one). The current is carried by wires
represented as Link elements. Receivers shall also be represented by Link elements, and finally the emitter at the end of the current
loop should have a single load elements which allows it to detect if the loop carries current or is broken.

Most industrial systems however are regulated in the intensive parameter : pressure, voltage, etc. In such systems, the loads are 
connected in parallel, and short-circuit becomes an issue. A short-circuit is an unbounded demand of power, which cannot be satisfied
by the power source. As a consequence and until the short-circuit is located and isolated, the whole circuit is inoperative.

The Link element is used to model faults, which boil down to two families:
* Partial or total blockage which prevents operation of loads connected in series with the Link;
* Leakage (although electrons always return) of sufficient magnitude to prevent normal operation of the power sources.

In most case the Link element is configured to let the flow of power go through in the normal case, but it can also be configured as a 
valve, or even as an explicit leak, with a reasonably low probability of opening. This approach is interesting when the consequences
of a leak depend on its location, such as when carrying liquid fuels near open flames or hot surfaces.

As it is the SafetyLib library is complete, but very abstract. In more visual Modelica tools, like Dassault Systems Dymola, SafetyLib
gives detailed visual feedback of the status of each circuit. Loads light up when active and arrows depict power flows.

## Why Open Source ?

The base libary and its unit test companion library are published in Open Source to encourage the development of additional layers at a
lower level of abstraction. For instance the simple representation of a 4-20 signaling loop cannot represent an overcurrent situation.
This abnormal power flow would have to be represented by a second parallel flow, which would only be active when this failure mode
occurs. A detailed knowledge of the relevant failure modes for each technology is needed to properly apply the SafetyLib approach.

Because Modlica is also object-oriented, the safety description of a physical component can be easily added to a physical description of
the performance of that component. It is not even necessary to implement a physics of failure model: when the fault occurs, the physical
simulation of the component can go on unperturbated: the components connected to it will be informed of the effects of that failure
symbolically by the SafetyLib layer. This approach duplicates the "worst case reasoning" of safety engineers when they analyse the
potentiel consequences of a failure. Physics of failure approaches might conclude that the system limps on, and that may even be true, 
but will never be certain. The symbolic approach offered by SafetyLib will propagate the effect until a designed-in barrier stops it.

Because it only relies on Booleans, the intermediate representation known as "flat Modelica" of a SafetyLib-based model, is a list of
Boolean equations. It is allowed to add arbitrary logical equations in the model. The sets of equations are large and complex (tens of
thousands of equations are common) but can be further processed by novel algorithms.

## What Comes Next ?

Critical Optimisation will soon propose professional tools able to generate fault trees from SafetyLib-based models. Because SafetyLib 
models actually run, they can demonstrate visually the operation of fault propagation barriers, and dynamic system reconfigurations 
using all the power of Modelica. Generating the fault trees of reconfigurable systems is a very difficult task, which is out of reach
of an unassisted analyst.

Using our tools, safety analysts will be able to:
* check with their customer that they understand system operation, and complex reconfigurations;
* generate the fault trees for all the hazardous events automatically and in minimal time;
* quickly update the safety analysis when the system design changes;
* perform an exact analysis of dispatch with faults, MMEL, effects of hidden faults and similar related problems.

For complex, reconfigurable systems, it should be known that the fault tree can be entirely different after the occurrence of a fault.
Current methods which derive fault trees for post-fault situations using the fault tree before the fault are crude approximation, only
valid for systems of the past, with low levels of integration.

## Enablers

In the long run SafetyLib will enable a pivotal change in the way safety analyses are performed. Seen today as a mandatory burden, the
requirement for expensive and long formal safety analyses, more or less eliminates the possibility of simplifying architectures when 
progress in reliability of parts or alternate concepts make it possible. 

The prohibitively expensive cost of those analyses close the market of differential analysis, which would compare technical solutions
on safety grounds. Moreover, the labor intensive manual process does not guarante that two architectures will be assessed homogeneously
by experts trained to demonstrate that a target figure of merit is achieved.

Drastically reducing the cost of analysing the safety of architecture variants, will allow designers to integrate safety, and therefore 
architecture in the design optimisation loop. Current generation tools can at best assist engineers seeking to optimize sizing of 
components. Future tools will be able to compare different architectural variants on equal terms.

Given the high level of automation of our tools, they will integrate seemlessly in the semi-automated design flows of the future, which rely on AI to orient the designers quickly toward the most suitable solutions.



