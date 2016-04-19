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
stats = regionprops(BWCC,'centroid','area','Orientation','MajorAxisLength');

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

round = round(centroids2);


sidelength=28;
for i = 1:length(round)

row = round(i,1);
col = round(i,2);

    while 1
        row = row - 1;
        if (Edge(col,row)==1)
            break;
        end
        hold on;
        plot(row,col,'bx');
    end
    
    length2 = round(i,1)-row;

    row = round(i,1);
    col = round(i,2);
    while 1
        row = row + 1;
        if (Edge(col,row)==1)
            break;
        end
        hold on;
        plot(row,col,'gx');
    end
    length1 = row - round(i,1);

length = (length1+length2)/2;

angle(i) = acosd(sidelength/length);

end

[px_rows, px_cols]=size(BW);

F1 = [-270, 523];
F2 = [-270, 220]; %The one in the bottom left corner
F3 = [270, 220];

alpha = tan((fiducials(1,1)-fiducials(2,1))/(fiducials(1,2)-fiducials(2,2)));

fiducials_y_trans = -fiducials(:,2);
fiducials_new = [fiducials(:,1),fiducials_y_trans];
fiducials_rotated = ([cos(alpha), sin(alpha); -sin(alpha), cos(alpha)]*fiducials_new')';

known_cubes_px = [fiducials_rotated, [0; 0; 0]];
known_cubes_mm = [[F1;F2;F3], [0; 0; 0]];
%centroids_rotated = 
unknown_cubes_px = [centroids2, angle'];

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

x_real=(known_cubes_px(2,1)-x_offset)*px2mm;
y_real=(-y_offset+known_cubes_px(2,2))*px2mm;

fiducials_mm_x = (known_cubes_px(:,1) - x_offset)*px2mm;
fiducials_mm_y = (known_cubes_px(:,2) - y_offset)*px2mm;
fiducials_mm = [fiducials_mm_x, fiducials_mm_y, [0;0;0]]

unknown_cubes_mm_x = (unknown_cubes_px(:,1) - x_offset)*px2mm;
unknown_cubes_mm_y = (unknown_cubes_px(:,2) - y_offset)*px2mm;
unknown_cubes_mm = [unknown_cubes_mm_x, unknown_cubes_mm_y, unknown_cubes_px(:,3)]

