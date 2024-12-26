function [ tau ] = controlHO( yi )
%CONTROLHO Controller to force brachiating robot to be a harmonic
%oscillator
%   Detailed explanation goes here
m_1 = 3.499;
m_2 = 1.232;
l_c1 = 0.141;
l_c2 = 0.333;
l_1 = 0.5;
l_2 = 0.5;
g = 9.8;
I_1 = 0.090;
I_2 = 0.033;

theta_1 = yi(1);
theta_2 = yi(2);
theta_d1 = yi(3);
theta_d2 = yi(4);

theta = yi(1)+.5*yi(2);
omega = 3.35;
%Copy in the controller you made here:
k1 = g*((l_c1*m_1+l_1*m_2)*sin(theta_1) + l_c2*m_2*sin(theta_1 + theta_2));
k2 = g*l_c2*m_2*sin(theta_1+theta_2);
bq1 = l_1*l_c2*m_2*sin(theta_2)*(-2*theta_d1 - theta_d2)*theta_d2;
bq2 = l_1*l_c2*m_2*sin(theta_2)*theta_d1^2;
%u = [0;tau];
K = [k1;k2];
Bq = [bq1;bq2];

M11 = I_1+I_2+l_1^2*m_2+2*l_1*l_c2*m_2*cos(theta_2)+l_c1^2*m_1+l_c2^2*m_2;
M12 = I_2+l_1*l_c2*m_2*cos(theta_2)+l_c2^2*m_2;
M21 = I_2+l_c2^2*m_2+l_1*l_c2*m_2*cos(theta_2);
M22 = I_2+l_c2^2*m_2;
M = [M11 M12 ; M21 M22];
Minv = 1/(M11*M22 - M12*M21).*[M22 -M12;-M21 M11];
n1 = Minv(1,1)+0.5*Minv(2,1);
n2 = Minv(1,2)+0.5*Minv(2,2);
tau = 1/n2*(-omega^2*theta+n1*(bq1+k1))+bq2+k2

end

