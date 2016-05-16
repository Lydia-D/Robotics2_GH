% clc;
close all; 
clear all;

addpath('./MantisDataSetMTRX5700')
% addpath('./NormalData');

threshold = 20;

%% Load Data
% data.vel = load('velocityObs.txt');
% data.gps = load('positionObs.txt');
% data.com = load('compassObs.txt');
% data.las = [NaN;NaN;NaN;NaN;NaN];
data.imu = [NaN,NaN,NaN;NaN,NaN,NaN];
lasObs = [NaN,NaN,NaN;NaN,NaN,NaN];
% lasObs = load('laserObs.txt');
% lasFeats = load('laserFeatures.txt');

% % Manius data
data.vel  = load('MvelocityObs.txt');
data.gps  = load('MpositionObs.txt');
data.com = load('McompassObs.txt');
data.com(:,3) = wrapTo2Pi(data.com(:,3));
% % horizontal laser - needs to be translated to robot frame of refernce
% % using MlaserObs-offset.txt
lasObs = load('MlaserObs.txt');   
data.lasoffset = load('MlaserObs-offset.txt');
% data.imu = load('MimuObs.txt');
% 
data.las = lasObs(:, 3:2:length(lasObs(1,:)));
data.las(data.las == 80) = 0;


%% Fusion values
alpha.gps = 0.2;
alpha.imu = 0.2;
alpha.Phi = 0.5;
alpha.V = 0.2;
%% Variable initialisation
mu = 1/1000000;
updatePeriod = 0.01;

% globalGrid = zeros(globalWidth/gridBox);

%% Time initialisation

t.gps   = data.gps (:,1) + data.gps (:,2).*mu;
t.com  = data.com(:,1) + data.com(:,2).*mu;
t.las   = lasObs(:,1) + lasObs(:,2).*mu;
t.vel   = data.vel(:,1) + data.vel(:,2).*mu;
t.imu   = data.imu(:,1) + data.imu(:,2).*mu;

t0s = [t.gps(1,1), t.com(1,1), t.las(1,1), t.vel(1,1) ,t.imu(1,1)];
[t.start, ~] = min(t0s);
t.global = t.start;
t.prevpos  = t.start;
t.count = 0;
t.dt = 0;
%% Sensor initialisation
ind.gps = 1;  % indicies?
ind.com = 1;
ind.las = 1;
ind.vel = 1;
ind.imu = 1;
ind.done = 0;  % set as 1 when reached end of data

ind.gpsmax  = length(data.gps);
ind.commax = length(data.com);
ind.lasmax  = length(data.las);
ind.velmax  = length(data.vel);
ind.imumax  = length(data.imu);
%% Initial position and orientation estimates - dont have time yet
x.gps = data.gps(ind.gps, 3);   %X_Obs   % initial?
y.gps = data.gps(ind.gps, 4);          % Y_Obs
phi.com = data.com(ind.com, 3); % Phi_Obs
x.hat = x.gps;
y.hat = y.gps;
phi.hat = phi.com;

% phid = data.vel(ind.vel,4); % phid
% xdd = data.imu(ind.imu,6);
% ydd = data.imu(ind.imu,7);
% X_gps = [X_gps; gps.X];
% Y_gps = [Y_gps; Y_Obs];
% Phi_comp = [Phi_comp; com.phi];

x.centre = x.gps;  % translatation for grid
y.centre = y.gps;

grid.boxsize = 1; % 1 m x 1m
grid.widthm = 200; % m 
grid.widthnum = grid.widthm/grid.boxsize;

x.edge = x.centre - grid.widthm/2;
y.edge = y.centre + grid.widthm/2;

%% Dead reckoning Estimates   ????
x.dead = 0; 
% x.gps = 0;
x.imu = 0;
y.dead = 0;
% y.gps = 0;
y.imu = 0;
phi.dead = 0; 
% phi.com = 0;
xd.dead = 0;
xd.imu = 0;
xd.hat = 0;
yd.dead = 0;
yd.imu = 0;
yd.hat = 0;
phid = 0;
xdd = 0;
ydd = 0;
% t.prev = t.global;
X.gps = [];
Y.gps = [];


%% Data Fusion Step
% [x, y, phi,xd,yd] = Fusion(alpha, x, y, phi,xd,yd);

x.fus = [x.hat];
y.fus = [y.hat];
phi.fus = [phi.hat];
xd.fus = xd.hat;
yd.fus = yd.hat;
%% Plotting

% boxsize = 5e6;
% rd = 160;
gg = zeros(grid.widthnum);
ggthresh = zeros(grid.widthnum);

% threshold = 0;
w = imshow(ggthresh);

colour = '.r';
% colour = 'rgbmyc';
fig.base = figure;
[X_dead,Y_dead] = deadreckoning(x,y,phi,data,t);
% [X_IMU,Y_IMU] = imureckoning(x,y,phi,data,t);
hold on
plot(data.gps(:, 3),data.gps(:, 4),'b.');
hold on
plot(X_dead,Y_dead,'g')
hold on
% plot(X_IMU,Y_IMU,'k')
legend('GPS Data','Encoders','IMU','Fusion')
fig.hat = plot(NaN,NaN,'.r','XDatasource','x.fus','YDataSource','y.fus');
% eval(['fig = plot(NaN,NaN,''' colour ''',''XDatasource'',''x.fus'',''YDataSource'',''y.fus'');'])

%%
while 1
    %% Get the sensor which provides the newest data and the new time
    [t, ind, sensor] = SenseTimeStep(t, ind);
%     t.sim = t.global(end) - t.start;   % time of simulation
    
%     t.count = t.count + t.dt;
    
    %% If all data has been read, end.
    if ind.done == 1
        break
    end
    
    %% Collect sensor data based on time-stamp
    switch sensor
        case 1
            [x,y] = GPSPose(ind,data,x,y,alpha);
            X.gps = [X.gps; x.gps];  % global storage
            Y.gps = [Y.gps; y.gps];
            [x,y,phi] = store(x,y,phi);
            figure(fig.base);
            plot(x.hat,y.hat,'xb')

%             fig.Marker = 'x';
%             fig.Color = 'g';
            refreshdata(fig.hat,'caller')
            set(w,'CData',ggthresh);
            drawnow;
        case 2
            if ind.com == 104 || ind.com == 158
                keyboard;
            end
            [phi] = CompPose(ind, data,phi,alpha);
    %         com.phi = phi_comp;
    %         Phi_comp = [Phi_comp; phi_comp];
%             fig.Marker = 'x';
%             fig.Color = 'm';
            figure(fig.base);
            plot(x.hat,y.hat,'ok')
            [x,y,phi] = store(x,y,phi);
            refreshdata(fig.hat,'caller')
            set(w,'CData', ggthresh);
            drawnow;
        case 3  % laser data - not used for positioning only Obstacles

        
        %Collect Laser Data for walls and output X and Y positions of the
        %wall
        
        wallData = lasWall(data,ind,x,y,phi);
        
%         refreshdata(figwall,'caller')
        
        %Update global grid
%         gg = gg/max(max(gg));
        gg = gg + localgrid(wallData.pos.glob,x,y,grid);
        ggthresh  = gg>threshold;
        %could use icp in the middle to match old data points to new
        %or with hough for horizontal and vertical lines only
%         gg = gg/max(max(gg));
%         set(w,'CData', gg); %update imshow
%         drawnow()

        
        case 4 % velocity data
            
            [x,y,phi,xd,yd] = DeadPose(t,data,ind,x,y,phi,xd,yd);
            
            [x, y, phi,xd,yd] = Fusion(alpha,ind, x, y, phi,xd,yd);
%             fig.Marker = '.';
%             fig.Color = 'r';
            [x,y,phi] = store(x,y,phi);
            refreshdata(fig.hat,'caller')
            set(w,'CData', ggthresh);
            drawnow;
%             X_dead = [X_dead; x_Dead];
%             Y_dead = [Y_dead; y_Dead];
%             Phi_dead = [Phi_dead; phi_Dead];
        
        case 5 % imu data
            [x,y,xd,yd,xdd,ydd] = IMUPose(t,ind,data,x,y,phi,xd,yd);
            
            
            
    end
    
    %% Data Fusion Step
%     if t.count > updatePeriod
%         [x, y, phi,xd,yd] = Fusion(alpha,ind, x, y, phi,xd,yd);
%         gps.X = X_hat;
%         Y_Obs = Y_hat;
%         com.phi = Phi_hat;
%          
%         hold on
% %         plot(globalPos(1), globalPos(2), 'r.')
%         refreshdata(fig,'caller')
%         drawnow;
% %     end
%     
%     x.fus = [x.fus; x.hat];  % store
%     y.fus = [y.fus; y.hat];
%     phi.fus = [phi.fus; phi.hat];
%     
end

% figure
hold on
plot(X.gps, Y.gps, 'b.');
plot(data.gps(:,3),data.gps(:,4),'.k')
% plot(X_las, Y_las, 'm.');
% plot(X_dead, Y_dead, 'r.');
% plot(X_fus, Y_fus, 'k-', 'LineWidth', 1.3);
% axis equal
% legend('GPS Path', 'Laser Path', 'Dead Reckoning', 'Final Path', 'Location', 'EastOutside');
% title('Robot Path and Fusion')
