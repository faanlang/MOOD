function lg=classbypreference6(lg,p)
%  lg=clasbypreference5(lg,p)
%     p : matrix with the ranges of preferences
%
% (c) cpoh 2012

% spref is the clasification according preference table 'p'

%% initialize
aux=zeros(lg.numind,lg.nobj);
lg.pref=zeros(lg.numind,1);
npuntos=size(p,2);

%% Vector value
valores=zeros(1,npuntos);
valores(2)=1;
if npuntos>=3
    for i=3:npuntos
        valores(i)=lg.nobj*valores(i-1)+1;
    end
end
lg.worstpref=valores(end)*lg.nobj;

%% Range according each preference
for i=1:lg.numind
    for j=1:lg.nobj
        k=2;
        while (k<=npuntos)&& (lg.spf(i,j)>p(j,k))
            aux(i,j)=aux(i,j)+1;
            k=k+1;
        end
    end
end

%% Preferences are determined
for i=1:lg.numind
    for j=1:lg.nobj
        lg.pref(i)=lg.pref(i)+ valores(aux(i,j)+1);
    end
end

%% includes sortbyobjective
[lg.pref,ix]=sort(lg.pref);
lg.spf=lg.spf(ix,:);
if max(lg.spc)==1
    lg.sps=lg.sps(ix,:);
end
lg.spc=lg.spc(ix,:);
lg.slayer=lg.slayer(ix,:);

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... Test Release
% 13/12/2012 ... Matlab Central Release
