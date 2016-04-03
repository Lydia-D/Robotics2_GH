%% by Lydia Drabsch
% Function to generate Homogeneous Transformation matrix from euler angles
% in degrees. Applied in R = R*P*Y*Pos
% Using Aero convension
function T = createT(R,P,Y,Pos)

    yaw = @(gamma) rot('z',gamma);
    pitch = @(beta) rot('y',beta);
    roll = @(alpha) rot('x',alpha);
    
    R = roll(deg2rad(R))*pitch(deg2rad(P))*yaw(deg2rad(Y));
    T = [R,Pos;[0,0,0,1]];
    
end