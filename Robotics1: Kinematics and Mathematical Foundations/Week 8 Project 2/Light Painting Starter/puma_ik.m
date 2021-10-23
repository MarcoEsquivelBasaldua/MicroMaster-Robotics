function [ ik_sol ] = puma_ik( x, y, z, R )
%PUMA_IK Write your code here. The input to the function will be the position of
%    the end effector (in inches) in the world frame, and the 
%    Rotation matrix R_60 as described in the question.
%    The output must be the joint angles of the robot to achieve 
%    the desired end effector position and orientation.

    %% YOUR CODE GOES HERE
    ik_sol = zeros(1, 6);
%    T0_6 =
%[ - c6*(s5*(c1*c2*s3 + c1*c3*s2) + c5*(s1*s4 - c4*(c1*c2*c3 - c1*s2*s3))) - s6*(c4*s1 + s4*(c1*c2*c3 - c1*s2*s3)), s6*(s5*(c1*c2*s3 + c1*c3*s2) + c5*(s1*s4 - c4*(c1*c2*c3 - c1*s2*s3))) - c6*(c4*s1 + s4*(c1*c2*c3 - c1*s2*s3)),   s5*(s1*s4 - c4*(c1*c2*c3 - c1*s2*s3)) - c5*(c1*c2*s3 + c1*c3*s2), 8*c1*c2 - 5*s1 - (5*c5*(c1*c2*s3 + c1*c3*s2))/2 + (5*s5*(s1*s4 - c4*(c1*c2*c3 - c1*s2*s3)))/2 - 8*c1*c2*s3 - 8*c1*c3*s2]
%[   s6*(c1*c4 - s4*(c2*c3*s1 - s1*s2*s3)) - c6*(s5*(c2*s1*s3 + c3*s1*s2) - c5*(c1*s4 + c4*(c2*c3*s1 - s1*s2*s3))), s6*(s5*(c2*s1*s3 + c3*s1*s2) - c5*(c1*s4 + c4*(c2*c3*s1 - s1*s2*s3))) + c6*(c1*c4 - s4*(c2*c3*s1 - s1*s2*s3)), - c5*(c2*s1*s3 + c3*s1*s2) - s5*(c1*s4 + c4*(c2*c3*s1 - s1*s2*s3)), 5*c1 + 8*c2*s1 - (5*c5*(c2*s1*s3 + c3*s1*s2))/2 - (5*s5*(c1*s4 + c4*(c2*c3*s1 - s1*s2*s3)))/2 - 8*c2*s1*s3 - 8*c3*s1*s2]
%[                                         c6*(s5*(c2*c3 - s2*s3) + c4*c5*(c2*s3 + c3*s2)) - s4*s6*(c2*s3 + c3*s2),                                     - s6*(s5*(c2*c3 - s2*s3) + c4*c5*(c2*s3 + c3*s2)) - c6*s4*(c2*s3 + c3*s2),                         c5*(c2*c3 - s2*s3) - c4*s5*(c2*s3 + c3*s2),                                  8*s2 + 8*c2*c3 - 8*s2*s3 + (5*c5*(c2*c3 - s2*s3))/2 - (5*c4*s5*(c2*s3 + c3*s2))/2 + 13]
%[                                                                                                               0,                                                                                                             0,                                                                  0,                                                                                                                       1]
    a=13;
    b=2.5;
    c=8;
    d=2.5;
    e=8;
    f=2.5;
    
    %Pc=[x;y;z]-f*R*[0;0;1];
    % Calculate where the wrist center position oc needs to be.
Pc=[x;y;z]-f*R*[0;0;1];

% Pull out the components of wrist center and store in xc, yc, zc.
xc = Pc(1);
yc = Pc(2);
zc = Pc(3);

% Different situations lead to different solutions
if xc^2+yc^2-(b+d)^2 < 0
    % There is no solution for theta1. pi,pi/2,pi/2,-pi/2,-pi/6,pi/3
    th1 = pi;
    th2 = pi/2;
    th3 = pi/2;
    th4 = -pi/2;
    th5 = -pi/6;
    th6 = pi/3;
    
else

    % Do inverse position kinematics and calculate theta1, theta2, theta3.
    % Calculate theta1.
    if xc^2+yc^2-(b+d)^2 == 0 
        % Singularity configurations. Only one solution for theta1. Here we
        % assign two identical solutions to theta1, which will be eliminated to
        % one set at the end.

        theta1_1 = atan2(yc,xc)- pi/2;
        theta1_2 = atan2(yc,xc)- pi/2;
    else
        theta1_1 = atan2(yc,xc) - atan2(b+d, sqrt(xc^2+yc^2-(b+d)^2));
        theta1_2 = atan2(yc,xc) + atan2(-(b+d), -sqrt(xc^2+yc^2-(b+d)^2));
    end
    % Calculate theta3.
    r = sqrt(xc^2+yc^2-(b+d)^2);
    s = zc-a;
    cos_temp = (e^2+c^2-r^2-s^2)/2/e/c;
    if abs(cos_temp)>1
        % This is when the desired position is outside of the robot's reachable
        % workspace.
        th1 = [NaN];
        th2 = [NaN];
        th3 = [NaN];
        th4 = [NaN];
        th5 = [NaN];
        th6 = [NaN];
    else
        temp = atan2(sqrt(1-cos_temp^2),cos_temp);

        theta3_1 = pi/2 - temp;
        theta3_2 = pi/2 + temp;

        % Calculate theta2.
        theta2_1 = atan2(s,r) - atan2(e*cos(theta3_1), c-e*sin(theta3_1));
        theta2_2 = atan2(s,r) - atan2(e*cos(theta3_2), c-e*sin(theta3_2));

        theta3_3 = pi-theta3_1;
        theta2_3 = pi-theta2_1;

        theta3_4 = pi-theta3_2;
        theta2_4 = pi-theta2_2;  

        % Calculate R03 using forward kinematics.
        %%% 1st pair of solutions
        A1 = compute_dh_matrix(0,  pi/2,   a, theta1_1);
        A2 = compute_dh_matrix(c,     0,  -b, theta2_1);
        A3 = compute_dh_matrix(0, -pi/2,  -d, theta3_1);

        A03 = A1*A2*A3;
        R03 = A03(1:3, 1:3);

        % Calculate R36.
        R36 = R03' * R;

        ctheta = R36(3,3);
        stheta_pos = sqrt(1-ctheta^2);
        stheta_neg = - sqrt(1-ctheta^2);
        theta5_1 = -atan2(stheta_pos, ctheta);
        theta4_1 = atan2(R36(2,3), R36(1,3));
        theta6_1 = atan2(R36(3,2), -R36(3,1));

        theta5_2 = -atan2(stheta_neg, ctheta);
        theta4_2 = atan2(-R36(2,3), -R36(1,3));
        theta6_2 = atan2(-R36(3,2), R36(3,1));

        if R36(2,3) ==0 && R36(1,3) == 0
            theta4_1 = 0;
            theta6_1 = 0;
            theta4_2 = pi;
            theta6_2 = pi;
        end

        %%% 2nd pair of solutions
        A1 = compute_dh_matrix(0,  pi/2,   a, theta1_1);
        A2 = compute_dh_matrix(c,     0,  -b, theta2_1);
        A3 = compute_dh_matrix(0, -pi/2,  -d, theta3_1);

        A03 = A1*A2*A3;
        R03 = A03(1:3, 1:3);

        % Calculate R36.
        R36 = R03' * R;

        ctheta = R36(3,3);
        stheta_pos = sqrt(1-ctheta^2);
        stheta_neg = - sqrt(1-ctheta^2);
        theta5_3 = -atan2(stheta_pos, ctheta);
        theta4_3 = atan2(R36(2,3), R36(1,3));
        theta6_3 = atan2(R36(3,2), -R36(3,1));

        theta5_4 = -atan2(stheta_neg, ctheta);
        theta4_4 = atan2(-R36(2,3), -R36(1,3));
        theta6_4 = atan2(-R36(3,2), R36(3,1));

        if R36(2,3) ==0 && R36(1,3) == 0
            theta4_3 = 0;
            theta6_3 = 0;
            theta4_4 = pi;
            theta6_4 = pi;
        end

        %%% 3rd pair of solutions
        A1 = compute_dh_matrix(0,  pi/2,   a, theta1_1);
        A2 = compute_dh_matrix(c,     0,  -b, theta2_1);
        A3 = compute_dh_matrix(0, -pi/2,  -d, theta3_1);

        A03 = A1*A2*A3;
        R03 = A03(1:3, 1:3);

        % Calculate R36.
        R36 = R03' * R;

        ctheta = R36(3,3);
        stheta_pos = sqrt(1-ctheta^2);
        stheta_neg = - sqrt(1-ctheta^2);
        theta5_5 = -atan2(stheta_pos, ctheta);
        theta4_5 = atan2(R36(2,3), R36(1,3));
        theta6_5 = atan2(R36(3,2), -R36(3,1));

        theta5_6 = -atan2(stheta_neg, ctheta);
        theta4_6 = atan2(-R36(2,3), -R36(1,3));
        theta6_6 = atan2(-R36(3,2), R36(3,1));

        if R36(2,3) ==0 && R36(1,3) == 0
            theta4_5 = 0;
            theta6_5 = 0;
            theta4_6 = pi;
            theta6_6 = pi;
        end

        %%% 4th pair of solutions
        A1 = compute_dh_matrix(0,  pi/2,   a, theta1_1);
        A2 = compute_dh_matrix(c,     0,  -b, theta2_1);
        A3 = compute_dh_matrix(0, -pi/2,  -d, theta3_1);

        A03 = A1*A2*A3;
        R03 = A03(1:3, 1:3);

        % Calculate R36.
        R36 = R03' * R;

        ctheta = R36(3,3);
        stheta_pos = sqrt(1-ctheta^2);
        stheta_neg = - sqrt(1-ctheta^2);
        theta5_7 = -atan2(stheta_pos, ctheta);
        theta4_7 = atan2(R36(2,3), R36(1,3));
        theta6_7 = atan2(R36(3,2), -R36(3,1));

        theta5_8 = -atan2(stheta_neg, ctheta);
        theta4_8 = atan2(-R36(2,3), -R36(1,3));
        theta6_8 = atan2(-R36(3,2), R36(3,1));

        if R36(2,3) ==0 && R36(1,3) == 0
            theta4_7 = 0;
            theta6_7 = 0;
            theta4_8 = pi;
            theta6_8 = pi;
        end
        % Put all the solutions of theta together
        if xc^2+yc^2-(b+d)^2 == 0 
            % Under singularity configurations, there are four solutions.
            th1 = [theta1_1 theta1_1 theta1_1 theta1_1 ];
            th2 = [theta2_1 theta2_2 theta2_1 theta2_2 ];
            th3 = [theta3_1 theta3_2 theta3_1 theta3_2 ];
            th4 = [theta4_1 theta4_3 theta4_2 theta4_4 ];
            th5 = [theta5_1 theta5_3 theta5_2 theta5_4 ];
            th6 = [theta6_1 theta6_3 theta6_2 theta6_4 ];
        else
            % Normal configurations, there are eight solutions.
            th1 = [theta1_1 theta1_1 theta1_2 theta1_2 theta1_1 theta1_1 theta1_2 theta1_2];
            th2 = [theta2_1 theta2_2 theta2_3 theta2_4 theta2_1 theta2_2 theta2_3 theta2_4];
            th3 = [theta3_1 theta3_2 theta3_3 theta3_4 theta3_1 theta3_2 theta3_3 theta3_4];
            th4 = [theta4_1 theta4_3 theta4_5 theta4_7 theta4_2 theta4_4 theta4_6 theta4_8];
            th5 = [theta5_1 theta5_3 theta5_5 theta5_7 theta5_2 theta5_4 theta5_6 theta5_8];
            th6 = [theta6_1 theta6_3 theta6_5 theta6_7 theta6_2 theta6_4 theta6_6 theta6_8];
        end
    end
end



ik_sol = [th1; th2; th3; th4; th5; th6];
 
end

function A = compute_dh_matrix(r, alpha, d, theta)

    %% Your code goes here
    A = eye(4);
    A=[cos(theta) -sin(theta).*cos(alpha) sin(theta).*sin(alpha) r.*cos(theta);
        sin(theta) cos(theta).*cos(alpha) -cos(theta).*sin(alpha) r.*sin(theta);
        0 sin(alpha) cos(alpha) d;
        0 0 0 1];
    
    
end