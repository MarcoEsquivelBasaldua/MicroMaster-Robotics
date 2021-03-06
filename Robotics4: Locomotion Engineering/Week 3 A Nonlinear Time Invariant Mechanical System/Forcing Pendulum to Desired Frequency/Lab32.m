% Main Script **********************
% Asigning physical specification
param.g = 9.8;
param.l = 1;    % pendulum length
param.m = 1;    % pendulum mass
param.b = 2;    % damping ratio

% Initial position q0 = [q dq]
q0 = [pi/6 0];
tbegin = 0;
tfinal = 5;

% ODE solving
[T,Q] = ode45(@(t,Q)ForcedPendulum(t, Q, param), [tbegin, tfinal], q0);
plot(T,Q(:,1))
xlabel('time');ylabel('position');

% Equation of motion ****************
function dQ = ForcedPendulum(t, Q, param)
    tau = param.b/(param.m*param.l^2)*Q(2);        %-param.l*param.g*param.m*Q(1);
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    %dQ(2) = tau;%-param.b/(param.m*param.l^2)*Q(2)-param.g/(2*param.l)*(1+sqrt(3)*(Q(1)-pi/6));
    dQ(2) = -param.g/param.l * Q(1) - param.b/(param.m*param.l^2)*Q(2) + tau;                %-(param.b*Q(2) + param.m*param.g*param.l*cos(Q(1)))/(param.m*param.l^2) + tau;
end

