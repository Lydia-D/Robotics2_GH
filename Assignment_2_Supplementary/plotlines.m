%% Plot lines
% L Drabsch

% Inputs: Lines = [a1,a2...an;b1,b2...bn]
%         Data = [xvec,yvec] for x domain and resolution requirements

function plotlines(Lines,Data,fighandle)
    
    % matrix with columns as sets of data for each line
    ylinefn = @(x,ab) x*ab(1,:) + ones(size(x))*ab(2,:); 
    
    figure(fighandle.Number)
    hold on
    plot(Data(:,1),ylinefn(Data(:,1),Lines))
    
end
    
    