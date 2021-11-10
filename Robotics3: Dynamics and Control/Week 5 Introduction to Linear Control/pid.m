% your PID parameters
%{
w_n > 0.8
%}
w_n = 1.7;
J = 10;
B = 5;

Kp = w_n^2*J
Kd = (2*w_n*J-B)
Ki = 0.4%((B + Kd)*Kp)/J-10

G = tf([Kp Ki],[J B+Kd Kp Ki]);

step(200*G)

