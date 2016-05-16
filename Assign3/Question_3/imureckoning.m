function [X,Y] = imureckoning(x,y,phi,data,t)

X = x.hat;
Y = y.hat;
Phi = phi.hat;
yd = 0;
xd = 0;
for a = 2:length(t.vel)
    dt = (t.imu(a)-t.imu(a-1));

    Phi = atan2(yd(a-1),xd(a-1));

    xd = [xd;xd(a-1) + dt*data.imu(a,6)*cos(Phi)];
    yd = [yd;yd(a-1) + dt*data.imu(a,7)*sin(Phi)];

    X  = [X; X(a-1)+ xd(a)*cos(Phi) .* dt + 0.5*dt.^2.*data.imu(a,6)*cos(Phi)];
    Y  = [Y; Y(a-1) + yd(a)*sin(Phi).*dt + 0.5*dt.^2.*data.imu(a,7)*sin(Phi)];
    

    
end

end