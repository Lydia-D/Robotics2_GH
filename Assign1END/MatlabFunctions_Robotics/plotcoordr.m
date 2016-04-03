%% by Lydia Drabsch 11/3/16
% plot coordinate frame about a point
% inputs: T = 4x4 Homogeneous Transformation matrix 
%               T(1:3,4) = postion of origin
%               c = colour of axis
function plotcoordr(T,c,parent)
    
    % plot global axis
%     fighandle = normvector(eye(3),zeros(3),['x';'y';'z'],['k';'k';'k']); 
    magnitude = 3;
    % new origin
    O = [0;0;0;1];
    Onew = T*O;
%     Onew = Onew/norm(Onew(1:3));
    
    % plot Xnew [x,y,z,1] 
    X = [magnitude;0;0;1];
    Xnew = T*X;
    normvectorr(Xnew(1:3),Onew(1:3),'xN',c,parent);
    
    Y = [0;magnitude;0;1];
    Ynew = T*Y;
    normvectorr(Ynew(1:3),Onew(1:3),'yN',c,parent);
    
    Z = [0;0;magnitude;1];
    Znew = T*Z;
    normvectorr(Znew(1:3),Onew(1:3),'zN',c,parent);

    axis equal
    grid on
end