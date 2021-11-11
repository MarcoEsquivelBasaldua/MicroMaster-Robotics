tspan = [0, 5];
P0 = 10;
abstol=1e-4; 
reltol=1e-3; 
maxstep=1e-3;
options=odeset('RelTol',reltol,'MaxStep',maxstep,'AbsTol',abstol);
[T,P]=ode23s(@populationGrowth,tspan,P0,options);
t0 = T(1)
tfinal = T(end)
p0 = P(1)
pfinal = P(end)
plot(T,P)
%Copy lines 1-4 from the previous problem here:
function Pdot = populationGrowth(t,P)
    r = 1;
    k = 200;
    Pdot = r*P*(1-P/k);
end
%

