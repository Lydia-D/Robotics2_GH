%Fix phi values to stop wrap around

function [Phi_Obs, Phi_Dead] = fixPhiValues(Phi_Obs, Phi_Dead)
    while abs(Phi_Obs - Phi_Dead) > pi
        if Phi_Dead > Phi_Obs
            Phi_Dead = Phi_Dead - 2*pi;
        else
            Phi_Obs = Phi_Obs - 2*pi;
        end
    end
end