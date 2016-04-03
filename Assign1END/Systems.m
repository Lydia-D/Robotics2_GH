clear
clc
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
Ap = 1/3*m1*L1^2+m2*L2+m2*L2^2/3;
Dp = m2*L2^2/3;

syms th1 th2 thd1 thd2 thdd1 thdd2 T1 T2 t
s = tf('s')

E =  [Ap+B*cos(th2),Dp+B/2*cos(th2);...
     Dp+B/2*cos(th2),Dp];
F =  [0,-B/2*sin(th2);...
     B/2*sin(th2),0];
H =  [-B/2*sin(th2),-B/2*sin(th2);...
      0,0];   
J =  [L1*g*(m1/2+m2)*cos(th1)+L2/2*m2*g*cos(th1+th2);...
      L2/2*m2*g*cos(th1+th2)];
% T = 00
ddtheta = E\(- F*[thd1.^2;thd2.^2] - H*[thd1.*thd2;thd2.*thd1]-J)
trans = laplace(ddtheta)

  