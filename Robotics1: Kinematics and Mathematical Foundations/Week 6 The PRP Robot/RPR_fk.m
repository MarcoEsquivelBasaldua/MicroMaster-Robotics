function [ pos, R ] = RPR_fk( theta1, d2, theta3 )
%RPR_FK Write your code here. The input to the function will be the joint
%    angles of the robot in radians, and the extension of the prismatic joint in inches.
%    The output includes: 
%    1) The position of the end effector and the position of 
%    each of the joints of the robot, as explained in the question.
%    2) The rotation matrix R_03, as explained in the question.

    %% YOUR CODE GOES HERE
    pos = zeros(4, 3);
    R = eye(3);
    
    % DH parameters adding frames 3' and 3" before frame 3
    % link 1 : r=0, alpha=-3*pi/4, d=10, theta=theta1
    % link 2 : r=0, alpha=-pi/2, d=d2, theta=-pi/2
    % link 3' : r=5, alpha=0, d=0, theta=theta3-pi/4
    % link 3" : r=0, alpha=-pi/2, d=0, theta=pi
    % link 3 : r=0, alpha=pi/2, d=0, theta=-pi/2
    
    A1=compute_dh_matrix(0, -3*pi/4, 10, theta1);
    A2=compute_dh_matrix(0, -pi/2, d2, -pi/2);
    A3_1=compute_dh_matrix(-5, 0, 0, theta3+3*pi/4);
    A3_2=compute_dh_matrix(0, -pi/2, 0, pi);
    A3=compute_dh_matrix(0, -pi/2, 0, -pi/2);
    
    % Position link 0
    pos(1,1)=0;
    pos(1,2)=0;
    pos(1,3)=0;
    
    % Position link 1
    pos(2,1)=A1(1,4);
    pos(2,2)=A1(2,4);
    pos(2,3)=A1(3,4);
    
    % Position link 2
    T0_2=A1*A2;
    pos(3,1)=T0_2(1,4);
    pos(3,2)=T0_2(2,4);
    pos(3,3)=T0_2(3,4);
    
    % Position link 3
    T0_3=A1*A2*A3_1;
    pos(4,1)=T0_3(1,4);
    pos(4,2)=T0_3(2,4);
    pos(4,3)=T0_3(3,4);
    
    % Orientation R
    R0_3=A1*A2*A3_1*A3_2*A3;
    R(1,1)=R0_3(1,1);
    R(1,2)=R0_3(1,2);
    R(1,3)=R0_3(1,3);
    R(2,1)=R0_3(2,1);
    R(2,2)=R0_3(2,2);
    R(2,3)=R0_3(2,3);
    R(3,1)=R0_3(3,1);
    R(3,2)=R0_3(3,2);
    R(3,3)=R0_3(3,3);

end

function A = compute_dh_matrix(r, alpha, d, theta)
    A = eye(4);
    A=[cos(theta), -sin(theta).*cos(alpha), sin(theta).*sin(alpha), r.*cos(theta);sin(theta), cos(theta).*cos(alpha), -cos(theta).*sin(alpha), r.*sin(theta);0 sin(alpha), cos(alpha), d;0, 0, 0, 1];  
end