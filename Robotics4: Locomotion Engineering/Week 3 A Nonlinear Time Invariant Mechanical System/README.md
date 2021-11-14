# Controlling a Pendulum

In this lab, you will be building a pendulum simulation, and then developing a handful of simple controllers. Pendulums have been used in clocks since 1656 when Dutch scientist Christiaan Huygens first included one in his design. This greatly improved the accuracy of the clock, and was quickly adopted for use in clocks all over Europe. The pendulum is an excellent time-keeping tool for a variety of reasons, the first of which is its easy-to-design period.

## Numerical Simulation of s Simple Pendulum
Having some analytical insight for how a pendulum is supposed to behave, we encode the **natural** dynamics into a simulation, as done with the harmonic oscullator, assuming that there is not damping.

## Forcing Pendulum to Desired Frequency
Suppose we want to build a really good clock - with a linear approximation of the dynamics, we introduce a very small error, imperceptible on any given swing, but if the clock runs for days or months, the measure time will start to drift from that of th analytical prediction. Let's introduce a torque at the base of the pendulum and design it such we force the frequency to be *exactly* that predicted by the small angle approximation. Also, let's assume that the air provides a viscous damping that needs to be compensated for so the pendulum will continue to swing up to the initial condition. The way to do this is to simply to find the natural equations of motion for the pendulum, and then cancel them - provide a torque that is equal and opposite to them. The we can apply a torque that forces the system to behave just like the *linear approximation* made. This takes very little torque, since the natural dynamics and desired dynamics are very similar.

## Variable Amplitud Control
For the last part of this lab, we will focus on the concept of energy. In the last segment, the controller keeps the total system energy (kinetic + potential) constant, by compensating for the viscous damping. However, there are many times in robotics that we'd like to control the total system energy to a desired level.<br />
To do this we use a similar controller from the previous section, but this time we add an "energy pumping" term , that either puts energy in, or takes energy out until the total system energy is as desired.<br />
Let the desired system energy be such that the pendulum is swinging between $+/- \theta = 1\ radian$.<br />
We don't want to compensate for the damping term anymore, as we need it to stabilize the system now that we are adding energy.<br />
Adding energy can be done in a variety of ways, but we recommend using a proportional term, that is some gain $k_p$ times the difference in the system energy $(E_{desired} - E_{actual})$. Furthermore, to make sure that we are applying a torque in the right direction, namely when $\dot{\theta} > 0$, the energy pumping term is positive, and negative in the opposite case. A great continuous function for doing this is $arctan(x)$.
