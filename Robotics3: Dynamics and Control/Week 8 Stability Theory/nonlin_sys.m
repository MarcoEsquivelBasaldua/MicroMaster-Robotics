syms p a B real % p = rho, a = alpha, b = beta 
syms k_p k_a k_b real
x = [p;a;B];
f_x = [-cos(a) 0;sin(a)/p -1;-sin(a)/p 0]*[k_p 0 0;0 k_a k_b]*[p;a;B]

A = [diff(f_x,p) diff(f_x,a) diff(f_x, B)]
A = [-k_p 0 0;0 k_p-k_a -k_b;0 -k_p 0]; % linearized system

%k_p = 4;
%k_a = 8;
%k_b = 0.1;

%K = [k_p k_a k_b];
e_values = real(eig(A)')

K = [4.9 9 -0.7];

%K = eig(A)';% stable gains [k_p k_a k_b];
