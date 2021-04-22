function lg=classbycondition6(lg,cond)
% lg=classbycondition6(lg,cond)
% classifies by inequality condition on an objective
%   prefered value for an objective is under maxvalue
% cond=[numobjetif,maxvalue]
% 
% (c) cpoh 2006-2012

nobj=cond(1);
vmax=cond(2);
lg.pref=ones(lg.numind,1)*0.2;

%% Preferences definition
for i=1:lg.numind
    if lg.spf(i,nobj)>=vmax %this cpuld be modified to take in mind
        % any possible logic combination among Pareto set solution or
        % Pareto front objectives.
        lg.pref(i)=0.8;
    end
end
lg.worstpref=1;

%% includes sortbyobjective
[lg.pref,ix]=sort(lg.pref);
lg.spf=lg.spf(ix,:);
lg.sps=lg.sps(ix,:);
lg.spc=lg.spc(ix,:);
lg.slayer=lg.slayer(ix,:);

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release