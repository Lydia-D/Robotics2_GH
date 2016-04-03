%% L Drabsch 18/3/16
% Experimental Robotics Assignment 1 Question 5
clc
clear

thetas = [-60,-60,-90];
L1 = 3; % cm
L2 = 3; % cm
L3 = 2.5; % cm

Base = createT(0,0,0,zeros(3,1));
% A0_1 = DH(0,thetas(1),L1,0);
% A1_2 = DH(0,thetas(2),L2,0);
% A2_3 = DH(0,thetas(3),L3,0);
% Tend = A0_1*A1_2*A2_3;

A0_1 = @(t1) DH(0,t1,L1,0);
A1_2 = @(t2) DH(0,t2,L2,0);
A2_3 = @(t3) DH(0,t3,L3,0);


%% Find workspace
density = 81;
theta1 = linspace(-60,60,density);          % i
theta2 = linspace(-120,120,density*2);        % j
theta3 = linspace(-90,90,density);          % k
Pos_endx = zeros(length(theta1),length(theta2)); % preallocate size 3D matrix
Pos_endx(:,:,length(theta3)) = 0;
Pos_endy = Pos_endx;


wb = waitbar(0,'Percentage Done');

% scatter(NaN,NaN,'XDatasource',Pos_endx,'YDatasource',Pos_endy)
for k = 1:1:length(theta3)
    for j = 1:1:length(theta2)
        for i = 1:1:length(theta1)
            Tend = A0_1(theta1(i))*A1_2(theta2(j))*A2_3(theta3(k));
            Pos_endx(i,j,k) = Tend(1,4); % take out x position
            Pos_endy(i,j,k) = Tend(2,4); % take out y position
%             Pos_endx = Tend(1,4); % take out x position
%             Pos_endy = Tend(2,4); % take out y position
        end
    end
       waitbar(k/density); 
end

close(wb)
X_end = reshape(Pos_endx,length(theta1).*length(theta2).*length(theta3),1);
Y_end = reshape(Pos_endy,length(theta1).*length(theta2).*length(theta3),1);
figure(2)
hold on
grid on
scatter(X_end,Y_end,'.')
title('Workspace of planar manipulator endeffector')
xlabel('x (cm)')
ylabel('y (cm)')

%% Plotting corrdinates for a particular configuration
% figure(1)
% hold on
% figQ5.base = hggroup;
% figQ5.frame1 = hggroup;
% figQ5.frame2 = hggroup;
% figQ5.frame3 = hggroup;
% plotcoord(Base,'k',figQ5.base)
% plotcoord(A0_1,'r',figQ5.frame1)
% plotcoord(A0_1*A1_2,'g',figQ5.frame2)
% plotcoord(A0_1*A1_2*A2_3,'b',figQ5.frame3)