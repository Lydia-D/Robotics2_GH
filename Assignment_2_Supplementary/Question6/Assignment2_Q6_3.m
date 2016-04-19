%Assignment 2 Question 6

clear all;
clc;
clf;
a_vals = [];
b_vals = [];
start = 1;

% BlockImage = imread('ThreeFiducialsOnly.png');
%BlockImage = imread('Example_UnknownBlocks1.png');
BlockImage = imread('Example_KnownBlocks2.png');

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
for i =1: centSize(1)
    if (centroids(i,1)>150 && centroids(i,1)<550 && centroids(i,2)<400)
        centroids2(j,1) = centroids(i,1);
        centroids2(j,2) = centroids(i,2);
        j=j+1;
    else
        fiducials(k,1) = centroids(i,1);
        fiducials(k,2) = centroids(i,2);
        k=k+1;
    end
end

imshow(Edge);
hold on;

plot(centroids2(:,1),centroids2(:,2), 'rx')

roundc = round(centroids2);


sidelength=28;
diagleng = round(sqrt(2*sidelength.^2))+2;
%% isolate block left of centroid
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
        angleline(i) = atand(Lines(1,CornerLines(1)));
    end
    clear Lines IndexDomain CornerLines
end
angles = angleline+90; % from vertical
%%
% for i = 1:length(roundc)
% 
% row = roundc(i,1);
% col = roundc(i,2);
% 
%     while 1
%         row = row - 1;
%         if (Edge(col,row)==1)
%             break;
%         end
%         hold on;
%         plot(row,col,'bx');
%     end
%     
%     length2 = roundc(i,1)-row;
% 
%     row = roundc(i,1);
%     col = roundc(i,2);
%     while 1
%         row = row + 1;
%         if (Edge(col,row)==1)
%             break;
%         end
%         hold on;
%         plot(row,col,'gx');
%     end
%     length1 = row - roundc(i,1);
% 
%     length = (length1+length2)/2;
%     if length1>length2
%         angle(i) = acos(sidelength/length);
%     else
%         angle(i) = -acos(sidelength/length);
%     end
% 
% end

[px_rows, px_cols]=size(BW);

F1 = [-270, 523];
F2 = [-270, 220]; %The one in the bottom left corner
F3 = [270, 220];

alpha = tan((fiducials(1,1)-fiducials(2,1))/(fiducials(1,2)-fiducials(2,2)));
rot_matrix = [cos(alpha), sin(alpha); -sin(alpha), cos(alpha)];

angle_arm = rad2deg(angles-alpha); % in degrees

fiducials_y_trans = -fiducials(:,2);
fiducials_new = [fiducials(:,1),fiducials_y_trans];
fiducials_rotated = (rot_matrix*fiducials_new')';

known_cubes_px = [fiducials_rotated, [0; 0; 0]];
known_cubes_mm = [[F1;F2;F3], [0; 0; 0]];

centroids2_y_trans = -centroids2(:,2);
centroids2_new = [centroids2(:,1),centroids2_y_trans];
centroids2_rotated = (rot_matrix*centroids2_new')';
unknown_cubes_px = [centroids2_rotated, angle'];

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

