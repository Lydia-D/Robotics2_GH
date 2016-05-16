% test LSM
noise = linspace(5,10,10)'+rand(10,1);
plot(linspace(0,10,10)',noise,'bo')
hold on
Lines = LSM([linspace(0,10,10)',noise]);
plotline(Lines,[linspace(0,10,10)',noise],'k')
grid on
title('Least Squares Approximation')