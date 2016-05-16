
%Inputs -> 
%boxsize, local xy points, rd (maximum range of data)

%Outputs -> new grid

%size is 16m by 16m - matrix size depends on boxsize

function [ng] = localgrid(wallData,x,y, grid)
    %for this rg = 8;
    
    
    %make grid
    ng = zeros(grid.widthnum);
    
    %given grid is referenced at (0,0) in middle, shift x and y to correspond to
    %top left of grid
    xloc = wallData(1,:)-x.edge;
    yloc = -(wallData(2,:) -y.edge);
    
%     xlocgrid = -grid.widthm/2 -xloc;
%     ylocgrid = grid.widthm/2 - yloc;
    
    % get rid of all zeros
%     xloc = nozero(xloc);
%     yloc = nozero(yloc);    

    for i = 1:size(wallData,2) %for length of points
        jj = ceil(xloc(i)/grid.boxsize); %divides by box size to give array points
        ii = ceil(yloc(i)/grid.boxsize);
        if ii > ceil(grid.widthnum) || jj > ceil(grid.widthnum)
            error('again');
        end
        %add the number of hits in each array
        ng(ii,jj) = ng(ii,jj) + 1;
    end   
end