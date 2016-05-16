function [x, y, phi,xd,yd] = Fusion(alpha,ind, x, y, phi,xd,yd)
% Given the dead reckoning and observed pose, fuse the data to provide an
% estimate of true pose

%make sure phi_obs and phi_dead are not wrapped around from each other
[phi.com, phi.dead] = fixPhiValues(phi.com, phi.dead);
% if ind.vel == 1 && ind.imu ~= 1
%     x.hat = alpha.gps*x.gps + (1-alpha.gps)*x.imu;
%     y.hat = alpha.gps*y.gps + (1-alpha.gps)*y.imu;
%     phi.hat = phi.com;
% elseif ind.imu == 1
%     x.hat = x.gps;
%     y.hat = y.gps;
%     phi.hat = phi.com;
% else
    
    
%     x.hat = (1-alpha.gps-alpha.imu)*x.dead + alpha.gps*x.gps + alpha.imu*x.imu;
%     y.hat = (1-alpha.gps-alpha.imu)*y.dead + alpha.gps*y.gps + alpha.imu*y.imu;
%     phi.hat = (1-alpha.Phi)*phi.dead + alpha.Phi*phi.com; 
% 
%     xd.hat = (1-alpha.V).*xd.dead + alpha.V*xd.imu;
%     yd.hat = (1-alpha.V).*yd.dead + alpha.V*yd.imu;

    x.hat = x.dead;
    y.hat = y.dead;
    phi.hat = phi.dead;
    
    xd.hat = xd.dead;
    yd.hat = yd.dead;

% end
end

