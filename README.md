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
created to describe dynamic systems. Old versions of Modelica supported a description based on a system of implicit differential equations.
Recent versions also support state based descriptions similar in principle to SystemC, including algorithms. Such descriptions can
be used with discrete variables, for instance Boolean values, whereas differential equations operate on time dependant real valued,
derivable quantities.

In a modern Modelica model, time is a sequence of time periods separated by discontinuities. The differential equations are solved within
the time periods to calculate time-dependent values of real valued variables, and at time discontinuities the state logic and other
discrete variables can change their value. SafetyLib manipulates Boolean equations to model the functional status of componnts.

## How does it work ?

The current version of SafetyLib implements electrical and fluidic semantics, which are close cousins. Switching from one to the other
is a matter of setting one parameter. When a particle of fluid is used in a circuit, it is stored, guided, pumped by physical components.
The functional flow can be constructed as a graph of functions successively applied to an imaginary particle of fluid as it circulates 
in the system. If the flow reaches a point where is the divided in two branches, some particles of fluid will continue to the functions
fed by one branch, while others will continue to the functions of the other branch. Therefore, the graph of functions will also have
two branches, and will eventually look just like the real circuit.

As a Modelica library, SafetyLib implements a small number of functions:
* Split and Merge are used to describe fan-in and fan-out in a circuit;
* A link element, mostly interesting for its failure modes;
* A load elements which consumes power;
* A few variants of positive and negative potential sources.

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

As it is the SafetyLib library is complete, but very abstract.

## Why Open Source ?




