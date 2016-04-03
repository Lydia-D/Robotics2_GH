%% L Drabsch 16/3/16
% Plot each state in 2x3 subplot
% inputs: X_ECI = vector of 6 elements
%           time = time vector
%         fighandle 
%           titles = cell of strings, default {'x','y','z','vel x','vel y','vel z'}

function StateplotR(X,time,fighandle,titles,linespec)
    
    if isempty(titles)
        titles = {'\theta_1','\theta_2','d\theta_1/dt','d\theta_2/dt'};
    end

    figure(fighandle)
    subplot(2,2,1), plot(time, X(1,:),linespec);
    grid on
    hold on
    title(titles(1))
    axis([0 time(end) -pi pi])
    subplot(2,2,2), plot(time, X(2,:),linespec);
    grid on
    hold on
    title(titles(2))
    axis([0 time(end) -pi pi])
    subplot(2,2,3), plot(time, X(3,:),linespec);
    grid on
    hold on
    title(titles(3))
    subplot(2,2,4), plot(time, X(4,:),linespec);
    grid on
    hold on
    title(titles(4))


    
    
end
