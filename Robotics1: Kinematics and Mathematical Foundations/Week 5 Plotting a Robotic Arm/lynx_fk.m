function [ pos ] = lynx_fk( theta1, theta2, theta3, theta4, theta5, g )
%LYNX_FK The input to the function will be the joint
%    angles of the robot in radians, and the distance between the gripper pads in inches.
%    The output must contain 10 positions of various points along the robot arm as specified
%    in the question.

    %% YOUR CODE GOES HERE
    %pos = zeros(10, 4);
    
    A1=compute_dh_matrix(0, -pi/2, 3, theta1);
    A2=compute_dh_matrix(-5.75, 0, 0, theta2+pi/2); 
    A3=compute_dh_matrix(-7.375, 0, 0, theta3+pi/2); 
    A4=compute_dh_matrix(0, -pi/2, 0, theta4+pi/2);
    A5=compute_dh_matrix(0, 0, 4.125, theta5);
    
    
    pos = zeros(10, 3);
    
    % Transformation from link0 to link1
    T0_1 =A1;
    pos(2,1)=T0_1(1,4);
    pos(2,2)=T0_1(2,4);
    pos(2,3)=T0_1(3,4);
    
    % Transformation from link0 to link2
    T0_2=A1*A2;
    pos(3,1)=T0_2(1,4);
    pos(3,2)=T0_2(2,4);
    pos(3,3)=T0_2(3,4);
    
    % Transformation from link0 to link3
    T0_3=A1*A2*A3;
    pos(4,1)=T0_3(1,4);
    pos(4,2)=T0_3(2,4);
    pos(4,3)=T0_3(3,4);
    
    % Transformation from link0 to link4
    T0_4=A1*A2*A3*A4;
    pos(5,1)=T0_4(1,4);
    pos(5,2)=T0_4(2,4);
    pos(5,3)=T0_4(3,4);
    
    % Gripper
    e=1.125;
        % Transformation from link0 to link5
    T0_5=A1*A2*A3*A4*A5; 
    
    G1=T0_5*[0; 0; -e; 1];
    pos(6,1)=G1(1);
    pos(6,2)=G1(2);
    pos(6,3)=G1(3);
    
    G2=T0_5*[g./2; 0; -e; 1];
    pos(7,1)=G2(1);
    pos(7,2)=G2(2);
    pos(7,3)=G2(3);
    
    G3=T0_5*[-g./2; 0; -e; 1];
    pos(8,1)=G3(1);
    pos(8,2)=G3(2);
    pos(8,3)=G3(3);
    
    G4=T0_5*[g./2; 0; 0; 1];
    pos(9,1)=G4(1);
    pos(9,2)=G4(2);
    pos(9,3)=G4(3);
    
    G5=T0_5*[-g./2; 0; 0; 1];
    pos(10,1)=G5(1);
    pos(10,2)=G5(2);
    pos(10,3)=G5(3);

end

function A = compute_dh_matrix(r, alpha, d, theta)

    % Your code from part 1 of the assignment goes here
    A = eye(4);
    A=[cos(theta), -sin(theta).*cos(alpha), sin(theta).*sin(alpha), r.*cos(theta);sin(theta), cos(theta).*cos(alpha), -cos(theta).*sin(alpha), r.*sin(theta);0 sin(alpha), cos(alpha), d;0, 0, 0, 1];  
     
end
