Fault Diagnosis Graph for Time Petri Nets
==========

This is the second version of the implementation.
A major change is that the DBM is dropped by using directly the inequalities.
An important feature of DBM is that in DBM, there exists NA values, if the corresponding transitions are not enabled.
This feature leads to a problem that a DBM cannot be stored in a Map.container.
It means hash tables cannot be used and complicates the computation when searching for a state class.
In order to eliminate variables, DBMs have to be transformed into inequalities represented by matrices.

Hence, in this version, I do not follow the suggestion in the paper "Efficient reachability analysis for time Petri nets" of using DBMs.
The other details are the same as the first version.
In some simulations, the computation time is improved for about 50% comparing with the first version.

