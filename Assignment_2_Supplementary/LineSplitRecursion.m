

function [LineDataStore,done]  = LineSplitRecursion(Data,beginindex,endindex,done,LineDataStore)

% check if done?
        threshold = 0.1; % hardcoded atm
        
        L_ab = line2points(Data(beginindex,:),Data(endindex,:));
        Dis = perpdis(L_ab,Data(beginindex:endindex,:));
        [maxdis,maxindex] = max(abs(Dis));
        maxindex = maxindex + beginindex - 1;
        if maxdis > threshold    % go down 

            [LineDataStore,done] = LineSplitRecursion(Data,beginindex,maxindex,done,LineDataStore);
            [LineDataStore,done] = LineSplitRecursion(Data,maxindex,endindex,done,LineDataStore);

%             if maxindex == beginindex
%                 maxindex = size(Data,1);
%             end
        else % threshold reached
            % calculate lines
            done = 1;
            LineDataStore(:,end+1) = LSM(Data(beginindex:endindex,:));
            plotline(LineDataStore(:,end),Data(beginindex:endindex,:));
%             
%             LineDataStore(:,end+1) = LSM(Data(maxindex:endindex,:));
%             plotline(LineDataStore(:,end),Data(maxindex:endindex,:));

        end
        
        % store Linedata
        
end