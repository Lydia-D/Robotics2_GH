function [x,y,phi,xd,yd] = DeadPose(t,data,ind,x,y,phi,xd,yd)
% dt is time since last velocity information

% Given the best guess of position and rotation, return the dead reckoning
% pose of the robot


    % previous 
    x.dead = x.hat + t.dt*data.vel(ind.vel-1, 3)*cos(phi.hat);% + 0.5*xdd*cos(phi.hat)*t.dt^2;  % using IMU acceleration
    y.dead = y.hat + t.dt*data.vel(ind.vel-1, 3)*sin(phi.hat);% + 0.5*ydd*sin(phi.hat)*t.dt^2;
    


%     xd.dead = data.vel(ind.vel, 3)*cos(phi.hat); %+ t.dt*xdd*cos(phi.hat);
%     yd.dead = data.vel(ind.vel, 3)*sin(phi.hat); % + t.dt*ydd*sin(phi.hat);

    % dont mix the data at this stage? old angle
    [phi.hat, phi.dead] = fixPhiValues(phi.hat, phi.dead);

    phi.dead = phi.hat + t.dt*data.vel(ind.vel-1, 4);


end