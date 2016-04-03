%% L Drabsch 18/3/16
% EX A1 Q4
% inputs: in degrees

function A = DHmod(a,alpha,d,theta)
    A = createT(0,0,theta,zeros(3,1))*createT(0,0,0,[0;0;d])...
        *createT(alpha,0,0,zeros(3,1))*createT(0,0,0,[a;0;0]);
end
