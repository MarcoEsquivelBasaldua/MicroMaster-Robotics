function [ v06, w06 ] = puma_velocities( thetas, thetadot )
%PUMA_VELOCITIES The input to the function will be:
%    thetas: The joint angles of the robot in radians - 1x6 matrix
%    thetadot: The rate of change of joint angles of the robot in radians/sec - 1x6 matrix
%    The output has 2 parts:
%    v06 - The linear velocity of frame 6 with respect to frame 0, expressed in frame 0.
%    w06 - The angular velocity of frame 6 with respect to frame 0, expressed in frame 0.
%    They are both 1x3 matrices of the form [x y z] for a vector xi + yj + zk

    %% YOUR CODE GOES HERE
    v06 = zeros(1, 3);
    w06 = zeros(1, 3);
    
    %%%%% Forward kinematics %%%%%%
    a=13;
    b=2.5;
    c=8;
    d=2.5;
    e=8;
    f=2.5;
    A1=compute_dh_matrix(0, pi/2, a, thetas(1));
    A2=compute_dh_matrix(c, 0, -b, thetas(2));
    A3=compute_dh_matrix(0, -pi/2, -d, thetas(3));
    A4=compute_dh_matrix(0, pi/2, e, thetas(4));
    A5=compute_dh_matrix(0, -pi/2, 0, thetas(5));
    A6=compute_dh_matrix(0, 0, f, thetas(6));
    
    % Transformations;
    T0_1=A1;
    T0_2=A1*A2;
    T0_3=A1*A2*A3;
    T0_4=A1*A2*A3*A4;
    T0_5=A1*A2*A3*A4*A5;
    T0_6=A1*A2*A3*A4*A5*A6;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get P_i positions
    P_0=[0;0;0];
    P_1=[T0_1(1,4);T0_1(2,4);T0_1(3,4)];
    P_2=[T0_2(1,4);T0_2(2,4);T0_2(3,4)];
    P_3=[T0_3(1,4);T0_3(2,4);T0_3(3,4)];
    P_4=[T0_4(1,4);T0_4(2,4);T0_4(3,4)];
    P_5=[T0_5(1,4);T0_5(2,4);T0_5(3,4)];
    P_6=[T0_6(1,4);T0_6(2,4);T0_6(3,4)];
    
    % Get z_i z axis
    z_0=[0;0;1];
    z_1=[T0_1(1,3);T0_1(2,3);T0_1(3,3)];
    z_2=[T0_2(1,3);T0_2(2,3);T0_2(3,3)];
    z_3=[T0_3(1,3);T0_3(2,3);T0_3(3,3)];
    z_4=[T0_4(1,3);T0_4(2,3);T0_4(3,3)];
    z_5=[T0_5(1,3);T0_5(2,3);T0_5(3,3)];
    z_6=[T0_6(1,3);T0_6(2,3);T0_6(3,3)];
    
    %%%%%%%% Linear Velocity %%%%%%%
    % Get J_i jacobian for each joint
    J_1=cross(z_0,(P_6-P_0));
    J_2=cross(z_1,(P_6-P_1));
    J_3=cross(z_2,(P_6-P_2));
    J_4=cross(z_3,(P_6-P_3));
    J_5=cross(z_4,(P_6-P_4));
    J_6=cross(z_5,(P_6-P_5));
    
    J=[J_1,J_2,J_3,J_4,J_5,J_6];
    
    v06=(J*thetadot')';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%% Angular Velocity %%%%%%%%%%%
    % Get J_i jacobian for each joint
    J_1=z_0;
    J_2=z_1;
    J_3=z_2;
    J_4=z_3;
    J_5=z_4;
    J_6=z_5;
    
    J=[J_1,J_2,J_3,J_4,J_5,J_6];
    
    w06=(J*thetadot')';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
function A = compute_dh_matrix(r, alpha, d, theta)
    A = eye(4);
    A=[cos(theta), -sin(theta).*cos(alpha), sin(theta).*sin(alpha), r.*cos(theta);sin(theta), cos(theta).*cos(alpha), -cos(theta).*sin(alpha), r.*sin(theta);0 sin(alpha), cos(alpha), d;0, 0, 0, 1];  
end
