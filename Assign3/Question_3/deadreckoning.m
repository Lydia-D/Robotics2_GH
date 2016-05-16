function [X,Y] = deadreckoning(x,y,phi,data,t)

X = x.hat;
Y = y.hat;
Phi = phi.hat;
for a = 2:length(t.vel)
    dt = (t.vel(a)-t.vel(a-1));

    Phi = [Phi; Phi(a-1) + dt*data.vel(a,4)];

%     X  = [X; X(a-1)+ data.vel(a,3)*cos(Phi(a-1)+dt*data.vel(a,4)) .* dt];% + 0.5*dt.^2.*data.dead(:,5)*cos(phi)];
%     Y  = [Y; Y(a-1) + data.vel(a,4)*sin(Phi(a-1)+dt*data.vel(a,4)).*dt];% + 0.5*dt.^2.*data.dead(:,6)*sin(phi)];
%     

    X  = [X; X(a-1)+ data.vel(a,3)*cos(Phi(a-1)).*dt];% + 0.5*dt.^2.*data.dead(:,5)*cos(phi)];
    Y  = [Y; Y(a-1) + data.vel(a,3)*sin(Phi(a-1)).*dt];% + 0.5*dt.^2.*data.dead(:,6)*sin(phi)];
    

%     xd = [xd;xd(a-1) + dt*data.dead(:,5)*cos(phi)];
%     yd = [yd;yd(a-1) + dt*data.dead(:,6)*cos(phi)];
    
end

end