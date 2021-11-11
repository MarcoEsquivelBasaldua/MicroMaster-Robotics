% Main Script **********************
% Asigning physical specification
param.g = 9.8;
param.alpha = -1;    % spring rest length
param.beta = 1;    % block mass
param.delta = 0.3;  % spring constant
param.omega = 1.2;    % damping ratio
param.gamma = 0.37;

% Initial position q0 = [q dq]
q0 = [1 0];
tbegin = 0;
tfinal = 30;

% ODE solving
[T,Q] = ode45(@(t,Q)Duffing(t, Q, param), [tbegin, tfinal], q0);
plot(Q(:,1),Q(:,2))
xlabel('position');ylabel('velocity');

% Equation of motion ****************
function dQ = Duffing(t, Q ,param)
    % Describe the system equation of motion derived by Lagrangian method
    % Reminder: the state Q = [q dq]
    % States output dQ = [dq ddq]
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = param.gamma*cos(param.omega*t)-param.delta*Q(2)-param.alpha*Q(1)-param.beta*Q(1)^3;
end

