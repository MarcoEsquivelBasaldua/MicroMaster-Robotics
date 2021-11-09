syms m r h a b
%{
Ix = 3*m*(r^2/4+h^2)/5;
Iy = Ix;
Iz = 3*m*r^2/10;
Ip = [Ix 0 0;0 Iy 0;0 0 Iz];
%}

Idiff = sym(zeros(3));
Idiff(1,1) = m*b^2;
Idiff(2,2) = m*a^2;
Idiff(3,3) = m*(a^2+b^2);

Idiff(1,2) = -m*(a*b);
Idiff(2,1) = Idiff(1,2);%-m*(a*b);
%
Idiff(1,3) = -m*a*3*h/4;
Idiff(3,1) = Idiff(1,3);%-m*a*3*h/4;

Idiff(2,3) = -m*b*3*h/4;
Idiff(3,2) = Idiff(2,3);%-m*b*3*h/4;
%
Idiff

