

function [LineDataStore]  = LineSplitRecursion(Data,beginindex,endindex,threshold,LineDataStore,minpoints)

% check if done?
%         threshold = 0.1; % hardcoded atm
        
        L_ab = line2points(Data(beginindex,:),Data(endindex,:));
        Dis = perpdis(L_ab,Data(beginindex:endindex,:));
        [maxdis,maxindex] = max(abs(Dis));
        maxindex = maxindex + beginindex - 1;
        if maxdis > threshold    % go down 

            [LineDataStore] = LineSplitRecursion(Data,beginindex,maxindex,threshold,LineDataStore,minpoints);
            [LineDataStore] = LineSplitRecursion(Data,maxindex,endindex,threshold,LineDataStore,minpoints);

        elseif endindex-beginindex < minpoints % have some minimum number of points?
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