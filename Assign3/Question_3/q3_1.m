clc; close all; clear all;

%% Load Data
velObs = load('velocityObs.txt');
gpsObs = load('positionObs.txt');
compObs = load('compassObs.txt');
lasObs = load('laserObs.txt');
lasFeats = load('laserFeatures.txt');
lasPure = lasObs(:, 3:2:length(lasObs(1,:))).* ...
    (lasObs(:, 3:2:length(lasObs(1,:)))<8);
lasMarkers = lasObs(:, 4:2:length(lasObs(1,:)));

%% Fusion values
alpha_P = 0.25;
alpha_Phi = 0.25;

%% Variable initialisation
X_v = [];
Y_v = [];
Phi_v = [];
X_fus = [];
Y_fus = [];
Phi_fus = [];
X_las = [];
Y_las = [];
Phi_las = [];
X_gps = [];
Y_gps = [];
Phi_comp = [];
X_dead = [];
Y_dead = [];
Phi_dead = [];
mu = 1/1000000;
updatePeriod = 1;


%% Time initialisation
t0s = [gpsObs(1,1) + gpsObs(1,2)*mu, compObs(1,1) + compObs(1,2)*mu, ...
lasObs(1,1) + lasObs(1,2)*mu, velObs(1,1) + velObs(1,2)*mu];
[T0, T0ind] = min(t0s);
global_t = T0;
tCounter = 0;

%% Sensor initialisation
gps_ind = 1;
comp_ind = 1;
las_ind = 1;
vel_ind = 1;

%% Initial position and orientation estimates
X_Obs = gpsObs(gps_ind, 3);
Y_Obs = gpsObs(gps_ind, 4);
Phi_Obs = compObs(comp_ind, 3);

X_gps = [X_gps; X_Obs];
Y_gps = [Y_gps; Y_Obs];
Phi_comp = [Phi_comp; Phi_Obs];

%% Dead reckoning Estimates
X_Dead = 0; lastX = X_Dead;
Y_Dead = 0; lastY = Y_Dead;
Phi_Dead = 0; lastPhi = Phi_Dead;
lastt = global_t;

%% Data Fusion Step
[X_hat, Y_hat, Phi_hat] = Fusion(alpha_P, alpha_Phi, X_Dead, X_Obs, ...
    Y_Dead, Y_Obs, Phi_Dead, Phi_Obs);

X_fus = [X_fus; X_hat];
Y_fus = [Y_fus; Y_hat];
Phi_fus = [Phi_fus; Phi_hat];

%% March indicies forward
gps_ind = gps_ind + 1;
comp_ind = comp_ind + 1;
vel_ind = vel_ind + 1;

while 1
    %% Get the sensor which provides the newest data and the new time
    [global_t, gps_ind, comp_ind, las_ind, vel_ind, sensor, dt] = ...
        SenseTimeStep(global_t, gps_ind, comp_ind, las_ind, vel_ind, ...
        gpsObs, compObs, lasObs, velObs);
    ts = global_t - T0;
    
    tCounter = tCounter + dt;
    
    %% If all data has been read, end.
    if gps_ind>=length(gpsObs) && comp_ind>=length(compObs) && ...
            las_ind>=length(lasObs) && vel_ind>=length(velObs)
        break
    end
    
    %% Collect sensor data based on time-stamp
    if sensor == 1
        [x_gps, y_gps] = GPSPose(gps_ind,  gpsObs);
        X_Obs = x_gps;
        Y_Obs = y_gps;
        X_gps = [X_gps; x_gps];
        Y_gps = [Y_gps; y_gps];
        
    elseif sensor == 2
        [phi_comp] = CompPose(comp_ind, compObs);
        Phi_Obs = phi_comp;
        Phi_comp = [Phi_comp; phi_comp];
        
    elseif sensor == 3
        [x_las, y_las, phi_las] = LasPose(las_ind, X_Obs, Y_Obs, ...
            Phi_Obs, lasPure, lasMarkers, lasFeats);
        
        if (x_las | y_las | phi_las)
            X_Obs = x_las;
            Y_Obs = y_las;
            Phi_Obs = phi_las;
            
            X_las = [X_las; x_las];
            Y_las = [Y_las; y_las];
            Phi_las = [Phi_las; phi_las];
        end
        
    else
        delT = global_t - lastt;
        [x_Dead, y_Dead, phi_Dead] = DeadPose(vel_ind, lastX, lastY, ...
            lastPhi, velObs, delT);
        %         [x_Dead, y_Dead, phi_Dead] = DeadPose(vel_ind, X_hat, Y_hat, ...
        %             Phi_hat, velObs, dt);
        lastX = x_Dead;
        lastY = y_Dead;
        lastPhi = phi_Dead;
        lastt = global_t;
        
        X_dead = [X_dead; x_Dead];
        Y_dead = [Y_dead; y_Dead];
        Phi_dead = [Phi_dead; phi_Dead];
        
    end
    
    %% Data Fusion Step
    if tCounter > updatePeriod
        [X_hat, Y_hat, Phi_hat] = Fusion(alpha_P, alpha_Phi, x_Dead, X_Obs, ...
            y_Dead, Y_Obs, phi_Dead, Phi_Obs);
        tCounter = 0;
        X_Obs = X_hat;
        Y_Obs = Y_hat;
        Phi_Obs = Phi_hat;

        lastX = X_hat;
        lastY = Y_hat;
        lastPhi = Phi_hat;
        %lastt = global_t;
    end
    
    X_fus = [X_fus; X_hat];
    Y_fus = [Y_fus; Y_hat];
    Phi_fus = [Phi_fus; Phi_hat];
    
end
%%
figure
hold on
plot(X_gps, Y_gps, 'b.');
plot(X_las, Y_las, 'm.');
plot(X_dead, Y_dead, 'r.');
plot(X_fus, Y_fus, 'k-', 'LineWidth', 1.3);
axis equal
legend('GPS Path', 'Laser Path', 'Dead Reckoning', 'Final Path', 'Location', 'EastOutside');
title('Robot Path and Fusion')
