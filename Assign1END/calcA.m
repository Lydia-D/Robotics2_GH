%% L Drabsch
% Question 8 - Control a system

function Amatlin = calcA(x0)

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

%%
% xB = L1*cos(theta1) + 0.5*cos(theta2);
% yB = L1*sin(theta1) + 0.5*sin(theta2);

% varibales 
% linearise about 
df1_dth1 = @(th,thd,thdd) -sin(th(1))*L1*g*(m1/2+m2) -L2/2*m2*g*sin(th(1)+th(2));
df1_dth2 = @(th,thd,thdd) -2*thdd(1)*B*sin(th(2)) - 2*thd(1)*B*thd(2)*cos(th(2)) - thdd(2)*B*sin(th(2))-thd(2)^2*B*cos(th(2)) - L2/2*m2*g*sin(th(1)+th(2));
df1_dthd1 = @(th,thd,thdd) -2*B*thd(2)*sin(th(2));
df1_dthd2 = @(th,thd,thdd) -2*thd(1)*B*sin(th(2)) - 2*thd(2)*B*sin(th(2));
df1_dthdd1 = @(th,thd,thdd) 2*(A+B*cos(th(2)));
df1_dthdd2 = @(th,thd,thdd) D+B*cos(th(2));

df2_dth1 = @(th,thd,thdd) -L2/2*m2*g*sin(th(1)+th(2));
df2_dth2 = @(th,thd,thdd) -thdd(1)*B*sin(th(2)) -thd(1)*B*thd(2)*cos(th(2)) + (thd(1)^2*B+thd(1)*thd(2)*B)*cos(th(2))+L2/2*m2*g*cos(th(1)+th(2));
df2_dthd1 = @(th,thd,thdd) -B*thd(2)*sin(th(2)) + 2*thd(1)*B*sin(th(2)) + thd(2)*B*sin(th(2));
df2_dthd2 = @(th,thd,thdd) -thd(1)*B*sin(th(2))+thd(1)*B*sin(th(2));
df2_dthdd1 = @(th,thd,thdd) D+B*cos(th(2));
df2_dthdd2 = @(th,thd,thdd) 2*C;

% x0 = [th1;th2;thd1;thd2;thdd1;thdd2]
M = @(x0) [df1_dthdd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dthdd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthdd2(x0(1:2),x0(3:4),x0(5:6)) ];

C = @(x0) [df1_dthd1(x0(1:2),x0(3:4),x0(5:6)),df1_dthd2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dthd1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dthd2(x0(1:2),x0(3:4),x0(5:6)) ];

G = @(x0) [df1_dth1(x0(1:2),x0(3:4),x0(5:6)),df1_dth2(x0(1:2),x0(3:4),x0(5:6)) ;...
        df2_dth1(x0(1:2),x0(3:4),x0(5:6)) ,df2_dth2(x0(1:2),x0(3:4),x0(5:6)) ];

Amat = @(x0)  [0,0,          1,0;...
            0,0,          0,1;...
            -M(x0)\G(x0), -M(x0)\C(x0)];
Amatlin = Amat(x0);        
%         
% Bmat = [T1;...
%         T2];
    
% [thd(1);thd(2);thdd(1);thdd(2)] = Amat*[th(1)-x0(1);th(2)-x0(2);thd(1)-x0(3);thd(2)-x0(4)] + Bmat;


end



