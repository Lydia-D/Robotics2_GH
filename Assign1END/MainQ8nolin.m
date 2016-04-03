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

A = 0.5*(4*I1+I2+m2*(L1^2+0.25*L2^2));
B = m2*L1*L2;
C = 0.5*I2+1/8*m2*L2^2;
D = I2 + 0.25*m2*L2^2;

%% linearise about 
% df1_dth1 = @(th,thd,thdd) -sin(th(1))*L1*g*(m1/2+m2) -L2/2*m2*g*sin(th(1)+th(2));
% df1_dth2 = @(th,thd,thdd) -2*thdd(1)*B*sin(th(2)) - 2*thd(1)*B*thd(2)*cos(th(2)) - thdd(2)*B*sin(th(2))-thd(2)^2*B*cos(th(2)) - L2/2*m2*g*sin(th(1)+th(2));
% df1_dthd1 = @(th,thd,thdd) -2*B*thd(2)*sin(th(2));
% df1_dthd2 = @(th,thd,thdd) -2*thd(1)*B*sin(th(2)) - 2*thd(2)*B*sin(th(2));
% df1_dthdd1 = @(th,thd,thdd) 2*(A+B*cos(th(2)));
% df1_dthdd2 = @(th,thd,thdd) D+B*cos(th(2));
% 
% df2_dth1 = @(th,thd,thdd) -L2/2*m2*g*sin(th(1)+th(2));
% df2_dth2 = @(th,thd,thdd) -thdd(1)*B*sin(th(2)) + thd(1)^2*B*cos(th(2))-L2/2*m2*g*sin(th(1)+th(2));
% df2_dthd1 = @(th,thd,thdd) 2*thd(1)*B*sin(th(2)) ;
% df2_dthd2 = @(th,thd,thdd) 0;
% df2_dthdd1 = @(th,thd,thdd) D+B*cos(th(2));
% df2_dthdd2 = @(th,thd,thdd) 2*C;
% 
% % x0 = [th1;th2;thd1;thd2;thdd1;thdd2]
% M = @(x0) [df1_dthdd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ;...
%         df2_dthdd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ];
% 
% C_m = @(x0) [df1_dthd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthd2(x0(1:2),x0(3:4),x0(5:6)) ;...
%         df2_dthd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthd2(x0(1:2),x0(3:4),x0(5:6)) ];
% 
% G = @(x0) [df1_dth1(x0(1:2),x0(3:4),x0(5:6)),df1_dth2(x0(1:2),x0(3:4),x0(5:6)) ;...
%         df2_dth1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dth2(x0(1:2),x0(3:4),x0(5:6)) ];
% 
% Amat = @(x0)  [0,0,          1,0;...
%             0,0,          0,1;...
%             -M(x0)\G(x0), -M(x0)\C_m(x0)];
% %% No linearising T = E*thdd + F*thd^2 + H*thd*thd +J
% E = @(th) [2*(A+B*cos(th(2))),D+B*cos(th(2));...
%             D+B*cos(th(2)),2*C];
% F = @(th) [0,-B*sin(th(2));...
%             B*sin(th(2)),0];
% H = @(th) [-B*sin(th(2)),-B*sin(th(2));...
%             0,0];   
% J = @(th) [L1*g*(m1/2+m2)*cos(th(1))+L2/2*m2*g*cos(th(1)+th(2));...
%             L2/2*m2*g*cos(th(1)+th(2))];
%% From Paper No linearising T = E*thdd + F*thd^2 + H*thd*thd +J
Ap = 1/3*m1*L1^2+m2*L2^2+m2*L2^2/3;
Dp = m2*L2^2/3;

E = @(th) [Ap+B*cos(th(2)),Dp+B/2*cos(th(2));...
            Dp+B/2*cos(th(2)),Dp];
F = @(th) [0,-B/2*sin(th(2));...
            B/2*sin(th(2)),0];
H = @(th) [-B/2*sin(th(2)),-B/2*sin(th(2));...
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


% normvector(Arm1end,[0;0;0],[],'k',arm1)
        
        
%% Sim
dt = 0.01; % seconds
tend = 25;
% initilise X = [th1;th2;thd1;thd2]
Xi = [0;0;0;0]; % at rest straight down
% Xi = [-pi/3;-pi/3;0;0]; % at rest 
i = 1;

% No torques
% T = zeros(2,tend/dt-10-50);

% step fn 
% T = [zeros(2,10),5*ones(2,50),zeros(2,tend/dt-10-50)];

% start control
T = [0;0];

% WORKING FOR Des = [-pi/3;0], 
% Kp = [70;70];
% Kd = [60;60];  % because circular?
% Ki = [10;10];
% Kv = [10;10];
% Desired configuration, % some vel control?
Des = [pi/2;-pi/2]; % 
MaxV = [pi;pi]; % deired velocity
Kp = [70;70];
Kd = [60;60];  % because circular?
Ki = [10;10];
Kv = [15;15]; % velocity control, if too fast, reduce error -> reduce torque?
conttime = 0;
dError = [0;0]; % initialise
Weight = [1;1]; % weighted error, larger torque on theta2
IError = [0;0];
for t = 0:dt:tend

    Xstore(1:4,i) = Xi;
    
    ddtheta = (E(Xi(1:2)))\(T(:,i) - F(Xi(1:2))*(Xi(3:4).^2) - H(Xi(1:2))*[Xi(3).*Xi(4);Xi(4).*Xi(3)]-J(Xi(1:2)));
    
    % integrate over one time step Euler
    dtheta = Xi(3:4) + dt*ddtheta;
    theta = Xi(1:2) + dt*Xi(3:4);  % use current timestep thetad
    Xnext = [theta;dtheta];
    
    % calculate error
    
    Error_NC(:,i) = Des - Xi(1:2) ; % not coupled. 
    if Error_NC(1,i)>pi
        Error_NC(1,i) = 2*pi-Error_NC(1,i);
    elseif Error_NC(2,i)>pi
        Error_NC(2,i) = 2*pi-Error_NC(2,i);
    end
    Error(:,i) = Error_NC(:,i)- [B*sin(Xi(2))*Error_NC(2,i);0];
    if i>1
        dError(:,i) = Error(:,i)-Error(:,i-1);
        IError(:,i) = Error(:,i)*dt + IError(:,i-1); % accumulating 
    else
        IError(:,1) = Error(:,1)*dt;
    end
    % vel control
    if (Xi(3:4))> MaxV
        T(:,i+1) = -Kv.*Xi(3:4); % or slow down some how?
    else
        T(:,i+1) = (Kp.*Error(:,i)+Kd.*dError(:,i)+Ki.*IError(:,i) - Kv.*Xi(3:4)).*Weight; % next control
    end
    
%     T(:,i+1) = (Kp.*Error(:,i)+Kd.*dError(:,i)+Ki.*IError(:,i) - Kv.*Xi(3:4)).*Weight; % next control



    conttime(1,i) = t;
    
%     Xdotlin = Amat(x0)*x0(1:4,1);
%     dXdot = Amat(x0)*dX;
%     Xdot = Xdotlin+dXdot;
    
%     dXnext = RungeKuttaR('dynamics',dt,ddtheta);% are you Xnext or dXnext?
    % store current states
    
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

%% plot
stateplot = figure(1);
clf
StateplotR(Xstore,0:dt:t,stateplot.Number,{},'-k')
axes([0 t -pi pi])