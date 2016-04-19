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

size = size(centroids);
j=1;
for i =1: size(1)
    if (centroids(i,1)>150 && centroids(i,1)<550 && centroids(i,2)<400)
        centroids2(j,1) = centroids(i,1);
        centroids2(j,2) = centroids(i,2);
        j=j+1;
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

% row = 
% angle





