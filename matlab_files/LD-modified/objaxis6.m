function objaxis6(lg,obj,range)
%% objaxis6(lg,obj,range)
%  set obj axis in range
%
% (c) cpoh 2012
if range(1)<lg.minpf(obj)
    range(1)=lg.minpf(obj);
    disp('Clipping to minimum range value')
end
if range(2)>lg.maxpf(obj)
    range(2)=lg.maxpf(obj);
    disp('Clipping to maximum range value')
end
set(lg.axis(obj),'XLim',range);

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release