function [x,y,phi] = store(x,y,phi)

        x.fus = [x.fus; x.hat];  % store
        y.fus = [y.fus; y.hat];
        phi.fus = [phi.fus; phi.hat];
end