%% Test Linesplitting fn on sawtooth
% L Drabsch 8/4/16
close all
clear all
clc
load mydata

fig = figure(1);
scatter(mydata(:,1),mydata(:,2));
Lines = LineSplit(mydata,0.1,2);

% plotlines(Lines,Data,fig);
