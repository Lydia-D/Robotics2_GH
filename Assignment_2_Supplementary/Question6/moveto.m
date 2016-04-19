function moveto(x,y,t)
    eval(['sendCommand(t,''<x' num2str(x) ',y' num2str(y) '>\n'')'])	%Move to (0,390)
%     eval(['fprintf(t <x' num2str(x) ',y' num2str(y) '>\n'')'])
end