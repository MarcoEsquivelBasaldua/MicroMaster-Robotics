function [ v05, w05 ] = lynx_velocities( thetas, thetadot )
%LYNX_VELOCITIES The input to the function will be:
%    thetas: The joint angles of the robot in radians - 1x5 matrix
%    thetadot: The rate of change of joint angles of the robot in radians/sec - 1x5 matrix
%    The output has 2 parts:
%    v05 - The linear velocity of frame 5 with respect to frame 0, expressed in frame 0.
%    w05 - The angular velocity of frame 5 with respect to frame 0, expressed in frame 0.
%    They are both 1x3 matrices of the form [x y z] for a vector xi + yj + zk

    %% YOUR CODE GOES HERE
    v05 = zeros(1, 3);
    w05 = zeros(1, 3);
    
    % link 1: r = 0, alpha = -pi/2, d = 3, theta = thetas(1)
    % link 2: r = 5.75, alpha = 0, d = 0, theta = thetas(2)-pi/2
    % link 3: r = 7.375, alpha = 0, d = 0, theta = theta(s(3)+pi/2
    % link 4: r = 0, alpha = -pi/2, d = 0, theta = thetas(4)-pi/2
    % link 5: r = 0, alpha = 0, d = 4.125, theta = thetas(5)
    
    % Compute A1...An for each link transformation
    A1=compute_dh_matrix(0, -pi/2, 3, thetas(1));
    A2=compute_dh_matrix(5.75, 0, 0, thetas(2)-pi/2); 
    A3=compute_dh_matrix(-7.375, 0, 0, thetas(3)-pi/2); 
    A4=compute_dh_matrix(0, -pi/2, 0, thetas(4)+pi/2);
    A5=compute_dh_matrix(0, 0, 4.125, thetas(5));
    
    % Transformation from link0 to link1
    T0_1 =A1;
    
    % Transformation from link0 to link2
    T0_2=A1*A2;
    
    % Transformation from link0 to link3
    T0_3=A1*A2*A3;
    
    % Transformation from link0 to link4
    T0_4=A1*A2*A3*A4;
    
    % Transformation from link0 to link5
    T0_5=A1*A2*A3*A4*A5; 
    
    % Get P_i positions
    P_0=[0;0;0];
    P_1=[T0_1(1,4);T0_1(2,4);T0_1(3,4)];
    P_2=[T0_2(1,4);T0_2(2,4);T0_2(3,4)];
    P_3=[T0_3(1,4);T0_3(2,4);T0_3(3,4)];
    P_4=[T0_4(1,4);T0_4(2,4);T0_4(3,4)];
    P_5=[T0_5(1,4);T0_5(2,4);T0_5(3,4)];
    
    % Get z_i z axis
    z_0=[0;0;1];
    z_1=[T0_1(1,3);T0_1(2,3);T0_1(3,3)];
    z_2=[T0_2(1,3);T0_2(2,3);T0_2(3,3)];
    z_3=[T0_3(1,3);T0_3(2,3);T0_3(3,3)];
    z_4=[T0_4(1,3);T0_4(2,3);T0_4(3,3)];
    z_5=[T0_5(1,3);T0_5(2,3);T0_5(3,3)];
    
    %%%%%%%% Linear Velocity %%%%%%%
    % Get J_i jacobian for each joint
    J_1=cross(z_0,(P_5-P_0));
    J_2=cross(z_1,(P_5-P_1));
    J_3=cross(z_2,(P_5-P_2));
    J_4=cross(z_3,(P_5-P_3));
    J_5=cross(z_4,(P_5-P_4));
    
    J=[J_1,J_2,J_3,J_4,J_5];
    
    v05=(J*thetadot')';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%% Angular Velocity %%%%%%%%%%%
    % Get J_i jacobian for each joint
    J_1=z_0;
    J_2=z_1;
    J_3=z_2;
    J_4=z_3;
    J_5=z_4;
    
    J=[J_1,J_2,J_3,J_4,J_5];
    
    w05=(J*thetadot')';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    

end

function A = compute_dh_matrix(r, alpha, d, theta)
    %% Your code from the first part of this assignment goes here
    %% You can use this function in the lynx_fk function
    A = eye(4);
    A=[cos(theta), -sin(theta).*cos(alpha), sin(theta).*sin(alpha), r.*cos(theta);sin(theta), cos(theta).*cos(alpha), -cos(theta).*sin(alpha), r.*sin(theta);0 sin(alpha), cos(alpha), d;0, 0, 0, 1];  
end
