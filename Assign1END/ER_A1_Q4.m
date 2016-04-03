%% L Drabsch 18/3/16
% Experimental robotics Assignment 1 Question 4
% Modified DH
% Aero coordinate convention
close all
%% transformations
% DHmod = Rot(z,theta)*trans(z,d)*rot(x,alpha)*trans(x,a)
thetas = [0,0,0,0,0];

Base = createT(0,0,0,zeros(3,1));
A0_1 = DHmod(0,0,0,thetas(1));
A1_2 = DHmod(5,90,0,thetas(2));
A2_3 = DHmod(10,-90,0,thetas(3));
A3_4 = DHmod(15,-90,0,thetas(4));
A4_5 = DHmod(0,90,5,thetas(5));


figure(1)
hold on
figQ4.base = hggroup;
figQ4.frame1 = hggroup;
figQ4.frame2 = hggroup;
figQ4.frame3 = hggroup;
figQ4.frame4 = hggroup;
figQ4.frame5 = hggroup;

plotcoordr(Base,'k',figQ4.base)
plotcoordr(A0_1,'r',figQ4.frame1)
plotcoordr(A0_1*A1_2,'c',figQ4.frame2)
plotcoordr(A0_1*A1_2*A2_3,'g',figQ4.frame3)
plotcoordr(A0_1*A1_2*A2_3*A3_4,'b',figQ4.frame4)
plotcoordr(A0_1*A1_2*A2_3*A3_4*A4_5,'m',figQ4.frame5)

%% plot arms
Pos = @(mat) mat(1:3,4);
Origins = [Pos(A0_1),Pos(A0_1*A1_2),Pos(A0_1*A1_2*A2_3),Pos(A0_1*A1_2*A2_3*A3_4),Pos(A0_1*A1_2*A2_3*A3_4*A4_5)];
normvectornotext(Origins(:,1:4),Origins(:,2:5),['';'';'';'';'';''],['k';'k';'k';'k';'k'],figQ4.base)

title('5 Link Robot using modified DH notation')
xlabel('global x cm')
ylabel('global y cm')
zlabel('global z cm')


% vector(A0_1(1:3,4),A0_1*A1_2(1:3,4),[],'k')
% vector(A0_1*A1_2(1:3,4),A0_1*A1_2*A2_3(1:3,4),[],'k')






