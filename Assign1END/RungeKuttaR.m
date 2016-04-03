%% L.Drabsch 16/3/16
% Runge-Kutta Integration


function Xknext = RungeKuttaR(funstring,x0,Xk,dt,A)
    fn = str2func(funstring);
    
%     dXdot = A*(xt-x0(1:4));
%     Xdotstar = A*x0(1:4)

    k1 = dt.*fn(x0,Xk,A);
    k2 = dt.*fn(x0,Xk+k1./2,A);
    k3 = dt.*fn(x0,Xk+k2./2,A);
    k4 = dt.*fn(x0,Xk+k3,A);
    
    Xknext = Xk + 1/6.*(k1 + 2.*k2 + 2.*k3 + k4);
end