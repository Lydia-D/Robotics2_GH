function [phi] = CompPose(ind, data,phi,alpha)
%Output pose from compass data

phi.com = data.com(ind.com, 3);

[phi.com, phi.hat] = fixPhiValues(phi.com, phi.hat);


phi.hat = (1-alpha.Phi)*phi.hat + alpha.Phi*phi.com;


end

