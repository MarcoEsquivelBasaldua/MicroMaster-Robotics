# State Space Modelling and Multivariable Systems

![img](arm.png)<br />
Figure 1: a two link planar manipulator<br />

The following set of differential equations captures the dynamics of the planar elbow manipulator shown above in Figure 1.<br />
![eq1](eq1.png)<br />
 In the script *state_space_arm.m* the system is converted into a state-space representation by intodicing the state variables:<br />
 ![eq2](eq2.png)<br />
 And finding a matrix, $f(x, \tau)$ such that:<br />
 ![eq3](eq3.png)
