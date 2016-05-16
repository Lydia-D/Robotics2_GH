%% extract data from laser obs
% L Drabsch
% 23/4/16


function [timenow,Range]=dataObs(increment)

    global width
    global startrow
    
    Datanow = dlmread('laserObs.txt',' ',[startrow+increment 0 startrow+increment width-1]); % from 0 not 1
    timenow = Datanow(1) + Datanow(2)*10^-6;
    
    % matlab convention, every second data to second last data
    Range = Datanow(3:2:width-1);   
    
end