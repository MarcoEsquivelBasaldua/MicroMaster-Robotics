# Graph Based Planning Method

In this unit planning systems are implemented on 2D grid like environments. In both sections, Dijkstra and A* algorithms, the input map is specified as a 2D logical array where the false or zero entries correspond to free cells and the true or non-zero entries correspond to obstacle cells. The goal of these planning routines is to construct a route between the specified start and destination cells.

## Dijkstra Algorithm for Graph Search
The code contains the following 2D arrays:<br />
- *map* An array of integer values which indicates the current status of each cell in the grid. Different integer values are used to indicate the different possible states listed below:
	- whether the node is part of an obstacle
	- if the node is on free space
	- whether or not is has been visited
	- is currently on the list of nodes being considered
*distanceFromStart* This array encodes the current estimate for the distance between each node and the start node.<br />
*parent* For every cell in the map this array records the index of its parent with respect of the algorithm, that  is the next node along the shortest path to the start node.<br />

on every iteration on the main loop the code finds the unvisited cell with the smallest distance value, i.e., the node that is the closest to the start node. The code considers the four neighbors of the cell. For each neighbor the function decides if it needs to update the corresponding entries in the distanceFromStart, map and parent arrays. Click the 'Run' button to test the code.

## A* Algorithm for Graph Search
The code is design to maintain the following 2D arrays:
- *g* This array encodes the current estimate for the distance between each node and the start node.
- *f* This array encodes the sum of the g value for each node and the value of the Heuristic function.
- *H* computes an array with appropriate heuristic function values for each node.

The map and the parent arays carry out the same function as in DijkstraGrid.m. On every iteration on the throught the main loop the code finds the unvisited cell with the smallest f value. The function considers the four neighbors of the cell and for each neighbor it should decides if it needs to update the corresponding entries in the f, g, map and parent arrays. There is a variable called drawMap that can be toggled to enable or disable the visialization of the planner's progress at each iteration.
