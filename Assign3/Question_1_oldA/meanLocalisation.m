function [X_v, Y_v, Phi_v] = meanLocalisation(matches, beacons)
%% Given known beacon positions and beacon observations, localise a robot,
% by taking the mean of many values

%% Calculate new X, Y, and Phi given the matching beacons
for i=1:(numel(matches)/2)
    
    if (i==(numel(matches)/2))
        next = 1;
    else
        next = i + 1;
    end
    
    beaconYDiff = matches(next, 2) - matches(i, 2);
    beaconXDiff = matches(next, 1) - matches(i, 1);
    obsYDiff = beacons(next,1)*sin(beacons(next,2)) - beacons(i,1)*sin(beacons(i ,2));
    obsXDiff = beacons(next,1)*cos(beacons(next,2)) - beacons(i,1)*cos(beacons(i ,2));
    
    Phi_temp = atan2(beaconYDiff,beaconXDiff)-atan2(obsYDiff,obsXDiff);
    
    X_temp = matches(i, 1) - beacons(i, 1)*cos(beacons(i ,2) + Phi_temp(i));
    Y_temp = matches(i, 2) - beacons(i, 1)*sin(beacons(i ,2) + Phi_temp(i));
    
end

%% Take the average of the beacon localisation
X_v = mean(X_temp);
Y_v = mean(Y_temp);
Phi_v = mean(Phi_temp);

end

