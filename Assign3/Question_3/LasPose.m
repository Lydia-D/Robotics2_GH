function [X_las, Y_las, Phi_las, grid_xy] = LasPose(las_ind, X_hat, Y_hat, ...
    Phi_hat, lasPure, lasMarkers, lasFeats)
%% Estimate pose from laser data, given current pose estimate

lasIncrement = 1;
angleGroupLength = lasIncrement;
rangeGroupLength = 0.15;
beaconTolerance = 3;
maxRobotRange = 1;
% gridSize = [1000, 1000];
% 
% angs = -pi/2:pi/360:pi/2;
% grid = lasPure(las_ind, :);
% [grid_x, grid_y] = pol2cart(angs, grid);
% grid_xy = sub2ind(gridSize, grid_x, grid_y);

beaconsAng = find(lasPure(las_ind, :).*lasMarkers(las_ind, :));
beaconsRange = lasPure(las_ind, beaconsAng);
if beaconsAng
    beacons = GroupBeaconReadings(beaconsRange, beaconsAng, ...
        rangeGroupLength, angleGroupLength);
else
    beacons = [];
end
matches = [];

%% Estimate the xy position of the beacons given the robot pose
if beacons
    beaconEstPos = EstimateBeaconLoc(beacons, X_hat, Y_hat, Phi_hat);
    % Given the estimate, match estimated beacon positions to real locs
    matches = MatchEst2RealBeacon(lasFeats, beaconEstPos, beaconTolerance);
end

if (numel(matches)/2)>1
    [X_las, Y_las, Phi_las] = closestLocalisation(matches, beacons);
else
    X_las = 0;
    Y_las = 0;
    Phi_las = 0;
end

if sqrt((X_las-X_hat)^2 + (Y_las-Y_hat)^2) > maxRobotRange
    X_las = 0;
    Y_las = 0;
    Phi_las = 0;
end

end

