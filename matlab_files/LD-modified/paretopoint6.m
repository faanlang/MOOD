function [c,lg]=paretopoint6(lg,figura)
%% [c,lg]=paretopoint6(lg,figure)
%    Select a point in the figure and shows Pareto values.
%    Select the point with the mouse and press enter, the point
%    is shown in all subplots
%
% (c) cpoh 2012

figure(figura)
dobj=datacursormode(figura);
set(dobj,'DisplayStyle','window');
set(dobj,'Enable','on');
%waitforbuttonpress;
pause
info = getCursorInfo(dobj);
set(dobj,'Enable','off');


auxj=lg.slayer;
auxc=lg.Epstar;

% busca que en que eje se ha seleccionado el punto
x=find(lg.axis<info.Target,1,'last');
% busca los puntos que tiene la misma norma
info.Position(2)
indi=find(auxj==info.Position(2));
indi2=find(auxc==info.Position(2));

if figura==lg.figuras(1)
    xind=find(lg.spf(indi,x)==info.Position(1));
    c=indi(xind);
elseif figura==lg.figuras(2)
    xind=find(lg.sps(indi,x-lg.nobj)==info.Position(1));
    c=indi(xind);
elseif figura==lg.figuras(3)
    info.Position(1)
    %xind=find(lg.spc(indi2,1)==info.Position(1))    
    c=indi2;
    if info.Position(2)==1
        disp('Please, try again.')
        c=indi2(1);
    end
end


if isempty(lg.selpoint)
    % si no existe un punto seleccionado crea uno vacio
    lg.selpoint=zeros(1,lg.nobj+lg.npar);
else
    % si existe un punto seleccionado lo borra
    for i=1:(lg.nobj+lg.npar)
        delete(lg.selpoint(i));
    end
end
figure(lg.figuras(1))
for ii=1:lg.nobj
    eval(['subplot(' num2str(lg.layout(1)) ',' num2str(lg.layout(2)) ',' num2str(ii) ')'])
    hold on;
    lg.selpoint(ii)=plot(lg.spf(c,ii),auxj(c),'gs','LineWidth',2);
end

if isempty(lg.sps)
else
figure(lg.figuras(2))
for ii=1:lg.npar
    eval(['subplot(' num2str(lg.layout(3)) ',' num2str(lg.layout(4)) ',' num2str(ii) ')'])
    hold on;
    lg.selpoint(ii+lg.nobj)=plot(lg.sps(c,ii),auxj(c),'gs','LineWidth',2);
end
end

if max(lg.spc)==2
    figure(lg.figuras(3))
    for ii=1:lg.nobj
        eval(['subplot(' num2str(lg.layout(5)) ',' num2str(lg.layout(6)) ',' num2str(ii) ')'])
        hold on;
        lg.selpoint(ii)=plot(lg.spf(c,ii),auxc(c),'gs','LineWidth',2);
    end
end


disp('Selected point: ')
disp(num2str(c))
disp('Objetives:')
disp(num2str(lg.spf(c,:)))

if sum(sum(isnan(lg.sps)))>0 || isempty(lg.sps)
    disp('Theta:')
    disp(num2str(lg.spsAux(c,:)))
else
    disp('Theta:')
    disp(num2str(lg.sps(c,:)))
end

disp('Concept:')
disp(num2str(lg.spc(c,:)))

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release