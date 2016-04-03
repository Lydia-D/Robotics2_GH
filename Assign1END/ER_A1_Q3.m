%% By Lydia Drabsch 
% 11/3/2016
% Experimental Robotics MTRX5700 
% Assignment 1 Question 3 - DH epson robot
clc
clear
%% DH parameters for Epson robot

links = [196.5,pi/2,0,0;...
        320-196.5,theta1+pi,-100,-pi/2;...
        0,theta2-pi/2,250,0;...
        0,theta3-pi/2,0,pi/2;...
        -250,theta4,0,pi/2;...
        0,0,0,pi/2];
    
    
%% transformations
% DHmod = 
createT(90,0,0,[5,0,0]')


