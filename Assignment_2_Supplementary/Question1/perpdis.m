%% Assign2 Q1a Perpendicular distance from line vectorised
% L Drabsch 8/4/16

% inputs: line = [a;b]   -> y = ax + b
%         data = [x,y]  point data (x,y)
function dis = perpdis(line,data)
    
    dis = (-line(1).*data(:,1)+data(:,2)-line(2))./(sqrt(line(1).^2+1));
    

end