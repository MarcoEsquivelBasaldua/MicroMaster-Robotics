# The Spring Loaded Inverted Pendulum (SLIP) - Sweet Landing

In project 2, we described an one-dimensional hopper, similar to what you discussed in lecture, with a virtual spring. In many cases, legged robots are dropped from a (not always insignificant) height and must come to rest as fast and as smoothly as possible, to avoid damage on their electromechanical components. The goal of this lab is to design a control policy that achieves that.<br />
Assume that the equation of motion for the stance phase is (as in Project 2) $m\ddot{y} +b\dot{y} + k(y-r) = u - mg$<br />
In script *RunHopperSimulation.m*, a robot is dropped from a height of 1m using a control $u$
