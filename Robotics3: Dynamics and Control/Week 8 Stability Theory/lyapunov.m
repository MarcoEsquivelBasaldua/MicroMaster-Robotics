syms x1 x2 real
f_x = [-x1^3+x2;-x1];

V = f_x'*f_x;% your Lyapunov function candidate

Vdot = [diff(V,x1) diff(V,x2)]*f_x;% Lyapunov's direct method using your V
