clc; clear all; close all;

addpath('..\Question1')

%write up-> adjust hoff threshold, adjust selection threshold, vary image
%resolution for edge detection, play with edge algorithms.

% Finding lines with Hough transform

% Load an image 
I1 = imread('Example_KnownBlocks1.png');
I2 = imread('Example_KnownBlocks2.png');
I3 = imread('Example_UnknownBlocks1.png');
I4 = imread('ThreeFiducialsOnly.png');

I=I3; 

% I = imresize(I, 0.5);
[rows, cols] = size(I);

cubeColourThreshold = 25; %Use when image normal size
%cubeColourThreshold = 18; %Use when image resized to half
I(I>cubeColourThreshold)=255;

% Plot------------------------------------
figure, imshow(I)
title ('Original Image')
% -----------------------------------------
Iinv = imcomplement(I);
CC= bwconncomp(Iinv);
stats = regionprops(CC,'centroid','area');
idx = find([stats.Area] > 1000 & [stats.Area] < 4000);

I2 = ismember(labelmatrix(CC), idx);  
CC2 = bwconncomp(I2);
stats2 = regionprops(CC2,'centroid','area','Orientation');
imshow(I2)
hold on
% stats2.Centroid is in the image frame
centroids = cat(1, stats2.Centroid);
plot(centroids(1,:),centroids(2,:),'xr')

angles = cat(1,stats2.Orientation)






% Edge detection
Cedge = edge(I2, 'Canny');
Sedge = edge(I2, 'Sobel');
Pedge = edge(I2, 'Prewitt');

E = Pedge;

y_top = round((69/240)*rows);
y_bottom = round((237/240)*rows);
x_left = round((43/320)*cols);
x_right = round((278/320)*cols);

E([1:y_top],:)=0;
E([y_bottom:rows],:)=0;
E(:,[1:x_left])=0;
E(:,[x_right:cols])=0;
figure
imshow(E)




%%


% for i = 1:1:length(idx)
%     E(CC.PixelIdxList{i}) = 0;
% end
% [xindex,yindex]=find(E);
% plot(xindex,yindex)
% [Lines,IndexDomain] = LineSplit([xindex,yindex],0.5,5);
% Corner = findcorner(Lines, IndexDomain, [xindex,yindex]);

% Realx = linspace(1,x_right,cols);
% Realy = linspace(y_bottom,y_top,rows);

% figure, imshow(E);
% title ('Gradient Image')

% Lydia plz read if looking: don't worry about the messy variables, for the
% real thing, output an array of corners and we'll loop through them and
% use proper references to objects. These variable names are for
% illustrative purposes only.
%--------------------------------------------------------------------------
%--------- Translate pixels to real world using fiducials -----------------
%--------------------------------------------------------------------------

% Example outputs of line fitting. Achieved by looking.
% Find bottom-left corner
corner1_x = 97;
corner1_y = 471;

corner2_x = 95;
corner2_y = 417;

deviation = 5; %Pixel deviation
if (((corner1_x > ((98/640)*cols - deviation)) || (corner1_x < ((98/640)*cols + deviation)))...
        && ((corner1_y > ((470/480)*rows - deviation)) || (corner1_y < ((470/480)*rows + deviation))))
    F1_bottom_left_px_x = corner1_x;
    F1_bottom_left_px_y = corner1_y;
end

if (((corner2_x > ((95/640)*cols - deviation)) || (corner2_x < ((95/640)*cols + deviation)))...
        && ((corner2_y > ((417/480)*rows - deviation)) || (corner2_y < ((417/480)*rows + deviation))))
    F1_top_left_px_x = corner2_x;
    F1_top_left_px_y = corner2_y;
end

blockWidth = 80;
F1 = [-270, 220]; %The one in the bottom left corner
F2 = [-270, 523];
F3 = [280, 220];

px2mm = blockWidth/sqrt((corner2_x-corner1_x)^2+(corner2_y-corner1_y)^2);

x_offset=F1_bottom_left_px_x-(F1(1)-blockWidth/2)/px2mm
% e.g. take the pixel x(column) value and minus the offset and multiply
% this by the scale to get the the real location
% x_real = (px_x-x_offset)*px2mm;
y_offset=F1_bottom_left_px_y-(F1(2)-blockWidth/2)/px2mm
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%--------------------- Block search using corners -------------------------
%--------------------------------------------------------------------------

% from corner(i), if not in location expected of fiducial AND is in valid
% range
%   do,
%       if 2 * corners at blockWidth+deviation AND 1 * corner at
%       sqrt(2)*blockWidth + deviation 
%           (and maybe)AND sign(original corner xy - second
%       corners xy) equals sign(original corner xy - fourth corner xy)
%
%           we have square