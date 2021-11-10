syms t real
A = [0 1 0;0 0 1;-6 -11 -6];
x0 = [1 2 -1]';

x_t = expm(t*A)*x0

%% this solution also works
[P lam] = eig(A)
x_t = P*expm(t*lam)*inv(P)*x0
%x_t = P*expm(t*lam)*inv(P)
