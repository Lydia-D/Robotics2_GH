function [X_v, Y_v, Phi_v] = closestLocalisation(matches, beacons)
%% Given known beacon positions and beacon observations, localise a robot,
% by taking the closest two values

%% Calculate new X, Y, and Phi given the matching beacons
beaconYDiff = matches(2, 2) - matches(1, 2);
beaconXDiff = matches(2, 1) - matches(1, 1);
obsYDiff = beacons(2,1)*sin(beacons(2,2)) ...
    - beacons(1,1)*sin(beacons(1 ,2));
obsXDiff = beacons(2,1)*cos(beacons(2,2)) ...
    - beacons(1,1)*cos(beacons(1 ,2));

Phi_v = atan2(beaconYDiff,beaconXDiff)-atan2(obsYDiff,obsXDiff);
X_v = matches(1, 1) - beacons(1, 1)*cos(beacons(1 ,2) + Phi_v);
Y_v = matches(1, 2) - beacons(1, 1)*sin(beacons(1 ,2) + Phi_v);

end

