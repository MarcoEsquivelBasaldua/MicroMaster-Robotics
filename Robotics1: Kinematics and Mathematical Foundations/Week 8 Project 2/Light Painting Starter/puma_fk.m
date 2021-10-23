function [pos, R] = puma_fk(theta1, theta2, theta3, theta4, theta5, theta6)
%PUMA_FK The input to the function will be the joint angles of the robot in radians.
%    The output must contain end effector position of the robot arm and the rotation matrix representing the rotation from frame
%    6 to frame 0, as specified in the question.

    %% Your code goes here
    pos = zeros(1, 3);
    R = eye(3);
    
    %%%%% Forward kinematics %%%%%%
    a=13;
    b=2.5;
    c=8;
    d=2.5;
    e=8;
    f=2.5;
    A1=compute_dh_matrix(0, pi/2, a, theta1);
    A2=compute_dh_matrix(c, 0, -b, theta2);
    A3=compute_dh_matrix(0, -pi/2, -d, theta3);
    A4=compute_dh_matrix(0, pi/2, e, theta4);
    A5=compute_dh_matrix(0, -pi/2, 0, theta5);
    A6=compute_dh_matrix(0, 0, f, theta6);
    
    % Transformations;
    T0_1=A1;
    T0_2=A1*A2;
    T0_3=A1*A2*A3;
    T0_4=A1*A2*A3*A4;
    T0_5=A1*A2*A3*A4*A5;
    T0_6=A1*A2*A3*A4*A5*A6;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Position %
    pos(1)=T0_6(1,4);
    pos(2)=T0_6(2,4);
    pos(3)=T0_6(3,4);
    
    % Orientation %
    R(1,1)=T0_6(1,1);
    R(1,2)=T0_6(1,2);
    R(1,3)=T0_6(1,3);
    R(2,1)=T0_6(2,1);
    R(2,2)=T0_6(2,2);
    R(2,3)=T0_6(2,3);
    R(3,1)=T0_6(3,1);
    R(3,2)=T0_6(3,2);
    R(3,3)=T0_6(3,3);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pos_3=zeros(1,3);
    pos_4=zeros(1,3);
    pos_3=T0_3*[0;0;0;1];
    pos_4=T0_4*[0;0;0;1];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function A = compute_dh_matrix(r, alpha, d, theta)

    A = eye(4);
    A=[cos(theta), -sin(theta).*cos(alpha), sin(theta).*sin(alpha), r.*cos(theta);sin(theta), cos(theta).*cos(alpha), -cos(theta).*sin(alpha), r.*sin(theta);0 sin(alpha), cos(alpha), d;0, 0, 0, 1];  
    
end

