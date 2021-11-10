function x_dot = controller(t, state_vec) % x_dot = f(x)
    
    % sprayer offset
    l = 0.1;
    
    % the position and orientation of the robot
    x = state_vec(1);
    y = state_vec(2);
    theta = state_vec(3);
    
    k = 100;
    
    y_des = [10*cos(pi*t/5)+5*sin(pi*t/10); 10*sin(pi*t/10)-5*cos(pi*t/10)+5];
    ydot_des = [-2*pi*sin(pi*t/5)+pi/2*cos(pi*t/10); pi*cos(pi*t/10)+pi/2*sin(pi*t/10)];
    h = [x+l*cos(theta); y+l*sin(theta)];
    
    g = [cos(theta) 0;sin(theta) 0;0 1];
    
    Lgh = [cos(theta) sin(theta);-l*sin(theta) l*cos(theta)]';
    %Lgh = [diff(h(1),x) diff(h(1),y) diff(y(1),theta);diff(h(2),x) diff(h(2),y) diff(y(2),theta)]*g;
    
    u = inv(Lgh)*(ydot_des + k*(y_des-h));
    
    x_dot = g*u;
    % your code here
end
