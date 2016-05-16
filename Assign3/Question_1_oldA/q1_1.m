clc; clear all; close all;

X_hat = [];
Y_hat = [];
Phi_hat = [];

v_obs = load('velocityObs.txt');
t_us = v_obs(:,2);
t_s = v_obs(:,1);
t = t_s + t_us/1000000;
v_msec = v_obs(:,3);
rot_radsec = v_obs(:,4);

X_hat = [X_hat, 0];
Y_hat = [Y_hat, 0];
Phi_hat = [Phi_hat, 0];

figure
fig.robot = plot(NaN,NaN,'r.','XDatasource','X_hat','YDatasource','Y_hat');
axis([-6 12 -10 10])
grid on
xlabel('X (meter)')
ylabel('Y (meter)')
% title(sprintf('Basic Robot Movement: time %d s', (t_s(a)-t_s(1))))
for a = 2:length(t_us)
    
    X_hat = [X_hat; X_hat(a-1) + (t(a)-t(a-1))*v_msec(a)*cos(Phi_hat(a-1))];
    Y_hat = [Y_hat; Y_hat(a-1) + (t(a)-t(a-1))*v_msec(a)*sin(Phi_hat(a-1))];
    Phi_hat = [Phi_hat; Phi_hat(a-1) + ((t(a)-t(a-1))*rot_radsec(a))];
    hold on
    
%     plot(X_hat(a), Y_hat(a),'r.')
    refreshdata(fig.robot,'caller')
    title(sprintf('Basic Robot Movement: time %d s', (t_s(a)-t_s(1))))
    drawnow
    
end

del_X = X_hat(end)-X_hat(1);
del_Y = Y_hat(end)-Y_hat(1);

final_pos = [del_X, del_Y];
final_dist = sqrt(del_X^2+del_Y^2);
% ave_vel = final_dist/