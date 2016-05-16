function [matches] = MatchEst2RealBeacon(lasFeats, beaconEstPos, ...
    beaconTolerance)
%% Given the estimated position of the beacons from observations, return a
% vector containing the x,y positions of the matching known beacon
% locations

matches = [];

for i = 1:numel(beaconEstPos)/2
    
    radii = sqrt((beaconEstPos(i,1) - lasFeats(:,1)).^2 + ...
        (beaconEstPos(i,2) - lasFeats(:,2)).^2);
    [minRad, indRad] = min(radii);
    if minRad < beaconTolerance
        matches = [matches; lasFeats(indRad, 1), lasFeats(indRad, 2)];
    end
end

end