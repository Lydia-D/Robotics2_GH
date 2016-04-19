%% Line splitting
% L Drabsch
% 8/4/16
% Steps: 1) take first and last data point and make line function
%        2) calculate perpendicular distances
%        3) find the max perpendicular distance = PointP
%        4) use LSM between first data point and PointP
%        5) Use PointP as 'first' data point and repeat from step 1

% Inputs: Data =  [xvec,yvec]

% Outputs: Lines = [a1,a2...an;b1,b2...bn]


% Notes: Have some error checking that it cant use the next point as a
% split if they are close enough?
%%
function [LineDataStore,DomainStore] = LineSplit(Data,threshold,minpoints)
%     threshold = 1;
    beginindex = 1;
    endindex = size(Data,1);
    done = 0;
    LineDataStore = [0;0]; % initialise number of rows
    DomainStore = [0;0]; % initialise number of rows
%     while beginindex < size(Data,1)
        
    hold on
%         [LineDataStore]  = LineSplitRecursionAnimation(Data,beginindex,endindex,threshold,LineDataStore,minpoints);
        [LineDataStore,DomainStore]  = LineSplitRecursion(Data,beginindex,endindex,threshold,LineDataStore,minpoints,DomainStore);

        % remove inital LineDataStore? [0;0] how else to save in recursion?
        LineDataStore = LineDataStore(:,2:end);
        DomainStore = DomainStore(:,2:end);



    %     plotline(Lines(:,i),Data(maxindex:end,:));


%         i = i+1;
%     end
    

end