function lg=sParetoFilter6(lg,Histeresis,ConceptPref)
% Function for sPareto representation
%  lg=sParetoFilter6(lg,Histeresis,ConceptPref)
%  lg : structure with data for layer graph representation 
%       (see 'buildlgstruct' function)
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es

%% Separate design concepts
k1=0;
k2=0;
F1=lg.spf;
F2=lg.spf;
C1=lg.sps;
C2=lg.sps;
Epstar1=lg.Epstar;
Epstar2=lg.Epstar;
for raza=1:size(lg.spf,1)
    if lg.spc(raza,1)==1
        k1=k1+1;
        F1(k1,:)=lg.spf(raza,:);
        C1(k1,:)=lg.spsAux(raza,:);
        Epstar1(k1,1)=lg.Epstar(raza,:);
    elseif lg.spc(raza,1)==2
        k2=k2+1;
        F2(k2,:)=lg.spf(raza,:);
        C2(k2,:)=lg.spsAux(raza,:);
        Epstar2(k2,1)=lg.Epstar(raza,:);
    end
end

F1=F1(1:k1,:); Epstar1=Epstar1(1:k1,:); C1=C1(1:k1,:);
F2=F2(1:k2,:); Epstar2=Epstar2(1:k2,:); C2=C2(1:k2,:);

%% Select prefered concept

if nargin==2
    ConceptPref=1;
end

if ConceptPref==1
    Fp=F1;
    Fa=F2;
    Cp=C1;
    Ca=C2;
    Ep=Epstar1;
    Ea=Epstar2;
elseif ConceptPref==2
    Fp=F2;
    Fa=F1;
    Ca=C1;
    Cp=C2;    
    Ea=Epstar1;
    Ep=Epstar2;    
end


Xpop1=size(Fp,1);
Xpop2=size(Fa,1);
Nobj=size(Fa,2);

Jp=zeros(Xpop1,Nobj);
Ja=zeros(Xpop2,Nobj);
Xp=Cp;
Xa=Ca;

k=0;
for xpop1=1:Xpop1
    if Ep(xpop1,1)<=1+Histeresis
        k=k+1;
        Jp(k,:)=Fp(xpop1,:);
        Xp(k,:)=Cp(xpop1,:);
    end
end

Jp=Jp(1:k,:);
Xp=Xp(1:k,:);
ConceptP=ConceptPref*ones(size(Jp,1),1);

k=0;
for xpop2=1:Xpop2
    if Ea(xpop2,1)<=1+Histeresis
        k=k+1;
        Ja(k,:)=Fa(xpop2,:);
        Xa(k,:)=Ca(xpop2,:);
    end
end

Ja=Ja(1:k,:);
Xa=Xa(1:k,:);
if ConceptPref==1
    ConceptA=2*ones(size(Ja,1),1);
else
    ConceptA=ones(size(Ja,1),1);
end

lg=buildlgstruct6([Jp;Ja],[Xp;Xa],lg.norma,[ConceptP;ConceptA]);

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release
