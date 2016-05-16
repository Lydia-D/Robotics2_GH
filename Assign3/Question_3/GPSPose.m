function [x, y] = GPSPose(ind, data,x,y,alpha)
%Output pose from GPS data

x.gps = data.gps(ind.gps, 3);
y.gps = data.gps(ind.gps, 4);

x.hat = (1-alpha.gps)*x.hat+alpha.gps*x.gps;
y.hat = (1-alpha.gps)*y.hat+alpha.gps*y.gps;

end

