function u = naturalController(traj,t,X)
    u = [0;0];
    l1 = 0.5;
    l2 = 0.5;
    kp = 500;
    kd = 2;
    theta1 = X(1);
    theta2 = X(2);
    theta1_dot = X(3);
    theta2_dot = X(4);
    p = [l1*cos(theta1)+l2*cos(theta1+theta2);l1*sin(theta1)+l2*sin(theta1+theta2)];
    e = p - traj; 
    J = [-l1*sin(theta1)-l2*sin(theta1+theta2),-l2*sin(theta1+theta2);l1*cos(theta1)+l2*cos(theta1+theta2),l2*cos(theta1+theta2)];
    v = [theta1_dot;theta2_dot];
    u = -kp*J'*e-kd*v;
end

