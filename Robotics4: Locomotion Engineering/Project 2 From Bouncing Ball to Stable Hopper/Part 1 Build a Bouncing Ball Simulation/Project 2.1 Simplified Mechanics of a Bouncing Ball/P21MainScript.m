% Main Script **********************
% Assigning robot specification
param.g = 9.8;
param.r = 0.05;         % ball diameter/ spring rest length
param.m = 1;            % ball mass
param.discount = 0.8;   % Energy discount
param.COR = -sqrt(param.discount);          % Coefficient of restitution

% Initial position Q0 = [q dq], assigning run time
Q0 = [1 0];
tbegin = 0;
tfinal = 5;

% ODE solving, you do not need to modify this part
T = tbegin;
Q = Q0;
while T(end) < tfinal
    options = odeset('Events',@(t, Q)EventTouchDown(t, Q, param));
    [Ttemp, Qtemp, te, Qe, ie] = ode45(@(t, Q)EOMFlight(t, Q, param),...
            [tbegin, tfinal], Q0, options);
    nT= length(Ttemp);
    T = [T; Ttemp(2:nT)];
    Q = [Q; Qtemp(2:nT,:)];
    Q0(1) = Qtemp(nT,1);
    Q0(2) = param.COR*Qtemp(nT,2);
    tbegin = T(end);
end

plot(T,Q)
legend({'Position','COM Velocity'})

% Equations of motion ****************
function dQ = EOMFlight(t,Q,param)
    % Describe the system equation of motion for the Flight phase
    % Reminder: the state Q = [q dq]; state output dQ = [dq ddq]
    % Edit the following template
    dQ = zeros(2,1);
    dQ(1) = Q(2);
    dQ(2) = -param.g;
end

% Event function *********************
function [value,isterminal,direction] = EventTouchDown(t, Q, param)
    % Define the touchdown event
    % Locate the gaurd (where the function turns 0) at value
    % determine the direction of the event
    % stop once the event happened with isterminal
    % Edit the following template
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
    
    Q(end);
    
end
