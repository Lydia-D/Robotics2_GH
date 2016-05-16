function [x,y,xd,yd,xdd,ydd] = IMUPose(t, ind, data,x,y,phi,xd,yd)

    xdd = data.imu(ind.imumax,6);
    ydd = data.imu(ind.imumax,7);
    
    % update approximations of ?position? and velocity + angular
    % acceleration??
    x.imu  = x.hat + xd.hat.*t.dt + 0.5*t.dt.^2*xdd*cos(phi.hat);
    y.imu  = y.hat + yd.hat.*t.dt + 0.5*t.dt.^2*ydd*sin(phi.hat);
    
    xd.imu = xd.hat + t.dt*xdd*cos(phi.hat);
    yd.imu = yd.hat + t.dt*ydd*sin(phi.hat);
    

end