function sys = brachiatingDynamics(t,yi,m_1,m_2,l_c1,l_c2,l_1,l_2,I_1,I_2,g)
%BRACHIATINGDYNAMICS This function contains the EOM for a two-link
%brachiating robot
%   Detailed explanation goes here
theta_1 = yi(1);     theta_2 = yi(2);  %Positions
theta_d1 = yi(3); theta_d2=yi(4); %Velocities

tau = controlHO(yi);

k1 = g*(l_c1*(m_1+m_2)*sin(theta_1) + l_c2*m_2*sin(theta_1 + theta_2));
k2 = g*l_c2*m_2*sin(theta_1+theta_2);
bq1 = l_c1*l_c2*m_2*sin(theta_2)*(-2*theta_d1 - theta_d2)*theta_d2;
bq2 = l_c1*l_c2*m_2*sin(theta_2)*theta_d1^2;
u = [0;tau];
K = [k1;k2];
Bq = [bq1;bq2];

M11 = I_1+I_2+l_1^2*m_2+2*l_1*l_c2*m_2*cos(theta_2)+l_c1^2*m_1+l_c2^2*m_2;
M12 = I_2+l_1*l_c2*m_2*cos(theta_2)+l_c2^2*m_2;
M21 = I_2+l_c2^2*m_2+l_1*l_c2*m_2*cos(theta_2);
M22 = I_2+l_c2^2*m_2;
M = [M11 M12 ; M21 M22];
Minv = 1/(M11*M22 - M12*M21).*[M22 -M12;-M21 M11];
theta_dd = Minv*[-k1-bq1;-k2-bq2+tau]


theta1_ddot = theta_dd(1);
theta2_ddot = theta_dd(2);




%Updates
sys(1) = theta_d1;
sys(2) = theta_d2;
sys(3) = theta1_ddot;
sys(4) = theta2_ddot;

sys = sys';
end

