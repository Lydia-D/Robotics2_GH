function [walls] = lasWall(data,ind,x,y,phi)

%% get xy position of the walls given the robot position and pose
% walls.ind = ~isnan(data.las(ind.las, :));
walls.Range = data.las(ind.las, :);

walls.Ang = [pi/2:-deg2rad(1):-pi/2];%.*walls.ind;

% laser offset roll+pi, pitch, yaw,translation (pi rotation to align IMU
% NED corrdinates to cartisian robot frame)

% laser data in laser frame
% las2rob = createT(data.lasoffset(1)+pi,data.lasoffset(2),data.lasoffset(3),data.lasoffset(1:3)');
las2rob = createT(0,0,0,[data.lasoffset(1);0;0]);



% las2rob   = createT(data.lasoffset(1),data.lasoffset(2),data.lasoffset(3),[0;0;0])
% offset = IMU2rob(

% rob2glob = createT(0,0,-phi.hat,[-(x.hat-x.centre);-(y.hat-y.centre);0]);
rob2glob = createT(0,0,phi.hat,[x.hat;y.hat;0]);

% walls.pos.las = [walls.Range.*cos(walls.Ang)-data.lasoffset(1);walls.Range.*sin(walls.Ang);zeros(1,length(walls.Ang));ones(1,length(walls.Ang))];
walls.pos.glob = [x.hat+walls.Range.*cos(walls.Ang+phi.hat); y.hat+walls.Range.*sin(walls.Ang+phi.hat);zeros(1,length(walls.Ang));ones(1,length(walls.Ang))]; %xy location of walls
% walls.pos.glob = rob2glob*las2rob*walls.pos.las;
% walls.pos.rob = las2rob*walls.pos.las;
% walls.pos.glob = [x.hat + walls.pos.las(1,:).*cos(phi.hat); y.hat + walls.pos.las(2,:).*sin(phi.hat)];
end

