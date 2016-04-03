%% L Drabsch 18/3/16
% EX A1 Q4
% inputs: in degrees

function A = DH(d,theta,a,alpha)
    A = createT(0,0,theta,zeros(3,1))*createT(0,0,0,[0;0;d])...
        *createT(0,0,0,[a;0;0])*createT(alpha,0,0,zeros(3,1));
end