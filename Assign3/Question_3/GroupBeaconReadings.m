function [beacons] = GroupBeaconReadings(beaconsRange, beaconsAng, ...
    rangeGroupLength, angleGroupLength)
% Given a scan containing beacon readings, break each continuous scan up
% and return an average beacon location

beacons=[];
tempGroup = [beaconsRange(1), beaconsAng(1)];

for i = 2:length(beaconsAng)
    if (abs(beaconsAng(i-1)-beaconsAng(i))<=angleGroupLength) && ...
            (abs(beaconsRange(i-1)-beaconsRange(i))<=rangeGroupLength)
        tempGroup = [tempGroup; beaconsRange(i), beaconsAng(i)];
    else
        beacons = [beacons; mean(tempGroup(:,1)), ...
            mean(tempGroup(:,2))*pi/360-pi/2];
        tempGroup = [beaconsRange(i), beaconsAng(i)];
    end
end

if beacons
    beacons = sortrows(beacons, 1);
end

end