clear; clc;

%% homogeneous transforms

n = 7; % DOF

% DH parameters
q = sym('q', [n 1], 'real'); % generalized coordinates (joint angles)
d = sym('d', [n 1], 'real'); % link offsets
syms a1

% initial conditions for the configuration of Sawyer shown in Figure 1.
% you can use these values to sense check your work
% HINT: vpa(subs(expr, vars, vals)) evaluates a symbolic expression 'expr' by
% substituting each element of 'vals' with its corresponding symbolic variable in 'vars'
q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
a10 = 81;

% cell array of your homogeneous transformations; each Ti{i} is a 4x4 symbolic transform matrix
% provide your answer in terms of the given symbolic variables
% NOTE: for symbolic arrays: q(1) = q1, q(2) = q2, etc.
Ti = cell(n,1);

% Ti = your homogeneous transformations solution
A1=compute_dh_matrix(a1, -pi/2, d(1), q(1));
A2=compute_dh_matrix(0, -pi/2, d(2), q(2));
A3=compute_dh_matrix(0, -pi/2, d(3), q(3));
A4=compute_dh_matrix(0, -pi/2, d(4), q(4));
A5=compute_dh_matrix(0, -pi/2, d(5), q(5));
A6=compute_dh_matrix(0, -pi/2, d(6), q(6));
A7=compute_dh_matrix(0, 0, d(7), q(7));

Ti{1}=A1;
Ti{2}=A1*A2;
Ti{3}=A1*A2*A3;
Ti{4}=A1*A2*A3*A4;
Ti{5}=A1*A2*A3*A4*A5;
Ti{6}=A1*A2*A3*A4*A5*A6;
Ti{7}=A1*A2*A3*A4*A5*A6*A7;

%% angular velocity jacobian (Jw)

% Initialize angular velocity jacobian as an nx1 cell array where each element is
% an 3xn symbolic matrix
Jw = arrayfun(@(x) sym(['Jw' num2str(x)], [3,n], 'real'), 1:n, 'UniformOutput', 0)';

% Jw = your angular velocity jacobian solution
% Get z_i axis
    z_0=[0;0;1];
    z_1=Ti{1}(1:3,3);
    z_2=Ti{2}(1:3,3);
    z_3=Ti{3}(1:3,3);
    z_4=Ti{4}(1:3,3);
    z_5=Ti{5}(1:3,3);
    z_6=Ti{6}(1:3,3);
    z_7=Ti{7}(1:3,3);
    
    all_z=zeros(3,1);
    
    Jw{1}=[z_0,all_z,all_z,all_z,all_z,all_z,all_z];
    Jw{2}=[z_0,z_1,all_z,all_z,all_z,all_z,all_z];
    Jw{3}=[z_0,z_1,z_2,all_z,all_z,all_z,all_z];
    Jw{4}=[z_0,z_1,z_2,z_3,all_z,all_z,all_z];
    Jw{5}=[z_0,z_1,z_2,z_3,z_4,all_z,all_z];
    Jw{6}=[z_0,z_1,z_2,z_3,z_4,z_5,all_z];
    Jw{7}=[z_0,z_1,z_2,z_3,z_4,z_5,z_6];

%% linear velocity jacobian (Jv)

% the center of mass of each link measured relative to the link fixed frame
% like Ti and Jw, c is an nx1 cell array where each element is a symoblic vector/matrix
% for example: c{3} = [c3x c3y c3z]' is the center of mass of link 3 measured relative to frame 3
c = arrayfun(@(x) [sym(['c' num2str(x) 'x'], 'real'), sym(['c' num2str(x) 'y'], 'real'), ...
    sym(['c' num2str(x) 'z'], 'real')]', 1:n, 'UniformOutput', 0)';

% as with the angular velocity jacobian, the linear velocity jacobian is comprised of n 3xn
% symbolic matrices stored in a cell array. Jv{i} is the 3xn angular velocity jacobian of link i
Jv = cell(n,1);

%  Jv = your linear velocity jacobian solution
    for i = 1:n
    for j=1:n
        if (j==1)
            P_i=Ti{i}*[c{i};1];
            Jv{i}(1:3,j)=cross([0;0;1], P_i(1:3,1));
        else
            if j<=i
                P_i=Ti{i}*[c{i};1];
                P_j=Ti{j-1}*[c{j-1};1]; 
                Jv{i}(1:3,j)=cross(Ti{j-1}(1:3,3), P_i(1:3,1)-Ti{j-1}(1:3,4));
            else
               Jv{i}(1:3,j)=zeros(3,1);
            end
        end
    end
end

%% potential energy

m = sym('m', [n 1], 'real'); % mass of each link

% PE = your potential energy solution
PE = 0;% total potential energy of Sawyer

for i=1:n
    P = Ti{i}*[c{i};1];
    PE = PE + m(i)*[0 0 g]*P(1:3,1);
end

%% inertial matrix and kinetic energy

qd = sym('qd', [n 1], 'real'); % "q dot" - the first derivative of the q's in time (joint velocities)

% inertia tensor for each link relative to the inertial frame stored in an nx1 cell array
I = arrayfun(@(x) inertia_tensor(x), 1:n, 'UniformOutput', 0)';

% D = your inertia matrix solution
D = zeros(n);% nxn inertia matrix
for i=1:n
    D = D +m(i)*Jv{i}'*Jv{i}+Jw{i}'*I{i}*Jw{i};
end

% KE = your kinetic energy solution
KE = (qd'*D*qd)/2;% total kinetic energy of Sawyer

%% equations of motion

qdd = sym('qdd', [n 1], 'real'); % "q double dot" - the second derivative of the q's in time (joint accelerations)

C = sym(zeros(n));
for k=1:n
    for j=1:n
        for i=1:n
            C(j,k)=C(j,k)+((diff(D(k,j),q(j))+diff(D(k,i),q(j))-diff(D(i,j),q(k)))*qd(i))/2;
        end
    end
end

G = sym(zeros(n,1));
for i=1:n
    G(i)=diff(PE,q(i));
end

eom_lhs = D*qdd + C*qd + G;

%%%%%%% THIS IS THE END OF YOUR INPUT/EDITS %%%%%%%%

%% helper functions (don't use/edit - only used to help initialize I)
function tensor = inertia_tensor(num)

n = num2str(num);

tensor = [sym(['Ixx' n]) sym(['Ixy' n]) sym(['Ixz' n]);
          sym(['Iyx' n]) sym(['Iyy' n]) sym(['Iyz' n]);
          sym(['Izx' n]) sym(['Izy' n]) sym(['Izz' n])];

assume(tensor, 'real');

end

function A = compute_dh_matrix(r, alpha, d, theta)
    A = eye(4);
    A =[cos(theta) -sin(theta).*cos(alpha) sin(theta).*sin(alpha) r.*cos(theta);
        sin(theta) cos(theta).*cos(alpha) -cos(theta).*sin(alpha) r.*sin(theta);
        0 sin(alpha) cos(alpha) d;
        0 0 0 1]; 
end