%Assignment 2 Question 6

clear all;
clc;
clf;
addpath('..\Question1')
a_vals = [];
b_vals = [];
start = 1;

% BlockImage = imread('ThreeFiducialsOnly.png');
BlockImage = imread('Example_UnknownBlocks1.png');
% BlockImage = imread('Example_KnownBlocks2.png');
% BlockImage = imread('Example_KnownBlocks1.png');

imshow(BlockImage);


BW=im2bw(BlockImage,0.1);
imshow(BW);


BW2 = imcomplement(BW);
imshow(BW2);


BWCC = bwconncomp(BW2);
stats = regionprops(BWCC,'centroid','area');

idx = find([stats.Area] > 2500 & [stats.Area] < 4000);
BW2 = ismember(labelmatrix(BWCC), idx);  
imshow(BW2);

% [stats.Centroid] > 100
BWCC = bwconncomp(BW2);
stats = regionprops(BWCC,'centroid','area');

Edge = edge(BW2);
imshow(Edge);


centroids = cat(1, stats.Centroid);
hold on
plot(centroids(:,1),centroids(:,2), 'b*')

centSize = size(centroids);
j=1;
k=1;
% for i =1: centSize(1)
%     if ((centroids(i,1)<140 && centroids(i,2)<240 && centroids(i,2)>200))...
%             || ((centroids(i,1)<140 && centroids(i,2)>400))...
%             ||((centroids(i,1)>490 && centroids(i,2)>400))
%         
%         fiducials(k,1) = centroids(i,1);
%         fiducials(k,2) = centroids(i,2);
%         k=k+1;
%         
%     else
%         
%         centroids2(j,1) = centroids(i,1);
%         centroids2(j,2) = centroids(i,2);
%         j=j+1;
%     end
% end

for i =1: centSize(1)
    if ((centroids(i,1)<140 && centroids(i,2)<240 && centroids(i,2)>200))   
        
        fiducials(1,1) = centroids(i,1);
        fiducials(1,2) = centroids(i,2);
        k=k+1;
    elseif ((centroids(i,1)<140 && centroids(i,2)>400))
        fiducials(2,1) = centroids(i,1);
        fiducials(2,2) = centroids(i,2);
        k=k+1;
    elseif ((centroids(i,1)>490 && centroids(i,2)>400))
        fiducials(3,1) = centroids(i,1);
        fiducials(3,2) = centroids(i,2);
        k=k+1;
        
    else
        
        centroids2(j,1) = centroids(i,1);
        centroids2(j,2) = centroids(i,2);
        j=j+1;
    end
end

fprintf('fiducals found %f',k)

imshow(Edge);
hold on;

plot(centroids2(:,1),centroids2(:,2), 'rx')

roundc = round(centroids2);


sidelength=28;
diagleng = round(sqrt(2*sidelength.^2))+2;
%% Angle Determination: isolate block left of centroid
for i = 1:1:size(centroids2,1)
    domainx = round(centroids2(i,1))-diagleng:1:round(centroids2(i,1));
    domainy = round(centroids2(i,2))-diagleng:1:round(centroids2(i,2)+diagleng);
    [xind,yind]=find(Edge(domainy,domainx)');
    [Lines,IndexDomain] = LineSplit([xind+domainx(1)-1,yind+domainy(1)-1],1.2,5);
    [Corner,CornerLines] = findcorner(Lines, IndexDomain, [xind+domainx(1)-1,yind+domainy(1)-1],3,0.1);
    if ~isempty(Corner)
        angleline(i) = atand(Lines(1,CornerLines(1)));
    else
       [Corner,CornerLines] = findcorner(Lines, IndexDomain, [xind+domainx(1)-1,yind+domainy(1)-1],10,0.1);
       if ~isempty(Corner) 
            angleline(i) = atand(Lines(1,CornerLines(1)));
       else 
           angleline(i) = -90;
       end
    end
    clear Lines IndexDomain CornerLines
end
angles = -(angleline+90); % from vertical

%% Transfromation from Image frame of reference to Arm frame of reference
[px_rows, px_cols]=size(BW);

F1 = [-270, 523];
F2 = [-270, 220]; %The one in the bottom left corner
F3 = [270, 220];

alpha = atan((fiducials(1,1)-fiducials(2,1))/(fiducials(1,2)-fiducials(2,2)));
rot_matrix = [cos(alpha), sin(alpha); -sin(alpha), cos(alpha)];

angle_arm = angles;%+rad2deg(alpha); % in degrees

fiducials_y_trans = -fiducials(:,2);
fiducials_new = [fiducials(:,1),fiducials_y_trans];
fiducials_rotated = (rot_matrix*fiducials_new')';

known_cubes_px = [fiducials_rotated, [0; 0; 0]];
known_cubes_mm = [[F1;F2;F3], [0; 0; 0]];

centroids2_y_trans = -centroids2(:,2);
centroids2_new = [centroids2(:,1),centroids2_y_trans];
centroids2_rotated = (rot_matrix*centroids2_new')';
unknown_cubes_px = [centroids2_rotated, angle_arm'];


%% Scaling from pixels to mm
blockWidth = 80;
mmDist = sqrt((known_cubes_mm(1,1)-(known_cubes_mm(2,1)))^2+(known_cubes_mm(1,2)-known_cubes_mm(2,2))^2);
pxDist = sqrt((known_cubes_px(1,1)-(known_cubes_px(2,1)))^2+(known_cubes_px(1,2)-known_cubes_px(2,2))^2);

% blockWidth_px = 253-196+1;
% px2mm = blockWidth/blockWidth_px;

px2mm = mmDist/pxDist;

x_offset=known_cubes_px(1,1)-(known_cubes_mm(1,1))/px2mm;
y_offset=known_cubes_px(1,2)-(known_cubes_mm(1,2))/px2mm;

% e.g. take the pixel x(column) value and minus the offset and multiply
% this by the scale to get the the real location
% x_real = (px_x-x_offset)*px2mm;

% x_real=(unknown_cubes_px(1,1)-x_offset)*px2mm
% y_real=(-y_offset+unknown_cubes_px(1,2))*px2mm

fiducials_mm_x = (known_cubes_px(:,1) - x_offset)*px2mm;
fiducials_mm_y = (known_cubes_px(:,2) - y_offset)*px2mm;
fiducials_mm = [fiducials_mm_x, fiducials_mm_y, [0;0;0]]

unknown_cubes_mm_x = (unknown_cubes_px(:,1) - x_offset)*px2mm;
unknown_cubes_mm_y = (unknown_cubes_px(:,2) - y_offset)*px2mm;
unknown_cubes_mm = [unknown_cubes_mm_x, unknown_cubes_mm_y, unknown_cubes_px(:,3)]

