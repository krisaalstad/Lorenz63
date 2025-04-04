function [s,t]=Lorenz63(ts,s0,p)
% Solve over time interval [0,100] with initial conditions [1,1,1]
% ''f'' is set of differential equations
% ''a'' is array containing x, y, and z variables
% ''t'' is time variable

%ts=[0 100];
%s0=[1 1 1];
sigma = p.sigma;%10;
beta = p.beta;%8/3;
rho = p.rho;%28;
f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
[t,a] = ode45(f,ts,s0);     % Runge-Kutta 4th/5th order ODE solver
%plot3(a(:,1),a(:,2),a(:,3))
s=a;
end