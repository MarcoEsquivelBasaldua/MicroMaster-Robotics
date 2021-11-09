syms m h r

Ix = 3*m*(r^2/4+h^2)/5;
Iy = Ix;
Iz = 3*m*r^2/10;
Ip(m, h, r) = [Ix 0 0;0 Iy 0;0 0 Iz];
