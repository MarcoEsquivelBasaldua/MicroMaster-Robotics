function [ ik_sol ] = RPR_ik( x, y, z, R )
%RPR_IK Write your code here. The input to the function will be the position of
%    the end effector (in inches) in the world frame, and the 
%    Rotation matrix R_30 as described in the question.
%    The output must be the joint angles and extensions of the robot to achieve 
%    the end effector position and orientation.

    %% YOUR CODE GOES HERE
    
    % From forwards kinematics T0_3 = A1*A2*A3'*A3"*A3
    % T0_3 = [c(theta1), -s(theta1)*s(theta3), -s(theta1)*c(theta3), -s(theta1)*(10*c(theta3)+d2*sqrt(2)))/2;
    %        s(theta1), c(theta1)*s(theta3), c(theta1)*c(theta3), c(theta1)*(10*c(theta3)+d2sqrt(2))/2;
    %        0, -c(theta3), s(theta3), 10+(10*s(theta3)-d2*sqrt(2))/2;
    %        0, 0, 0, 1]
    ik_sol = ones(1, 3);
    
    
    if (R(1,1)>1.001) || (R(1,1)<-1.001)
        ik_sol = [];
    elseif (R(2,1)>1.001) || (R(2,1)<-1.001)
        ik_sol = [];
    elseif (R(3,2)>1.001) || (R(3,2)<-1.001)
        ik_sol = [];
    elseif (R(3,3)>1.001) || (R(3,3)<-1.001)
        ik_sol = [];
    %elseif R(3,1) ~= 0
    %   ik_sol = [];
    else       
        theta1=acos(R(1,1));
        theta3=asin(R(3,3)); 
        %d2 = (2*y/R(1,1) + 10*R(3,2)) / sqrt(2);
        d2=(10*R(3,3)-2*(z-10))/sqrt(2);
        %d2=(10.*R(3,2)-2.*x./R(2,1))./sqrt(2);
        
        ik_sol = [theta1, d2, theta3];
    end

end