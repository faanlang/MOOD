function lg=ParetoFilter6(lg,Pref)
% Function for Pareto front filtering; this function reduces and modify
% the current Pareto front.
%  lg : structure with data for layer graph representation 
%       (see 'buildlgstruct' function)
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es

F=lg.spf;
S=lg.sps;
C=lg.spc;
Fout=lg.spf;
Sout=lg.sps;
Cout=lg.spc;
k=0;

for raza=1:size(F,1)
    if F(raza,Pref(1,1))<=Pref(1,2)
        k=k+1;
        Fout(k,:)=F(raza,:);
        Cout(k,:)=C(raza,:);
        Sout(k,:)=S(raza,:);
    end
end

Fout=Fout(1:k,:);
Cout=Cout(1:k,:);
Sout=Sout(1:k,:);

lg=buildlgstruct6(Fout,Sout,lg.norma,Cout); %structure is modified

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release