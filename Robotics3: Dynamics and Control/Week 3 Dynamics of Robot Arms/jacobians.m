% number of links to consider
n = 2;

% DH parameters
syms a1 d1 d2 q1 q2 real

% the center of mass of each link measured relative to the link fixed frame
% (e.g. c1 = [c1x c1y c1z]' is measured relative to x1y1z1)
c = cell(n,1);
c{1} = [sym('c1x'); sym('c1y'); sym('c1z')];
c{2} = [sym('c2x'); sym('c2y'); sym('c2z')];
assume(vertcat(c{:}), 'real');

% initial conditions for the configuration of Sawyer shown in Figure 1.
% HINT: double(subs(expr, vars, vals)) evaluates a symbolic expression 'expr' by
% substituting each element of 'vals' with its corresponding symbolic variable in 'vars'
q0 = [0 3*pi/2]; % [q10 q20] mm
d0 = [317 192.5]; % [d10 d20] mm
a10 = 81; % in mm

% cell array of your homogeneous transformations; each Ti{i} is a 4x4 symbolic 
% transformation matrix in terms of the given DH parameters that transforms objects
% in frame i to the inertial frame 0
Ti = cell(n,1);

% The angular velocity Jacobian as an nx1 cell array where each element, Jw{i} is 
% a 3xn symbolic matrix
Jw = cell(n,1);

% The linear velocity Jacobian as an nx1 cell array where each element, Jv{i} is 
% a 3xn symbolic matrix
Jv = cell(n,1);

T01 = [cos(q1) 0 -sin(q1) a1*cos(q1);sin(q1) 0 cos(q1) a1*sin(q1);0 -1 0 d1;0 0 0 1];

T12 = [cos(q2) 0 -sin(q2) 0;sin(q2) 0 cos(q2) 0;0 -1 0 d2;0 0 0 1];

T02 = T01*T12;

% homogeneous transformations
Ti{1} = T01;
Ti{2} = T02;

% angular velocity Jacobian
    z_0=[0;0;1];
    z_1=Ti{1}(1:3,3);
    z_2=Ti{2}(1:3,3);
    
    all_z=zeros(3,1);
    
    Jw{1}=[z_0,all_z];
    Jw{2}=[z_0,z_1];


% linear velocity Jacobian
% Get P_i positions
    P_0=[0;0;0];
    P1=Ti{1}*[c{1};1];
    P_1=P1(1:3,1);
    P2=Ti{2}*[c{2};1];
    P_2=P2(1:3,1);
    
%%%%%%%% Linear Velocity %%%%%%%
% Get J_i jacobian for each joint
    all_z=zeros(3,1);
    
    J_1=cross(z_0,(P_1-P_0));
    Jv{1}=[J_1,all_z];
       
    J_1=cross(z_0,(P_2-P_0));
    J_2=cross(z_1,(P_2-Ti{1}(1:3,4)));
    Jv{2}=[J_1,J_2];
