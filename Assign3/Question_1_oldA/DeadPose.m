function [X_Dead, Y_Dead, Phi_Dead] = DeadPose(vel_ind, X_hat, Y_hat, ...
    Phi_hat, velObs, dt)
% Given the best guess of position and rotation, return the dead reckoning
% pose of the robot

    X_Dead = X_hat + dt*velObs(vel_ind, 3)*cos(Phi_hat);
    Y_Dead = Y_hat + dt*velObs(vel_ind, 3)*sin(Phi_hat);
    Phi_Dead = Phi_hat + dt*velObs(vel_ind, 4);

end