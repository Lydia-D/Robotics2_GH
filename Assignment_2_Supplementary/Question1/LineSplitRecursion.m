%% Recusion function for creating lines
% L Drabsch
% Outputs: [a;b] of line
%          [begin;end]     domain of line as indicies


function [LineDataStore,DomainStore]  = LineSplitRecursion(Data,beginindex,endindex,threshold,LineDataStore,minpoints,DomainStore)

% check if done?
%         threshold = 0.1; % hardcoded atm
        
        L_ab = line2points(Data(beginindex,:),Data(endindex,:));
        Dis = perpdis(L_ab,Data(beginindex:endindex,:));
        [maxdis,maxindex] = max(abs(Dis));
        maxindex = maxindex + beginindex - 1;
        if maxdis > threshold    % go down 

            [LineDataStore,DomainStore] = LineSplitRecursion(Data,beginindex,maxindex,threshold,LineDataStore,minpoints,DomainStore);
            [LineDataStore,DomainStore] = LineSplitRecursion(Data,maxindex,endindex,threshold,LineDataStore,minpoints,DomainStore);

        elseif endindex-beginindex < minpoints % have some minimum number of points?
            % no line
        
        else      
            % threshold reached
            % calculate lines
          
            LineDataStore(:,end+1) = LSM(Data(beginindex:endindex,:));
            DomainStore(:,end+1) = [beginindex;endindex];
            plotline(LineDataStore(:,end),Data(beginindex:endindex,:),'r');
%             
%             LineDataStore(:,end+1) = LSM(Data(maxindex:endindex,:));
%             plotline(LineDataStore(:,end),Data(maxindex:endindex,:));

        end
        
        % store Linedata
        
end