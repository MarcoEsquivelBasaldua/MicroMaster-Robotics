% Main Script **********************
% Assigning robot specification
param.g = 9.8;
param.r = 0.05;    % spring rest length/ ball diameter
param.m = 1;       % ball mass
param.k = 70000;   % ball elastic constant
param.b = 15;      % ball damping ratio
param.tau = 120;   % thrust
param.thrusttime = 0.005;  % duration of thrust

% Initial position Q0 = [q dq]
Q0 = [1 0];
tbegin = 0;
tfinal = 5;
phase = 4;

% ODE solving
T = tbegin;
Q = Q0;
while T(end) < tfinal
    if phase == 1
        % touch down, into stance phase
        [Ttemp, Qtemp, te, Qe, ie] = ...
            ode45(@(t, Q)EOMStance(t, Q, param),[tbegin, tfinal], Q0,...
            odeset('Events',@(t, Q)EventBottom(t, Q, param)));
        phase = 2;
    elseif phase == 2
        % stance phase, injecting thrust
        [Ttemp, Qtemp] = ...
            ode45(@(t, Q)EOMStanceThrusted(t, Q, param),...
            [tbegin, tbegin + param.thrusttime], Q0);
        phase = 3;
    elseif phase == 3
        % stance phase without thrust
        [Ttemp, Qtemp, te, Qe, ie] = ...
            ode45(@(t, Q)EOMStance(t, Q, param),[tbegin, tfinal], Q0,...
            odeset('Events',@(t, Q)EventLiftOff(t, Q, param)));
        phase = 4;
    elseif phase == 4
        % lift off, into flight phase
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
    
plot(T,Q)
legend({'Position','COM Velocity'})

% Equations of motion ****************
function dQ = EOMFlight(t, Q, param)
    % Flight phase (from liftoff to touchdown)
    % insert your previous code here
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = -param.g;
end
function dQ = EOMStance(t, Q, param)
    % Stance phase (from touchdown to liftoff)
    % insert your previous code here
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = (-param.m*param.g - param.b*Q(2) - param.k*(Q(1) - param.r))/param.m;
end
function dQ = EOMStanceThrusted(t,Q,param)
    % Define Thrust phase (applied at the bottom for param.thrusttime)
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = (-param.m*param.g - param.b*Q(2) - param.k*(Q(1) - param.r) + param.tau)/param.m;
end

% Event functions *********************
function [value,isterminal,direction] = EventTouchDown(t, Q, param)
    % insert your previous code here
    value = Q(1) - param.r;            % event point: touch down
    if Q(2) < 0
        direction = -1;
    else
        direction = 1;
    end
    
    if Q(1) < param.r
        isterminal = 1;       % stop the integration
    else
        isterminal = 0;
    end
end
function [value,isterminal,direction] = EventLiftOff(t, Q, param)
    % insert your previous code here
    value = Q(1) - param.r;            % event point: touch down
    if Q(2) < 0
        direction = -1;
    else
        direction = 1;
    end
    
    if Q(1) > param.r
        isterminal = 1;       % stop the integration
    else
        isterminal = 0;
    end
end
function [value,isterminal,direction] = EventBottom(t, Q, param)
    % Define the lowest point
    value = Q(2);            % event point: touch down
    if Q(2) < 0
        direction = -1;
    else
        direction = 1;
    end
    
    if Q(1) < param.r
        isterminal = 1;       % stop the integration
    else
        isterminal = 0;
    end
end

