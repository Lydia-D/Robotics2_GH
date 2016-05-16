function [beaconEstPos] = EstimateBeaconLoc(beacons, X_hat, Y_hat, Phi_hat)
%%Given the robot's current pose, and beacon readings, estimate the global
%%position of the beacons

beaconEstPos = [X_hat + beacons(:,1).*cos(Phi_hat+beacons(:,2)),...
    Y_hat + beacons(:,1).*sin(Phi_hat+beacons(:,2))];

end

