% qd1 and qd2 are the time derivatives of q1 and q2 respectively
syms a1 d1 d2 q1 q2 c1 c2 c3 qd1 qd2 real

% provide your answer in terms of the above syms
T01 = [cos(q1) 0 -sin(q1) a1*cos(q1);sin(q1) 0 cos(q1) a1*sin(q1);0 -1 0 d1;0 0 0 1];

T12 = [cos(q2) 0 -sin(q2) 0;sin(q2) 0 cos(q2) 0;0 -1 0 d2;0 0 0 1];

T02 = T01*T12;

% Get points positions
    p0=[0;0;0];
    p1=T01*[0;0;c1;1];
    p1=p1(1:3,1);
    p2=T02*[0;-c3;c2;1];
    p2=p2(1:3,1);

%{
% Using Jacobians    
% Get z_i z axis
    z_0=[0;0;1];
    z_1=[T01(1,3);T01(2,3);T01(3,3)];
    z_2=[T02(1,3);T02(2,3);T02(3,3)];
    
% Get J_i jacobian for each joint
    J_1=cross(z_0,(p2-p0));
    J_2=cross(z_1,(p2-p1));
        
vp2 = [J_1,J_2]*[qd1;qd2];

% Get new J_1 since the last joint will be now link 1
J_1=cross(z_0,(p1-p0));
vp1 = J_1*qd1;
%}
    
    % Using a vector aproximation
    
    dp1_dq1=diff(p1,q1);
    vp1=dp1_dq1*qd1;
    
    dp2_dq1=diff(p2,q1);
    dp2_dq2=diff(p2,q2);
    vp2=dp2_dq1*qd1 + dp2_dq2*qd2;
    

