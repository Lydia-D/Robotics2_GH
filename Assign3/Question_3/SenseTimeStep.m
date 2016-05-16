% Given the current indicies, find the next sensor data point to come in,
% and return the new global time


function [t, ind, sensor] =  SenseTimeStep(t, ind)
%% Find the timestep change from individual sensors.
% This models data coming in from sensors at different times.
dtvec(1) = t.gps(ind.gps, 1) - t.global(end);
% dtvec(1) = inf;
dtvec(2) = t.com(ind.com, 1) - t.global(end);
% dtvec(2) = inf;
dtvec(3) = t.las(ind.las, 1) - t.global(end);
% dtvec(3) = inf; % ignore laser data for now
dtvec(4) = t.vel(ind.vel, 1) - t.global(end);
% dtvec(5) = t.imu(ind.imu,1) - t.global(end);
dtvec(5) = inf;

    %% Step the global time forward according to the smallest sensor change
%     [t.dtglobal, sensor] = min(dtvec);
    [dt, sensor] = min(dtvec);
    t.global(end+1) = t.global(end)+dt;
    %% Only step the minimum timestep sensor indice forward
    switch sensor
        case 1  % GPS DATA
            ind.gps = ind.gps + 1;
            t.dt = t.global(end)-t.prevpos;
            t.prevpos = t.global(end);

            if ind.gps >= ind.gpsmax
                ind.done = 1;
            end
        case 2  %compass
            ind.com = ind.com + 1;
%             t.dt = dt;   % dont update dt as it is used for integration 

            if ind.com >= ind.commax
                ind.done = 1;
            end
        case 3 % laser
            ind.las = ind.las + 1;
            
        if ind.las >= ind.lasmax
            ind.done = 1;
        end
        case 4 % vel
            ind.vel = ind.vel + 1;
            t.dt = t.global(end)-t.prevpos;
            t.prevpos = t.global(end);
            if ind.vel>=ind.velmax
                ind.done = 1;    % what do these do? 
            end
            
            
            
        case 5 % IMU
            ind.imu = ind.imu + 1;
            t.dt = t.global(end)-t.prevpos;
            t.prevpos = t.global(end);
            if ind.imu >= ind.imumax
                ind.done = 1;
            end
    end

end

