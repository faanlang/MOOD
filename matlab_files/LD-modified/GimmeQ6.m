function [Epstar1 Epstar2]=GimmeQ6(F1,F2)
%% Auxiliary Function for Q computation
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es

%% See paper for details:
% [2] G. Reynoso-Meza, X. Blasco, J.Sanchis , J.M. Herrero. 
% A Comparison of Design concepts in Multi-Criteria Decision-Making using 
% Level Diagrams. Information Sciences 221 (2013) 124–141. 
% http://dx.doi.org/10.1016/j.ins.2012.09.049
%%

Xpop1=size(F1,1);
Xpop2=size(F2,1);

Epstar1=zeros(Xpop1,1);
Epstar2=zeros(Xpop2,1);
Eps1=zeros(Xpop2,1);
Eps2=zeros(Xpop1,1);

for xpop1=1:Xpop1
    parfor xpop2=1:Xpop2
        Ie1=max(F1(xpop1,:)./F2(xpop2,:));
        Ie2=max(F2(xpop2,:)./F1(xpop1,:));
        if Ie1>1 && Ie2>1
            Eps1(xpop2,1)=1;
        elseif Ie1==1 && Ie2>1
            Eps1(xpop2,1)=1-eps;
        else
            Eps1(xpop2,1)=Ie1;
        end
    end
    Eps1=sortrows(Eps1);
    Epstar1(xpop1,1)=1;
    for xpop2=1:Xpop2
        if Eps1(xpop2,1)==1
            
        else
            Epstar1(xpop1,1)=Eps1(xpop2,1);
            break;
        end
    end
end

for xpop2=1:Xpop2
    parfor xpop1=1:Xpop1
        Ie1=max(F1(xpop1,:)./F2(xpop2,:));
        Ie2=max(F2(xpop2,:)./F1(xpop1,:));
        if Ie1>1 && Ie2>1
            Eps2(xpop1,1)=1;
        elseif Ie1>1 && Ie2==1
            Eps2(xpop1,1)=1-eps;
        else
            Eps2(xpop1,1)=Ie2;
        end
    end
    Eps2=sortrows(Eps2);
    Epstar2(xpop2,1)=1;
    for xpop1=1:Xpop1
        if Eps2(xpop1,1)==1
            
        else
            Epstar2(xpop2,1)=Eps2(xpop1,1);
            break;
        end
    end
end

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release
