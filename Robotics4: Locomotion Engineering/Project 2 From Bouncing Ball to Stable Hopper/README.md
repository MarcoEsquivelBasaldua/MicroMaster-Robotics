# From Bouncing Ball to Stable Hopper

## Part 1 Build a Bouncing Ball Simulation

### Simplified Mechanics of a Bouncing Ball
Let us start with a very simple bouncing ball problem. We want to simulate the bouncing motion of an elastic ball when it falls freely from a given height. We know that the ball has ballistic dynamics in its flight phase; the compression and release phases on the ground behaves like a mass-spring-damper system. Typically, this is not an easy problem, and by this we mean we cannot solve it analytically and there is no closed form solution.<br />
![img1](fig1.png)<br />

We release an elastic ball with radious $\chi_0 = 0.005$ (m) and as mass $m = 1$ (kg) from a height $h = 1$ (m), and the total energy of the ball at this initial point is $E$. If we don't have a damper in our system, we won't see any decrements in energy and the ball will bounce forever. Here, we will make the naive assumption that the ground consumes a certain portion of energy every time the ball hits it, returning only a portion (elastic efficiency $\gamma = 0.8$) of the previous energy $E_1$, that is $E_2 = \gamma E_1$, where $E_2$ is the new system energy after the collision. We also assume the collision happens in an instance and doesn't take any time at all, thus the deformation during that time is neglected.

In the Part1 folder we use ODE45 to solve the equation of motion numerically and plot the solution with respect to time. For simplicity of symbolic typing, we use Q, q, dq to represent $x$, $\chi$ $\dot{\chi}$.
