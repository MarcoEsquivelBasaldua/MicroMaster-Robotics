syms d11 d12 d21 d22 c121 c211 c221 c112 g1 g2 tau1 tau2 x1 x2 x3 x4 real

xd1 = x2;
xd3 = x4;
xd4 = (d11*(tau2-c112*x2^2-g2)-d21*(tau1-c121*x2*x4-c211*x2*x4-c221*x4^2-g1))/(d22*d11-d12*d21);
xd2 = (tau2-d22*xd4-c112*x2^2-g2)/d21;
f_x_tau = [xd1;xd2;xd3;xd4];

