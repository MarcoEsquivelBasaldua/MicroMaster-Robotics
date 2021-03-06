% rand(3,1) generates a random 3 by one column vector. We use this u to plot
u=rand(3,1)*2-1;

% plot the origin
plot3(0,0,0,'.k')

% axis setting
axis vis3d
axis off

%%%%% your code starts here %%%%%
% generate a random rotation matrix R
    omega=rand(3,1);
    hatOhm=(1/sqrt(omega(1)^2+omega(2)^2+omega(3)^2)).*omega;
    theta=sqrt(omega(1)^2+omega(2)^2+omega(3)^2);
    u0=cos(theta/2);
    u1=sin(theta/2).*hatOhm;
    J_u1=[0 -u1(3) u1(2);u1(3) 0 -u1(1);-u1(2) u1(1) 0];
    I=[1 0 0;0 1 0;0 0 1];
    R=(u0^2-u1'*u1).*I+2.*u0*J_u1+2.*(u1*u1');


% plot the x axis 
plot3([0,1],[0,0],[0,0],'r');
text(1,0,0,'x')

% plot the y axis 
plot3([0,0],[0,1],[0,0],'g');
text(0,1,0,'y')

% plot the z axis 
plot3([0,0],[0,0],[0,1],'b');
text(0,0,1,'z')

% plot the original vector u
plot3([0,u(1)],[0,u(2)],[0,u(3)],'k--');
hold on;
text(u(1,1),u(2,1),u(3,1),['(',num2str(u(1),'%.3f'),',',num2str(u(2),'%.3f'),',',num2str(u(3),'%.3f'),')'])

% apply rotation and calcuate v plot the vector after rotation v
v=R*u;

% plot the new vector v
plot3([0,v(1)],[0,v(2)],[0,v(3)],'k:');
text(v(1),v(2),v(3),['(',num2str(v(1),'%.3f'),',',num2str(v(2),'%.3f'),',',num2str(v(3),'%.3f'),')'])

%%%%% your code ends here %%%%%
