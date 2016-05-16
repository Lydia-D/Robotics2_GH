function [X_hat, Y_hat, Phi_hat] = Fusion(alpha_P, alpha_Phi, X_Dead, ...
    X_Obs, Y_Dead, Y_Obs, Phi_Dead, Phi_Obs)
% Given the dead reckoning and observed pose, fuse the data to provide an
% estimate of true pose

X_hat = (1-alpha_P)*X_Dead + alpha_P*X_Obs;
Y_hat = (1-alpha_P)*Y_Dead + alpha_P*Y_Obs;
Phi_hat = (1-alpha_Phi)*Phi_Dead + alpha_Phi*Phi_Obs; 

end

