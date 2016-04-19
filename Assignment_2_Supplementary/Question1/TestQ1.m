%% Test Linesplitting fn on sawtooth
% L Drabsch 8/4/16
close all
clear all
clc
% load mydata
load myblocks
% mydata = sortrows(mydata, 1);
% mydata = mydata(9:end,:);
fig = figure(1);
scatter(mydata(:,1),mydata(:,2));
axis equal
[Lines,IndexDomain] = LineSplit(mydata,0.2,2);
Corner = findcorner(Lines, IndexDomain, mydata);
% identify corners
