%% make line parameters from 2 data points
% L Drabsch
% 8/4/16
% inputs: point1 = [x,y] of first point
%         point2 = [x,y] of second point
% output: line   = [a;b] of y=ax+b
function line = line2points(point1,point2)

    a = (point2(2)-point1(2))./(point2(1)-point1(1));
    b = point1(2)-a*point1(1);
    line = [a;b];

end

