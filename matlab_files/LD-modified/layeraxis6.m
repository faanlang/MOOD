function layeraxis6(lg,range)
%% layeraxis6(lg,range)
%  Set y-axis on the range for all subplot
% (c) cpoh 2012

for i=1:length(lg.axis)
    set(lg.axis(i),'YLim',range);
end

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release
