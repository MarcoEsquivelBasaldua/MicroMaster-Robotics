function [ q_int ] = quat_slerp( q0, q1, steps )
%QUAT_SLERP Perform SLERP between two quaternions and return the intermediate quaternions
%   Usage: [ q_int ] = quat_slerp( q0, q1, steps )
%   Inputs:
%       q0 is the quaternion representing the starting orientation, 1x4 matrix
%       q1 is the quaternion representing the final orientation, 1x4 matrix
%       steps is the number of intermediate quaternions required to be returned, integer value
%       The first step is q0, and the last step is q1
%   Output:
%       q_int contains q0, steps-2 intermediate quaternions, q1
%       q_int is a (steps x 4) matrix

    %% Your code goes here
    q_int = zeros(steps, 4);
    dot_q0q1=dot(q0,q1);
    
    omega=acos(dot_q0q1);
    theta=2.*omega;
    
    if theta>pi
        q1=-q1;
        omega=(2*pi-theta)./2;
    end
    
    for n=0:steps-1
        t=n/(steps-1);
        q=(sin((1-t).*omega)./sin(omega)).*q0+(sin(t.*omega)./sin(omega)).*q1;
        q_int(n+1,1)=q(1);
        q_int(n+1,2)=q(2);
        q_int(n+1,3)=q(3);
        q_int(n+1,4)=q(4);
    end
end
