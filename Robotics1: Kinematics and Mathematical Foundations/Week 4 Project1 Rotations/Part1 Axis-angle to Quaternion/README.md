# Convert axis-angle representation to a quaternion

This script converts axis-angle representation to quaternion form.<br />
<img src="https://render.githubusercontent.com/render/math?math=Q = [cos(\theta/2),\ \vec{r}sin(\theta/2)]">


### Input format
- vec is 1x3 matrix of the form [x y z] for a vector xi + yj + zk with norm(vec) = 1
- theta will be a 1x1 rotation angle in radians

### Output format
- quat must be a 1x4 matrix
- If the quaternion is Qs + Qx i + Qy j +Qz k, it should be stored as [Qs, Qx, Qy, Qz]


