

function [LineDataStore]  = LineSplitRecursion(Data,beginindex,endindex,threshold,LineDataStore)

% check if done?
%         threshold = 0.1; % hardcoded atm
        
        L_ab = line2points(Data(beginindex,:),Data(endindex,:));
        Dis = perpdis(L_ab,Data(beginindex:endindex,:));
        [maxdis,maxindex] = max(abs(Dis));
        maxindex = maxindex + beginindex - 1;
        if maxdis > threshold    % go down 

            [LineDataStore] = LineSplitRecursion(Data,beginindex,maxindex,threshold,LineDataStore);
            [LineDataStore] = LineSplitRecursion(Data,maxindex,endindex,threshold,LineDataStore);

%             if maxindex == beginindex
%                 maxindex = size(Data,1);
%             end
        elseif endindex-beginindex < 3 % have some minimum number of points?
            % no line
        
        else      
            % threshold reached
            % calculate lines
          
            LineDataStore(:,end+1) = LSM(Data(beginindex:endindex,:));
            plotline(LineDataStore(:,end),Data(beginindex:endindex,:));
%             
%             LineDataStore(:,end+1) = LSM(Data(maxindex:endindex,:));
%             plotline(LineDataStore(:,end),Data(maxindex:endindex,:));

        end
        
        % store Linedata
        
end