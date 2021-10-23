%% Helper script to visualize forward kinematics of a RPR robot

close all
pause on;  % Set this to on if you want to watch the animation
GraphingTimeDelay = 0.05; % The length of time that Matlab should pause between positions when graphing, if at all, in seconds.
totalTimeSteps = 100; % Number of steps in the animation

% Generate the starting and final joint angles, and gripper distance
% Set values manually, or randomise as shown below
theta1_0 = 0;
d2_0 = 0;
theta3_0 = 0;

theta1_1 = pi;
d2_1 = -10;
theta3_1 = pi/2;

[pos, R] = RPR_fk(theta1_1, d2_1, theta3_1);
ik_sol = RPR_ik(pos(1), pos(2), pos(3),  R);

% Use below code if you want to randomise
%theta1_0 = rand(1) * 2 * pi;
%d2_0 = 10 * rand(1);
%theta3_0 = rand(1) * 2 * pi;

%theta1_1 = rand(1) * 2 * pi;
%d2_1 = 10 * rand(1);
%theta3_1 = rand(1) * 2 * pi;

% Setup plot
figure  
scale_f = 20;
axis vis3d
axis(scale_f*[-1 1 -1 1 -1 1])
grid on
view(70,10)
xlabel('X (in.)')
ylabel('Y (in.)')
zlabel('Z (in.)')

% Plot robot initially
hold on
hrobot = plot3([0 0 10], [0 0 0], [0 6 6],'k.-','linewidth',2,'markersize',10);

% Animate the vector
pause(GraphingTimeDelay);
for i = 1:totalTimeSteps
   
    t = i/totalTimeSteps
    pos = RPR_fk(ik_sol(1) *t, ik_sol(2) *t, ik_sol(3) *t);
    
    set(hrobot,'xdata',[pos(1, 1) pos(2, 1) pos(3, 1) ]',...
        'ydata',[pos(1, 2) pos(2, 2) pos(3, 2) ]',...
        'zdata',[pos(1, 3) pos(2, 3) pos(3, 3) ]');
    
    pause(GraphingTimeDelay);
end