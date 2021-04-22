function paraxis6(lg,par,range)
%% paraxis5(lg,par,range)
%   set parameter axis to range
%
% (c) cpoh 2012

if range(1)<lg.minps(par)
    range(1)=lg.minps(par);
    disp('Clipping to minimum range value')
end
if range(2)>lg.maxps(par)
    range(2)=lg.maxps(par);
    disp('Clipping to maximum range value')
end
set(lg.axis(lg.nobj+par),'XLim',range);
%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release