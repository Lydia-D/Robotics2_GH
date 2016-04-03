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

A = 0.5*(I1+I2+m2*(L1^2+0.25*L2^2));
B = m2*L1*L2;
C = 0.5*I2+1/8*m2*L2^2;
D = I2 + 0.25*m2*L2^2;

%% linearise about 
df1_dth1 = @(th,thd,thdd) -sin(th(1))*L1*g*(m1/2+m2) -L2/2*m2*g*sin(th(1)+th(2));
df1_dth2 = @(th,thd,thdd) -2*thdd(1)*B*sin(th(2)) - 2*thd(1)*B*thd(2)*cos(th(2)) - thdd(2)*B*sin(th(2))-thd(2)^2*B*cos(th(2)) - L2/2*m2*g*sin(th(1)+th(2));
df1_dthd1 = @(th,thd,thdd) -2*B*thd(2)*sin(th(2));
df1_dthd2 = @(th,thd,thdd) -2*thd(1)*B*sin(th(2)) - 2*thd(2)*B*sin(th(2));
df1_dthdd1 = @(th,thd,thdd) 2*(A+B*cos(th(2)));
df1_dthdd2 = @(th,thd,thdd) D+B*cos(th(2));

df2_dth1 = @(th,thd,thdd) -L2/2*m2*g*sin(th(1)+th(2));
df2_dth2 = @(th,thd,thdd) -thdd(1)*B*sin(th(2)) + thd(1)^2*B*cos(th(2))-L2/2*m2*g*sin(th(1)+th(2));
df2_dthd1 = @(th,thd,thdd) 2*thd(1)*B*sin(th(2)) ;
df2_dthd2 = @(th,thd,thdd) 0;
df2_dthdd1 = @(th,thd,thdd) D+B*cos(th(2));
df2_dthdd2 = @(th,thd,thdd) 2*C;

% x0 = [th1;th2;thd1;thd2;thdd1;thdd2]
M = @(x0) [df1_dthdd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dthdd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ];

C_m = @(x0) [df1_dthd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthd2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dthd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthd2(x0(1:2),x0(3:4),x0(5:6)) ];

G = @(x0) [df1_dth1(x0(1:2),x0(3:4),x0(5:6)),df1_dth2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dth1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dth2(x0(1:2),x0(3:4),x0(5:6)) ];

Amat = @(x0)  [0,0,          1,0;...
            0,0,          0,1;...
            -M(x0)\G(x0), -M(x0)\C_m(x0)];
%% No linearising T = E*thdd + F*thd^2 + H*thd*thd +J
E = [2*(A+B*cos(th(2))),D+B*cos(th(2))...
    ;D+B*cos(th(2)),2*C];
F = [0,-B*sin(th(2));...
    B*sin(theta(2)),0];
H = [-B*sin(th(2)),-B*sin(th(2));...
    0,0];   
J = [L1*g*(m1/2+m2)*cos(th(1))+L2/2*m2*g*cos(th(1)+th(2));...
    L2/2*m2*g*cos(th(1)+th(2))];

        
        
        
%% Sim
dt = 0.01; % seconds
tend = 100;
% initilise X = [th1;th2;thd1;thd2]
Xi = [pi/3;-pi/6;0;0]; % at rest straight upwards
i = 1;

for t = 0:dt:tend
    % linearise about somepoint acc = 0?
%     x0 = [-pi/2;0;0.01;0.01;0;0];
    x0 = [Xi;0;0];
%     Calculate Amat and Bmat
    Amatlin = Amat(x0);
    
    % calculate dX
    dX = Xi-x0(1:4,1);
    
    % integrate over one time step
    
    
%     Xdotlin = Amat(x0)*x0(1:4,1);
%     dXdot = Amat(x0)*dX;
%     Xdot = Xdotlin+dXdot;
    
    dXnext = RungeKuttaR('dynamics',x0,dX,dt,Amatlin);% are you Xnext or dXnext?
    % store current states
    Xstore(1:4,i) = Xi
    
    
    
    Xi = dXnext+Xi;
    i = i+1;
end