% Main Script
% Robot specification
param.g = 9.8;
param.d = 0.08;     % ball diameter
param.r = 0.3;      % spring rest length/ chi0
param.m = 3;        % ball mass
param.k = 5000;     % vitual spring eleastic constant
param.b = 6;        % damping constant


% Initial position Q0 = [q dq]
Q0 = [1 0];
tbegin = 0;
tfinal = 2;
phase = 2;

% ODE solving
T = tbegin;
Q = Q0;
while T(end) < tfinal
    if phase == 1
        % touch down, into stance phase
        [Ttemp, Qtemp, te, Qe, ie] = ...
            ode45(@(t, Q)EOMStance(t, Q, param),[tbegin, tfinal], Q0,...
            odeset('Events',@(t, Q)EventLiftOff(t, Q, param)));
        phase = 2;
    elseif phase == 2
        % lift off, into fly phase
        [Ttemp, Qtemp, te, Qe, ie] = ...
            ode45(@(t, Q)EOMFlight(t, Q, param),[tbegin, tfinal], Q0,...
            odeset('Events',@(t, Q)EventTouchDown(t, Q, param)));
        phase = 1;
    end
    nT= length(Ttemp);
    T = [T; Ttemp(2:nT)];
    Q = [Q; Qtemp(2:nT,:)];
    Q0 = Qtemp(nT,:);
    tbegin = Ttemp(nT);
end

% T2 = [0: 1e-2: tfinal];
% Q2 = interp1(T, Q, T2);
% % Simulation Visualization
% RunHopperSimulation(T2, Q2, param, 'none')
plot(T,Q)

% Equations of motion
function dQ = EOMFlight(t, Q, param)
    % Describe the system equation of motion
    % Flight phase (from liftoff to touchdown)
    % Reminder: the state Q = [q dq]; state output dQ = [dq ddq]
    % Edit the following template
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = -param.g;
end
function dQ = EOMStance(t, Q, param)
    % Stance phase (from touchdown to liftoff)
    % --- COMPLETE THIS SECTION --- %
    u = (param.b/param.m - 2*sqrt(param.k/param.m))*param.m * Q(2) + param.m*param.g;
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = -param.k/param.m*(Q(1)-param.r)-param.b/param.m*Q(2)-param.g+u/param.m;
end

% Event functions
function [value,isterminal,direction] = EventTouchDown(t, Q, param)
    % Locate the gaurd (where the function turns 0) at value
    % determine the direction of the event
    % stop once the event happened with isterminal
    % Edit the following template
    value = Q(1)-param.r;     % event point: touch down
    direction = -1;           % direction
    isterminal = 1;           % stop the integration
end

function [value,isterminal,direction] = EventLiftOff(t, Q, param)
    value = Q(1)-param.r;     % event point: lift off
    direction = 1;            % direction
    isterminal = 1;           % stop the integration
end

