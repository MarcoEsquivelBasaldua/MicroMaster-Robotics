# Natural Control of a RR Chain

To demonstrate the utility of lyapunov theory in control applications, this lab (created by Dr. Avik De) will focus on controlling a robotic arm with two revolute degrees of freedom, often referred to as a revolute-revolute or RR chain. Our goal will be to have the arm trace different shapes with its end effector; think of it as a shape drawing robot, and we need to program a controller such that it draws the correct shape while not getting stuck, and able to recover after getting bumped. A naive method of control would be to come up with time based trajectories for each of the joints, and in a perfect world, the end-effector would follow the precise path you calculated. However, the world is full of unmodeled uncertainties, whether they are friction in the joints of the robot, or an unexpected bump from a passer-by.<br />

Convince yourself that if the joints are merely following trajectories, these bumps and frictions could completely throw the end-effector off the desired path. Instead, we will focus on a natural controller, one that describes the desired position of the end-effector as a function of time, and then instead makes a basin around that point.<br />

We develop a controller of the form
$$
	u = -k_p J^{\top} e - k_d V
$$
Where $u$ is a 2x1 column vector of control torques sent to each motor, $k_p$ is a proportional constant, $e = [x-x_{des}, y-y_{des}]$ is a 2x1 error vector calculated by substracting the actual $x$ and $y$ positions from the desired $x$ and $y$ positions, $k_{d}$ is a derivative constant, $v = [\dot{theta}_1, \dot{\theta}_2]$ is a 2x1 vector of the joint velocities and $J$ is the jacobian of the system.<br />
Open *robotSim.m* and click run to see the simulation.
