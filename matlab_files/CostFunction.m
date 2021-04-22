%% CostFunction.m 
% X   [IN] : Decision Variable Vector. X is a matrix with as many rows as
%            trial vector and as many columns as decision variables.
% Dat [IN] : Parameters defined in NNCparam.m
%
% X   [OUT]: Decision Variable Vector. X is a matrix with as many rows as
%            trial vector and as many columns as decision variables. Be
%            careful in modyfing. A modified population could be required
%            in some problems where a "fixing population rule" is applied.
% J  [OUT] : The objective Vector. J is a matrix with as many rows as
%            trial vectors in X and as many columns as objectives.
%
%%
%% Beta version 
% Copyright 2006 - 2012 - CPOH  
% Predictive Control and Heuristic Optimization Research Group
%      http://cpoh.upv.es
% ai2 Institute
%      http://www.ai2.upv.es
% Universitat Politècnica de València - Spain.
%      http://www.upv.es
%%
%% Author
% Gilberto Reynoso Meza
% gilreyme@upv.es
% http://cpoh.upv.es/en/gilberto-reynoso-meza.html
% http://www.mathworks.es/matlabcentral/fileexchange/authors/289050
%%
%% For new releases and bug fixing of this Tool Set please visit:
% http://cpoh.upv.es/en/research/software.html
% Matlab Central File Exchange
%%

%% Main call
function [J, X]=CostFunction(X,Dat)

if strcmp(Dat.CostProblem,'DTLZ2')
    [J, X] = DTLZ2(X,Dat);
elseif strcmp(Dat.CostProblem,'modelo3genes')
    % Here comes the call for a cost function of your own multi objective
    % problem.
    [J, X] = eval_obj_fun(X,Dat);
end

%% Mechanism to improve basic pertinency (Objective space bounded).
% For an example, please, refer to:
% G. Reynoso-Meza, J. Sanchis, X. Blasco, J.M. Herrero. Multiobjective
% evolutionary algorithms for multivariable PI controller design. Expert 
% Systems with Applications Volume 39, Issue 9, July 2012, Pages 7895–7907.

if isempty(Dat.Pertinency)
    %Nothing happens
else
    for xpop=1:size(J,1)
        PenUpper=0;
        PenLower=0;
        for nobj=1:size(J,2)
            PenUpper=PenUpper+...
                max((J(xpop,nobj)-Dat.Pertinency(nobj,2)),0)/...
                Dat.Pertinency(nobj,2);
            PenLower=PenLower+...
                max((Dat.Pertinency(nobj,1)-J(xpop,nobj)),0)/...
                Dat.Pertinency(nobj,2);
        end
        
        if PenUpper+PenLower>0
            Penalty=max(Dat.Pertinency(:,2))+PenUpper+PenLower;
            J(xpop,:)=Penalty*ones(1,size(J,2));
        end
    end
end
%%
%% DTLZ2 Benchmark function. Defined in:
% K. Deb, L. Tiele, M. Laummans, and E. Zitzler. Scalable test problems 
% for evolutionary multi-objective optimization. Institut fur Technische 
% Informatik und Kommunikationsnetze, ETH Zurich, Tech. Rep. TIK-Technical 
% Report No. 112, Feb. 2001.
function [J, X]=DTLZ2(X,Dat)

Xpop=size(X,1);
Nvar=Dat.NVAR;
M=Dat.NOBJ;
K=Nvar+1-M;
J=ones(Xpop,M);

for xpop=1:Xpop
    Gxm=(X(xpop,M:Nvar)-0.5*ones(1,K))*(X(xpop,M:Nvar)-0.5*ones(1,K))';
    Cos=cos(X(xpop,1:M-1)*pi/2);

    J(xpop,1)=prod(Cos)*(1+Gxm);
    for nobj=1:M-1
     J(xpop,nobj+1)=(J(xpop,1)/prod(Cos(1,M-nobj:M-1)))...
         *sin(X(xpop,M-nobj)*pi/2);
    end
end
%%
%% Write your own cost function here....


%% Release and bug report:
%
% November 2012: Initial release