function lg=layergraph6(lg)
% Function for Layer Graph representation
%  lg=layergraph6(lg)
%  lg : structure with data for layer graph representation 
%       (see 'buildlgstruct' function)
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es

%%
% Auxiliar vector normalized distance
auxj=lg.slayer;
maxauxj=max(lg.slayer);

%% Pareto Front

% Computing shape of plot array
% gfsf : rows 
% gfsc : columns
if lg.nobj==3
    gfsf=1; 
    gfsc=3;
else
    gfs=sqrt(lg.nobj);
    gfsf=round(gfs);
    gfsc=gfsf;
    if gfsf^2<lg.nobj
        gfsc=gfsc+1;
    end
end
lg.layout=[gfsf gfsc];
%% Plot
lg.figuras=zeros(1,2);
lg.axis=[];
lg.figuras(1)= figure('Name','Pareto Front','Color',[1 1 1]);

% color map
% white color [1 1 1]
% black color [0 0 0]
if size(lg.pref,1)==lg.numind
%     if size(lg.pref,2)==3
     cm = lg.pref;  
%     else
%     cm=colormap(hot(40));
%     numcol=size(cm,1); %number of different color
%    end
end


for ii=1:lg.nobj
    eval(['subplot(' num2str(gfsf) ',' num2str(gfsc) ',' num2str(ii) ')'])
    lgSetLabelFront6(ii);
    hold on;
    for kk=lg.numind:-1:1
%         color=lg.pref(kk)/lg.worstpref;
%         color=round((numcol-1)*color+1);
%         color=cm(color,:);
  color=cm(kk,:);
        if lg.spc(kk,1)==1
            handlerPF(kk)=semilogx(lg.spf(kk,ii),auxj(kk),'MarkerSize',30,'Marker','.','LineStyle','none','MarkerEdgeColor',color);
        elseif lg.spc(kk,1)==2
            handlerPF(kk)=semilogx(lg.spf(kk,ii),auxj(kk),'o','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerSize',8);
        elseif lg.spc(kk,1)==3
            handlerPF(kk)=semilogx(lg.spf(kk,ii),auxj(kk),'o','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerSize',8);
        end      
    end
    
    %axis([lg.minpf(1,ii) lg.maxpf(1,ii) 0 maxauxj])
    lg.axis=[lg.axis;gca];
end

%% Pareto Set Ploting

% Computing shape of plot array
% gfsf : rows 
% gfsc : columns
if lg.npar==10
    gfsc=4;
    gfsf=3;
elseif lg.npar==1
    gfsc=2;
    gfsf=1;  
elseif lg.npar==24
    gfsc=6;
    gfsf=4;     
else    
    gfs=sqrt(lg.npar);
    gfsf=round(gfs);
    gfsc=gfsf;
    if gfsf^2<lg.npar
        gfsc=gfsc+1;
    end
end

lg.layout=[lg.layout gfsf gfsc]; 

% Ploting
if isempty(lg.sps)
    lg.figuras(2)= figure('Name','Pareto Set: No Comparable','Color',[1 1 1]);    
else
    lg.figuras(2)= figure('Name','Pareto Set','Color',[1 1 1]);
end

for ii=1:lg.npar
    if isempty(lg.sps)
    else
    
    eval(['subplot(' num2str(gfsf) ',' num2str(gfsc) ',' num2str(ii) ')'])
    lgSetLabelSet6(ii);
    hold on;
    for kk=lg.numind:-1:1
%         color=lg.pref(kk)/lg.worstpref;
%         color=round((numcol-1)*color+1);
%         color=cm(color,:);
        color=cm(kk,:);
        if lg.spc(kk,1)==1 && max(lg.spc)==1
            handlerPS(kk)=plot(lg.sps(kk,ii),auxj(kk),'MarkerSize',30,'Marker','.','LineStyle','none','MarkerEdgeColor',color);
        elseif lg.spc(kk,1)==2 && max(lg.spc)==1
            handlerPS(kk)=plot(lg.sps(kk,ii),auxj(kk),'.','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerSize',30);
        elseif lg.spc(kk,1)==3 && max(lg.spc)==1
            handlerPS(kk)=plot(lg.sps(kk,ii),auxj(kk),'.','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerSize',30);            
        end
    end
    if lg.minps(1,ii)==lg.maxps(1,ii)
        lg.minps(1,ii)=lg.minps(1,ii)-0.1;
        lg.maxps(1,ii)=lg.maxps(1,ii)+0.1;
    end

        axis([lg.minps(1,ii) lg.maxps(1,ii) 0 maxauxj])
        lg.axis=[lg.axis;gca];
    end
end
lg.selpoint=[];

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release