# Introduction to Linear Control

## Feedback and feed-forward Control
1[img](pid.png)<br />
Figure 1: the block diagram of a PID feedback control system for a robotic manipulator joint<br /><br />

The script in *pid.m* designs a PID controller for the system in Figure 1, that has a disturbance od $D=\fracc{50}{s}$ and $J=10$, driving the system to a setpoint $\theta_d\in [50,200]^o$ with a setting time less than 5 seconds, negligible overshoot $(\%OS<1\%)$, and no steady-state error.
