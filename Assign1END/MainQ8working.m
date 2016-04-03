%% ignore T1 and T2 to begin with
clear
clc

%% Parameters
global g
g = 9.81; % m/s
L1 = 1; % m
L2 = 0.75; % m
m1 = 5; % kg
m2 = 4; % kg
I1 = 0.4; % kgm^2
I2 = 0.2; % kgm^2

A = 2*I1+0.5*I2+0.5*m2*L1^2+m2*L2^2/8;
B = 0.5*m2*L1*L2;
C = 0.5*I2+1/8*m2*L2^2;
D = I2+m2*L2^2/4;

%% T = E*thdd + F*thd^2 + H*thd*thd +J

E = @(th) [2*A+2*B*cos(th(2)),D+B*cos(th(2));...
            D+B*cos(th(2)),2*C];
F = @(th) [0,-B*sin(th(2));...
            B*sin(th(2)),0];
H = @(th) [-B*sin(th(2)),-B*sin(th(2));...
            0,0];   
J = @(th) [L1*g*(m1/2+m2)*cos(th(1))+L2/2*m2*g*cos(th(1)+th(2));...
            L2/2*m2*g*cos(th(1)+th(2))];

%% Animation
% Armend = [0,x1,x2;0,y1,y2]
figure(2)
armplot = plot(NaN,NaN,'k','XDatasource','Armend(1,:)','YDatasource','Armend(2,:)');
axis([-2 2 -2 2])
grid on
figure(3) % plot torques
hold on
grid on
torqueplot.A = plot(NaN,NaN,'b','XDatasource','conttime','YDatasource','T(1,1:end-1)');
torqueplot.B = plot(NaN,NaN,'r','XDatasource','conttime','YDatasource','T(2,1:end-1)');
title('Comparision of Coupled Error Controller vs Uncoupled Error Controller')        
xlabel('Time (seconds)')
ylabel('Torque (Nm)')
%% Sim
dt = 0.01; % seconds
tend = 10;
% initilise X = [th1;th2;thd1;thd2]
Xi = [0;0;0;0]; % at rest horizontal
i = 1;

% No torques
% T = zeros(2,tend/dt);

% step fn 
% T = [zeros(2,10),5*ones(2,50),zeros(2,tend/dt-10-50)];

% start control
T = [0;0];

% Desired configuration and control gains
Des = [pi/3;-pi/6]; % desired config
MaxV = [pi;pi]; % maximum velocity
Kp = [70;70];   % proportional control gains
Kd = [60;60];   % derrivative control gains
Ki = [10;10];   % integral control gains
Kv = [15;15]; % velocity control, if too fast, reduce error -> reduce torque?

% initialise
conttime = 0;  
dError = [0;0]; 
IError = [0;0];
for t = 0:dt:tend
    % store current position and time
    Xstore(1:4,i) = Xi;
    conttime(1,i) = t; 

    %% PID and velocity control
    % Not coupled error on theta1 theta2
    Error_NC(:,i) = Des - Xi(1:2) ;  
    % take shortest path around the circle to desired postion
    if Error_NC(1,i)>pi
        Error_NC(1,i) = 2*pi-Error_NC(1,i);
    elseif Error_NC(2,i)>pi
        Error_NC(2,i) = 2*pi-Error_NC(2,i);
    end
    % COUPLING: Include error from theta2 in T1, no coupling for T2
    Error(:,i) = Error_NC(:,i)- [B*sin(Xi(2))*Error_NC(2,i);0];
    % Derrivative and integral errors
    if i>1
        dError(:,i) = Error(:,i)-Error(:,i-1);
        IError(:,i) = Error(:,i)*dt + IError(:,i-1); % accumulating 
    else
        IError(:,1) = Error(:,1)*dt;
    end
    
    % vel control
    if (Xi(3:4))> MaxV           % if moving too fast
        T(:,i+1) = -Kv.*Xi(3:4); % apply torque opposite direction
    else                         % PID control + vel control
        T(:,i+1) = (Kp.*Error(:,i)+Kd.*dError(:,i)+Ki.*IError(:,i) - Kv.*Xi(3:4)); % next control
    end
     
    %% Calculate accelerations
    ddtheta = (E(Xi(1:2)))\(T(:,i) - F(Xi(1:2))*(Xi(3:4).^2) - H(Xi(1:2))*[Xi(3).*Xi(4);Xi(4).*Xi(3)]-J(Xi(1:2)));
    
    % integrate over one time step Euler
    dtheta = Xi(3:4) + dt*ddtheta;
    theta = Xi(1:2) + dt*Xi(3:4);  % use current timestep thetad
    Xnext = [theta;dtheta];
    
    %% Animation
    Armend = [0,L1*cos(Xi(1)),L1*cos(Xi(1))+L2*cos(Xi(1)+Xi(2));...
              0,L1*sin(Xi(1)),L1*sin(Xi(1))+L2*sin(Xi(1)+Xi(2))];
    refreshdata(armplot,'caller')
    refreshdata(torqueplot.A,'caller')
    refreshdata(torqueplot.B,'caller')
    drawnow;
          
    Xi = Xnext;
    Xi(1:2) = wrapToPi(Xi(1:2));
    i = i+1;
end

%% plot states over time
stateplot = figure(1);
clf
StateplotR(Xstore,conttime,stateplot.Number,{},'-k')
% axes([0 t -pi pi])