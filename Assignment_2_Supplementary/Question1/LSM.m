%% Least Square minimisation
% L Drabsch /4/16
% for fitting a line to a list of scan points

% inputs: data = [x column vec, y column vec]
% outputs: line = [a;b] (y = ax+b)

function line = LSM(data)
    
    xmean = mean(data(:,1));
    ymean = mean(data(:,2));
    x2mean = mean(data(:,1).^2);
    xymean = mean(data(:,1).*data(:,2));
    
    if size(data,1) == 2
        line = line2points(data(1,:),data(2,:));
    else
        matrix = [x2mean, xmean;xmean,1];
        line = matrix\[xymean;ymean];
    end
end
    