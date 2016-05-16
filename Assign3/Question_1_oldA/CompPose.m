function [Phi_comp] = CompPose(comp_ind, compObs)
%Output pose from compass data

Phi_comp = compObs(comp_ind, 3);

end

