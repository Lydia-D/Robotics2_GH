

function [LineDataStore]  = LineSplitRecursionAnimation(Data,beginindex,endindex,threshold,LineDataStore,minpoints)

% check if done?
%         threshold = 0.1; % hardcoded atm
        
        L_ab = line2points(Data(beginindex,:),Data(endindex,:));
            plotline(L_ab,Data(beginindex:endindex,:),'k');
            pause(0.5);
        Dis = perpdis(L_ab,Data(beginindex:endindex,:));
        [maxdis,maxindex] = max(abs(Dis));
        maxindex = maxindex + beginindex - 1;
            plot(Data(maxindex,1),Data(maxindex,2),'xr','Markersize',10);
        if maxdis > threshold    % go down 

            [LineDataStore] = LineSplitRecursionAnimation(Data,beginindex,maxindex,threshold,LineDataStore,minpoints);
            [LineDataStore] = LineSplitRecursionAnimation(Data,maxindex,endindex,threshold,LineDataStore,minpoints);

        elseif endindex-beginindex < minpoints % have some minimum number of points?
            % no line
        
        else      
            % threshold reached
            % calculate lines
          
            LineDataStore(:,end+1) = LSM(Data(beginindex:endindex,:));
            plotline(LineDataStore(:,end),Data(beginindex:endindex,:),'r');
%             
%             LineDataStore(:,end+1) = LSM(Data(maxindex:endindex,:));
%             plotline(LineDataStore(:,end),Data(maxindex:endindex,:));

        end
        
        % store Linedata
        
end