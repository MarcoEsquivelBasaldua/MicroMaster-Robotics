syms a1 d1 d2 q1 q2

% provide your answer in terms of the symbolic variables above

R01 = [cos(q1) 0 -sin(q1);sin(q1) 0 cos(q1);0 -1 0];

R12 = [cos(q2) 0 -sin(q2);sin(q2) 0 cos(q2);0 -1 0];
%R12 = [cos(q2-pi/2) 0 -sin(q2-pi/2);sin(q2-pi/2) 0 cos(q2-pi/2);0 -1 0];

R02 = R01*R12;
