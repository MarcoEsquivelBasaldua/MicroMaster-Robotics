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

% the inertia tensor of each link relative to the inertial frame
I = cell(n,1);
I{1} = inertia_tensor(1);
I{2} = inertia_tensor(2);

% mass of each link
syms m1 m2 real

% joint velocities, where qd1 stands for 'q dot 1', the
% first derivative of q1 with respect to time
syms qd1 qd2 real

% acceleration due to gravity (assume g has the correct sign); in other words, if
% gravity were to act in the 'x' direction, the gravity vector would be [g 0 0]
syms g real

% initial conditions for the configuration of Sawyer shown in Figure 1.
% HINT: double(subs(expr, vars, vals)) evaluates a symbolic expression 'expr' by
% substituting each element of 'vals' with its corresponding symbolic variable in 'vars'
q0 = [0 3*pi/2]; % [q10 q20] mm
d0 = [317 192.5]; % [d10 d20] mm
a10 = 81; % in mm

% Homogeneous transform Matrices
T01 = [cos(q1) 0 -sin(q1) a1*cos(q1);sin(q1) 0 cos(q1) a1*sin(q1);0 -1 0 d1;0 0 0 1];
T12 = [cos(q2) 0 -sin(q2) 0;sin(q2) 0 cos(q2) 0;0 -1 0 d2;0 0 0 1];
T02 = T01*T12;

% angular velocity Jacobian
    z_0=[0;0;1];
    z_1=T01(1:3,3);
    z_2=T02(1:3,3);
    
    all_z=zeros(3,1);
    
    Jw{1}=[z_0,all_z];
    Jw{2}=[z_0,z_1];

% linear velocity Jacobian
% Get P_i positions
    P_0=[0;0;0];
    P1=T01*[c{1};1];
    P_1=P1(1:3,1);
    P2=T02*[c{2};1];
    P_2=P2(1:3,1);
    
%%%%%%%% Linear Velocity %%%%%%%
% Get J_i jacobian for each joint
    J_1=cross(z_0,(P_1-P_0));
    Jv{1}=[J_1,all_z];
       
    J_1=cross(z_0,(P_2-P_0));
    J_2=cross(z_1,(P_2-T01(1:3,4)));
    Jv{2}=[J_1,J_2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the inertia matrix

D = m1*Jv{1}'*Jv{1}+Jw{1}'*I{1}*Jw{1} + m2*Jv{2}'*Jv{2}+Jw{2}'*I{2}*Jw{2};

% kinetic energy
KE = ([qd1 qd2]*D*[qd1;qd2])/2;

% potential energy

PE = m1*[0 0 g]*P_1+m2*[0 0 g]*P_2;


