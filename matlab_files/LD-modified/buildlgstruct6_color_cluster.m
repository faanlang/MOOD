function lgstruct=buildlgstruct6_color_cluster(pf,ps,norma,concept,Color_Map,Clusters)
%% Generate a struct 'lgstruct' for Graph Layer representation
%    pf: pareto front matrix
%    ps: pareto set matrix
%    norma: norm
%    concept: concept number for a design alternative
%%
%% Description of lgstruct:
%
% lgstruct.norma
% lgstruct.numind
% lgstruct.nobj
% lgstruct.npar
% lgstruct.maxpf
% lgstruct.minpf
% lgstruct.maxps
% lgstruct.minps
% lgstruct.slayer
% lgstruct.spf
% lgstruct.sps
% lgstruct.spc
% lgstruct.figuras
% lgstruct.axis
% lgstruct.pref
% lgstruct.selpoint
% lgstruct.layout
% lgstruct.worstpref
% lgstruct.concept
% lgstruct.Epstar
%%
%% Beta version 
% Copyright 2006 - 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es
%%
%% Please, cite Level Diagrams (LD) visualization as:
% [1] X. Blasco, J.M. Herrero, J. Sanchis, M. Martínez. 
% A new graphical visualization of n-dimensional Pareto front for 
% decision-making in multiobjective optimization. 
% Information Sciences 178 (2008) 3908–3924. doi:10.1016/j.ins.2008.06.010 

% [2] G. Reynoso-Meza, X. Blasco, J.Sanchis , J.M. Herrero. 
% A Comparison of Design concepts in Multi-Criteria Decision-Making using 
% Level Diagrams. Information Sciences 221 (2013) 124–141. 
% http://dx.doi.org/10.1016/j.ins.2012.09.049
%%
%% Please, check for new releases and bug fixing of this LD-Tool at:
% http://cpoh.upv.es
% and also at MatLab Central
% http://www.mathworks.com/matlabcentral/fileexchange/authors/44948
% http://www.mathworks.es/matlabcentral/fileexchange/authors/289050
%%
%% Default values
if nargin==2
    lgstruct.norma=2;
    disp('Using default value for norm (euclidean)')
    lgstruct.concept=ones(size(pf,1),1);
    disp('Using default value for design concept (1)')
elseif nargin==3
    lgstruct.concept=ones(size(pf,1),1);
    disp('Using default value for design concept (1)')
    lgstruct.norma=norma;
%elseif nargin>4
    %error('Too many parameters...')
elseif nargin<2
    disp('We require at least, a Pareto front and a Pareto Set')
else
    lgstruct.norma=norma;
    lgstruct.concept=concept;
        lgstruct.norma=2;
    disp('Using default value for norm (euclidean)')
    lgstruct.concept=ones(size(pf,1),1);
    disp('Using default value for design concept (1)')
end
%% Computing cardinality.
lgstruct.numind=size(pf,1);
lgstruct.nobj=size(pf,2);
lgstruct.npar=size(ps,2);

%% Pareto front normalization (from 0 to 1)
lgstruct.maxpf=max(pf);
lgstruct.minpf=min(pf);
maxpf=repmat(lgstruct.maxpf,lgstruct.numind,1);
minpf=repmat(lgstruct.minpf,lgstruct.numind,1);
norpf=(pf-minpf)./(maxpf-minpf);

lgstruct.maxps=max(ps);
lgstruct.minps=min(ps);

%% Computing distance to the ideal point, according the selected norm
% Each individual is asigned to a layer.
distancia=zeros(lgstruct.numind,1);
for i=1:lgstruct.numind
    distancia(i)=norm(norpf(i,:),lgstruct.norma);
end
%distancia = 1:82;
%% Individuals are sorted according the computed distance
% This value is recorded in slayer variable
[lgstruct.slayer,indices]=sort(distancia);
%This line reorders the Color Map, to match the J1 order.
lgstruct.pref=Color_Map(indices,:);
%This line reorders the Cluster, to match the J1 order.
lgstruct.slayer=Clusters(indices,:);

lgstruct.spf=pf(indices,:); %Pareto front is sorted
if sum(sum(isnan(ps)))>0%isempty(ps)
    lgstruct.sps=[];
    lgstruct.spsAux=ps(indices,:);
else
    lgstruct.sps=ps(indices,:); %Pareto set is sorted
    lgstruct.spsAux=[];
end
lgstruct.spc=lgstruct.concept(indices,:); %Pareto concept is sorted
lgstruct.Epstar=ones(size(pf,1),1);

%% Graph handling
lgstruct.figuras=[];
lgstruct.axis=[];
lgstruct.layout=[];
%lgstruct.pref=0;
lgstruct.selpoint=[];
lgstruct.worstpref=1;

%%
%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release