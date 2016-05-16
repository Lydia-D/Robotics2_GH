%% Assignment 3 Question 2 - Occupancy Grod Mapping
% L Drabsch 22/4/16

% 1) data extraction - known -90 to 90 in half degree increments
%       - dlmread where the first element is 0
%       - width of data 724 (0-723)
%       - data starts at line 9
%       - time(s) time(mu s) range intensity
%       - if range = 8.0 (max) replace with NaN?
%       - extract the data line by line to conserve memory and simulate
%               realtime
% 2) create grid - get size and required resolution from data?
% 3) retrive position and orientation in global frame (Question 1)
% 4) 
% ?) how to visualise the data? binary image? GUI?
clc
clear
close all
global width
global startrow
%% 
startrow = 8; % increment through data from 1 (line 9)
degree = -90:0.5:90;
width = length(degree)*2+2;

t = 1;
while 1

    [timenow,Range] = dataObs(t); % extract data for this point in time
    Range(Range==8) = NaN;
    % Get global position for this point in time [x;y]
    Pos_global = ?;
    
    % Get heading for this point in time (angle between x axes) 
    Heading = ?; % degrees
    
    % [x ; y] corrdinates in theta reference frame
    Obs_local = [Range.*cos(Heading + degree);Range.*sin(Heading+degree)];
    Obs_global = Pos_global*ones(1,size(degree,2)) + Obs_local;
    
    
    
end


