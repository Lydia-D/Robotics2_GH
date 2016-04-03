%% By Lydia Drabsch 
% 8/3/2016
% Experimental Robotics MTRX5700 
% Assignment 1 Question 2
clear
clc

R1.mat = [  0.7500,-0.4330,-0.5000;...
        0.2165,0.8750,-0.4330;...
        0.6250,0.2165,0.7500];
R2.mat = [  0.7725,-0.4460,-0.5150;...
        0.2165,0.8750,-0.4330;...
        0.6000,0.2078,0.7200];
R3.mat = [  0,     0,     1;...
        0.8660,0.5000,0;...
        -0.5000,0.8660,0];
R4.mat = [  -0.7500,-0.2165,-0.6250;...
        0.4330,-0.8750,-0.2165;...
        0.5000,0.4330,-0.7500];
%% Part A
IsInvalid = [max(max(abs(inv(R1.mat)-R1.mat')))>10^(-3);...
max(max(abs(inv(R2.mat)-R2.mat')))>10^(-3);...  % invaliad by ~10%
max(max(abs(inv(R3.mat)-R3.mat')))>10^(-3);...
max(max(abs(inv(R4.mat)-R4.mat')))>10^(-3)]
    
% Det = [det(R1.mat);det(R2.mat);det(R3.mat);det(R4.mat)]

%% Part B

gamma = @(Rx) atan2(Rx(2,1),Rx(1,1));   % about z yaw
beta = @(Rx) atan2(-Rx(3,1),sqrt(Rx(3,2)^2+Rx(3,3)^2));  % about y pitch
alpha = @(Rx) atan2(Rx(3,2),Rx(3,3));  % about x roll

N4.mat = -R4.mat;
name = ['R1';'R2';'R3';'R4';'N4'];
for i = 1:5
    eval([name(i,:) '.det = det(' name(i,:) '.mat);']);
    eval([name(i,:) '.alpha = rad2deg(alpha(' name(i,:) '.mat));']);
    eval([name(i,:) '.beta = rad2deg(beta(' name(i,:) '.mat));']);
    eval([name(i,:) '.gamma = rad2deg(gamma(' name(i,:) '.mat))']);
end