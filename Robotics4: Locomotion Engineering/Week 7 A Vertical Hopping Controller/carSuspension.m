% Main Script **********************
param.g = 9.8;
param.m1 = 12;       % Wheel mass
param.k1 = 90000;    % Wheel eleastic constant
param.r = 0.25;      % Wheel diameter

param.m2 = 300;      % Quarter Car mass
param.k2 = 30000;    % Suspension eleastic constant
param.b2 = 3000;     % Suspension damping constant
param.COM = 0.8;     % Quarter Car COM height

% Initial position Q0 = [x1 dx1 x2 dx2]
Q0 = [0 0 0 0];
tbegin = 0;
tfinal = 5;

% ODE solving
[T, Q] = ode45(@(t, Q)EOMStance(t, Q, param),...
    [tbegin, tfinal], Q0);

% Plot solution
plot(T,Q(:,1)+param.r,T,Q(:,3)+param.COM)
xlabel('Time');ylabel('Position');
legend('Wheel COM (m)','Body COM (m)');

% Equations of motion ****************
function dQ = EOMStance(t, Q, param)
    % bump input u as a function of time
    if t<=2
        u=0;
    elseif t<2 || t<=3
        u=0.2*sin(pi*t);
    elseif t>3
        u=0;
    end
    
    % Describe the system equation of motion
    % Reminder: the state Q = [x1 dx1 x2 dx2]; 
    % state output dQ = [dx1 ddx1 dx2 ddx2]
    dQ = zeros(4,1);
    x1 = Q(1);
    dx1 = Q(2);
    x2 = Q(3);
    dx2 = Q(4);
    
    dQ(1) = dx1;
    dQ(2) = (param.k2*(x2-x1) + param.b2*(dx2-dx1) - param.k1*(x1-u) - param.g*param.m1)/param.m1;
    dQ(3) = dx2;
    dQ(4) = (-param.k2*(x2-x1) - param.b2*(dx2-dx1) - param.g*param.m2)/param.m2;
end
