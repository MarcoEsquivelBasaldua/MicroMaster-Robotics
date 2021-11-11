% Main Script **********************
% Asigning physical specification
param.g = 9.8;
param.l = 1;    % spring rest length
param.m = 1;    % block mass
param.k = 10;  % spring constant
param.b = 5;    % damping ratio

% Initial position q0 = [q dq]
q0 = [1.25*param.l 0];
q0_2 = [1*param.l,0];
tbegin = 0;
tfinal = 5;

% ODE solving
[T,Q] = ode45(@(t,Q)nonlinearDHO(t, Q, param), [tbegin, tfinal], q0);
[T2,Q2] = ode45(@(t,Q2)nonlinearDHO(t, Q2, param), [tbegin, tfinal], q0_2);

% Plotting solutions
figure(1)
plot(Q(:,1),Q(:,2))
xlabel('position');ylabel('velocity');
figure(2)
plot(T,Q(:,1))
xlabel('time');ylabel('position');
figure(3)
plot(Q2(:,1),Q2(:,2))
xlabel('position');ylabel('velocity');
figure(4)
plot(T2,Q2(:,1))
xlabel('time');ylabel('position');

% Equation of motion ****************
function dQ = nonlinearDHO(t, Q ,param)
    % Describe the system equation of motion derived by Lagrangian method
    % Reminder: the state Q = [q dq]
    % States output dQ = [dq ddq]
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = -param.k/param.m*(Q(1)-param.l)^3-param.b/param.m*Q(2);
end

