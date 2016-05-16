clc; close all; clear all;

%% Load Data
gpsObs = load('positionObs.txt');
compObs = load('compassObs.txt');
lasObs = load('laserObs.txt');
lasFeats = load('laserFeatures.txt');
lasPure = lasObs(:, 3:2:length(lasObs(1,:))).* ...
    (lasObs(:, 3:2:length(lasObs(1,:)))<8);
lasMarkers = lasObs(:, 4:2:length(lasObs(1,:)));

%% Variable initialisation
X_v = [];
Y_v = [];
Phi_v = [];

%% Time initialisation
t0s = [gpsObs(1,1) + gpsObs(1,2)/1000000, compObs(1,1) + ...
    compObs(1,2)/1000000, lasObs(1,1) + lasObs(1,2)/1000000];
[T0, T0ind] = min(t0s);
global_t = T0;

%% Sensor initialisation
gps_ind = 1;
comp_ind = 1;
las_ind = 1;

%% Initial position and orientation estimates
X_hat = gpsObs(gps_ind, 3);
Y_hat = gpsObs(gps_ind, 4);
Phi_hat = compObs(comp_ind, 3);

gps_ind = gps_ind + 1;
comp_ind = comp_ind + 1;

while 1
    %% Get the sensor which provides the newest data and the new time
    [global_t, gps_ind, comp_ind, las_ind, sensor] = ...
        SenseTimeStep(global_t, gps_ind, comp_ind, las_ind, vel_ind...
        ,gpsObs, compObs, lasObs, velObs);
    ts = global_t - T0;
    
    %% If all data has been read, end.
    if gps_ind>=length(gpsObs) && comp_ind>=length(compObs) && ...
            las_ind>=length(lasObs)
        break
    end
    
    %% Collect sensor data based on time-stamp
    if sensor == 1
        [X_gps, Y_gps] = GPSPose(gps_ind,  gpsObs);
        X_hat = X_gps;
        Y_hat = Y_gps;
    elseif sensor == 2
        [Phi_comp] = CompPose(comp_ind, compObs);
        Phi_hat = Phi_comp;
    else
        [X_las, Y_las, Phi_las] = LasPose(las_ind, X_hat, Y_hat, ...
            Phi_hat, lasPure, lasMarkers, lasFeats);
    end
    
    drawnow
    hold on
    line_x=linspace(X_hat, X_hat+0.5*cos(Phi_hat),7);
    line_y=linspace(Y_hat, Y_hat+0.5*sin(Phi_hat),7);
    plot(line_x, line_y, 'g.');
    plot(X_hat, Y_hat,'bo')
    line_x=linspace(X_las, X_las+0.5*cos(Phi_las),7);
    line_y=linspace(Y_las, Y_las+0.5*sin(Phi_las),7);
    plot(line_x, line_y, 'r.');
    plot(X_las, Y_las, 'ko')
    title(sprintf('Robot POSE: X %.1f Y %.1f PHI %.1f Time: %.1f', ...
        X_hat, Y_hat, Phi_hat*180/pi, ts))
    
end