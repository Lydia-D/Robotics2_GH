% function that checks for corners

function [Corner,CornerLines] = findcorner(Lines, IndexDomain, mydata,spacbuffer,perpbuffer)
    RealDomain = [mydata(IndexDomain(1,:),1),mydata(IndexDomain(2,:),1)]';
    RealDomain = sort(RealDomain,1);
    Corner = [NaN;NaN];
    CornerLines = [NaN;NaN];
    % check if domains are close enough
%     spacbuffer = 0.1;
%     perpbuffer = 0.1;
    for lineindex = 1:1:size(Lines,2)
        near = abs(RealDomain(1,lineindex) - RealDomain)<=spacbuffer;
        near(:,lineindex) = [0;0]; % clear itself
        [~,nearindex] = find(near);
        if ~isempty(nearindex)  % if something is near
            for i = nearindex'
                % check  perpendiculararity
                if abs(Lines(1,i).*Lines(1,lineindex) + 1) <= perpbuffer
                    % intersect of lines
                    Corner(1,end+1) = (Lines(2,i)-Lines(2,lineindex))/(Lines(1,lineindex)-Lines(1,i));
                    Corner(2,end) = Lines(1,lineindex)*Corner(1,end)+Lines(2,lineindex);
                    CornerLines(:,end+1) = [lineindex,i];
                end
            end
        end
    end

    Corner = Corner(:,2:end); % remove inital NaNs
    CornerLines = CornerLines(:,2:end); % remove inital NaNs

    plot(Corner(1,:),Corner(2,:),'co','MarkerSize',7)     
    
    
end