# Big Picture Motivation

## Matlab and Numerical ODE Solvers
In this problem we take a simple first order differential equation expressing population growth.
$$
	\fracc{dP}{dt} = rP \left(1 - \fracc{P}{k} \right)
$$

This ODE is solved using ODE23. First off we pass to ODE23 a value called '@populationGrowth' (in matlab '@' denotes a function "handle" or the name of a function). The function *populationGrowth()*, which normally is called by passing it a value P (and implicit time t) and it returns a value Pdot. In this case, we are telling ODE23 that *populationGrowyh()* is the fuction it will use to numerical solve the differential equation, and thus we pass it as a value.<br />

Secondly, the vector 'tspan' is the time span condition after which the numerical solver will stop. Here, we have it running until time t greater than or equal to 1 second.<br />

Next, P0 is the initial conditions from which the numerical solver will start. In this case, we've made P=10.<br />

After running the script, a set of values is printed. T(1) is the first value of time t, which should be 0. T(end) is the final value of t, which should be very close to 1 as specified in tspan. Furthermore P(1) and P(end) are the initial and final values of the vertical position.
