%
% Author: Stefan Williams (stefanw@acfr.usyd.edu.au)
%
%

clear 
close all
addpath('.\Question1')
% load laser files
laser_scans=load('.\captureScanshornet.txt');

t0 = laser_scans(1,1);

figure
for i = 1:length(laser_scans)
     tlaser = laser_scans(i,1) - t0;
     xpoint = zeros(1);
     ypoint = zeros(1);
     for j = 2:size(laser_scans,2)
         range = laser_scans(i,j) / 1000;
         bearing = ((j-1)/2 - 90)*pi/180;
         if (range < 75)
             xpoint = [xpoint range*cos(bearing)];
             ypoint = [ypoint range*sin(bearing)];
         end
     end
     hold off
     plot(xpoint(:), ypoint(:), '.');
     hold on
     [Lines,IndexDomain] = LineSplit([xpoint',ypoint'],0.1,3);
     Corner = findcorner(Lines, IndexDomain, [xpoint',ypoint'],0.02,0.1);
     axis equal;
     axis([0 10 -5 5]);
     xlabel('X (meter)')
     ylabel('Y (meter)')
     title(sprintf('ACFR indoor SICK data: scan %d',i))
     drawnow
     keyboard;
end