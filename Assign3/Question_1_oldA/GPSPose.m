function [X_gps, Y_gps] = GPSPose(gps_ind,  gpsObs)
%Output pose from GPS data

X_gps = gpsObs(gps_ind, 3);
Y_gps = gpsObs(gps_ind, 4);

end

