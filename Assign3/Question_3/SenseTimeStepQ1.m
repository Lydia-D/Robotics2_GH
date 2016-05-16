function [global_t, gps_ind, comp_ind, las_ind, sensor, dt] =  ...
    SenseTimeStepQ1(global_t, gps_ind, comp_ind, las_ind, ...
    gpsObs, compObs, lasObs)
% Given the current indicies, find the next sensor data point to come in,
% and return the new global time


%% Find the timestep change from individual sensors.
% This models data coming in from sensors at different times.
gps_dt = gpsObs(gps_ind, 1) + gpsObs(gps_ind, 2)/1000000 - global_t;
comp_dt = compObs(comp_ind, 1) + compObs(comp_ind, 2)/1000000 - global_t;
las_dt = lasObs(las_ind, 1) + lasObs(las_ind, 2)/1000000 - global_t;
% vel_dt = velObs(vel_ind, 1) + velObs(vel_ind,2)/1000000 - global_t;

while 1
    %% Step the global time forward according to the smallest sensor change
    [dt, sensor] = min([gps_dt, comp_dt, las_dt]);
    global_t = global_t + dt;
    
    %% Only step the minimum timestep sensor indice forward
    if sensor == 1
        if gps_ind<length(gpsObs)
            gps_ind = gps_ind + 1;
            break
        else
            gps_dt = inf;
        end
    elseif sensor == 2
        if comp_ind<length(compObs)
            comp_ind = comp_ind + 1;
            break
        else
            comp_dt = inf;
        end
    elseif sensor == 3
        if las_ind<length(lasObs)
            las_ind = las_ind + 1;
            break
        else
            las_dt = inf;
        end
    else
%         if vel_ind<length(velObs)
%             vel_ind = vel_ind + 1;
%             break
%         else
%             vel_dt = inf;
%         end
    end
end
end

