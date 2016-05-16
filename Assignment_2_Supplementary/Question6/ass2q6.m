function ass2q6()

clear all;
close all;
clc;


%% SETUP CAMERA AND OBTAIN IMAGE
vid = videoinput('pointgrey',1, 'Mono8_640x480');
pause(1);
I = getsnapshot(vid);

%% INSERT IMAGE PROCESSING CODE HERE
%Should use image I, find cubes, and determine commands for arm
%
%
%
%I = imread('imagename.png')	%Can load an image from file instead of camera feed
imshow(I);
drawnow();
%
%
%



%% CONTROL ARM
%Should send out commands via TCPIP as strings (format below)

%command_string = '<x0,y260>\n'
%sendCommand(t,command_string)      %Send command string to robot via network

%Include brackets in command

%Full list of commands: 
% <x0,y360>\n = PositionTool(0,360)
% <h0>\n = setToolHeight(0)
% <a90>\n = setToolAngle(90)
% <o>\n = OpenGripper
% <c>\n = CloseGripper

%% OPEN NETWORK CONNECTION
t=tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
fopen(t);

%Example code
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<x0,y490>\n')	%Move to (0,490)
% sendCommand(t,'<c>\n')		%Close gripper
% sendCommand(t,'<x0,y390>\n')	%Move to (0,390)
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<h2>\n')		%Set tool height to 2 cubes
% sendCommand(t,'<a45>\n')	%Set tool angle to 45 deg

% mat = [x column, ycolumn]
% angle = [deg column]  % defined from vertical
tower = [0,490];
home = [0,400];
grip(0);

for block = 1:1:5
    moveh(1,t);
    moveto(mat(block,1),mat(block,2),t);
    setangle(angle(block),t);
    moveh(0,t);
    grip(1,t);
    moveh(block,t);
    setangle(0,t);
    moveto(tower(1),tower(2),t);
    moveh(block-1,t);
    grip(0,t);
    moveto(home(1),home(2),t);
end

%% CLOSE NETWORK PORT AND CAMERA
delete(vid)
fclose(t);

end


