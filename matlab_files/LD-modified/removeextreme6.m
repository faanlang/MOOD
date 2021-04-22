function lg=removeextreme5(lg,npoints)
% lg=removeextreme5(lg,npoints)
%
% Beta version 
% Copyright 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universidad Politécnica de Valencia - Spain.
% http://cpoh.upv.es

spfmod=lg.spf(1:(end-npoints),:);
spsmod=lg.sps(1:(end-npoints),:);
lg=buildlgstruct5(spfmod,spsmod,lg.norma);

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release