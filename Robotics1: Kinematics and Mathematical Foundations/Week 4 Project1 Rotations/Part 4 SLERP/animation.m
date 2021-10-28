q0 = [1, 0, 0, 0];
theta = pi/2;
q1 = [cos(theta/2), sin(theta/2), 0, 0];
steps = 50;

quat_slerp( q0, q1, steps )
