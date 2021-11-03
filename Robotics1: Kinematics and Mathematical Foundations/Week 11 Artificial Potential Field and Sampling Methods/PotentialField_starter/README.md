# Artifitial Potential Field

This code guides a robot to one location to another in a 2D configuration space using artifitial potential fields. The figure belows depicts a plot of the energy surface assotiated with our sample environment and the state of the robot is modeled by the red sphere which we can think of as rolling down the energy surface towards the goal location.<br />
![img](img.png)<br />

the function GradientBasedPlanner is used to control the motion of the robot. The signature of the function is given below.<br />
![img2](img2.png)<br />

### Input format
- *f*: A 2D array containing the potential function value.
- *start_coords*: An array specifying the coordinates of the start location. The fist entry is the x coordinate and the second the y.
- *end_coords*: An array specifying the coordinates of the goal. The fist entry is the x coordinate and the second the y.
- *max_its*: The maximum number of iterations that should be tried by the planner.

### Output format
- *route*: Array with two columns which depicts how the position of the robot evolves over the state of the simulation. The first column corresponds to the x coordinate and the second to the y coordinate, the first row corresponds to the initial position of the robot at the start of the simulation and the last row to the location where it ends up.<br />

Run the PotentialFieldScript to test the simulation.
