%% By Lydia Drabsch 
% 8/3/2016
% Experimental Robotics MTRX5700 
% Assignment 1 Q1
clear

yaw = @(gamma) rot('z',gamma);
pitch = @(beta) rot('y',beta);
roll = @(alpha) rot('x',alpha);

%% Part a
R.a = roll(deg2rad(10))*pitch(deg2rad(20))*yaw(deg2rad(30))
P.a = [1,2,3]';
T.a = [R.a,P.a;zeros(1,3),1]

%% Part B
R.b = roll(deg2rad(10))*pitch(deg2rad(30))*yaw(deg2rad(30))
P.b = [3,0,0]';
T.b = [R.b,P.b;zeros(1,3),1]

%% Part C.1
R.c1 = roll(deg2rad(90))*pitch(deg2rad(180))*yaw(deg2rad(-90))
P.c1 = [0,0,1]';
T.c1 = [R.c1,P.c1;zeros(1,3),1]
%% Part C.2
R.c2 = roll(deg2rad(90))*pitch(deg2rad(180))*yaw(deg2rad(270))
P.c2 = [0,0,1]';
T.c2 = [R.c1,P.c2;zeros(1,3),1]