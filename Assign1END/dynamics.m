% x0 linearised point
function Xdot = dynamics(x0,xt,A)
    dXdot = A*(xt-x0(1:4));
    Xdotstar = A*x0(1:4);


    Xdot = dXdot+Xdotstar;
end