%% Obtaining model based guidelines for the design of synthetic devices with robust performance. An adaptive network case.
%  An adaptive network case
%%
%  Institut d’Automática i Informática Industrial, Universitat Politècnica
%  de València, Spain.
% Industrial and Systems Engineering Graduate Program (PPGEPS), Pontifical 
% Catholic University of Parana (PUCPR), Curitiba, Brasil.
%  
%% Authors
% Yadira Boada (yaboa@upv.es)
% Gilberto Reynoso-Meza (gilreyme@upv.es)
% Jesús Picó (jpico@ai2.upv.es) 
% Alejandro Vignoni (vignoni@mpi-cbg.de)
% http://sb2cl.ai2.upv.es/
%
%%
%% Tutorial
%
% # spMODEparam.m  - Script to built the struct required for the
% optimization. Modify: - Objectives number, and - Number of decision variables
%dependig on your case.

% Run the spMODEparam file to build the variable "spMODEDat" with the
% variables required for the optimization.
%
spMODEparam;

spMODEDat
%
%%
% Previously prepare (or add to path) scripts:
  % # principal_func.m  - Script to set the parameters model (adaptation case). 
  % Returns the obtained Objectives.
  %
  % # model_3genes.m  - Script to set the 3 genes model (adaptation case).
  %
  % # model3genes_population.m  - Cost function definition (adaptation case). 
  %
%
%% Run optimization
% # spMODE.m  - The optimization algorithm. It needs # SphPruning.m - The spherial pruning mechanism.
% # CostFunction.m - Cost function definition.
% Now, a Pareto Front will be obtained using:
%
OUT=spMODE(spMODEDat)
%

%% Routine to plot the front and the sampling
% Data from the optimization (from this line: OUT=spMODE(spMODEDat))
load('OUT_spMODE_20150923T064630.mat')

% Data from the sampling: Execute Sampling2015.m for an example. 
load('Sampling20150703_1902.mat')

loglog(OUT.PFront(:,1),OUT.PFront(:,2),'b-')
 hold on;
 loglog(J(:,1),J(:,2),'ro')
 PFront_mc = PFilter_sinPSet(J,2);
 PFront_mc = sort(PFront_mc,1,'ascend');
 loglog(PFront_mc(end:-1:1,1),PFront_mc(:,2),'g-*')
 
 %% Pertinency
 
hold on
plot([1e-3 200],[20 20],'k--');
plot([1e-3 1e-3],[1e-3 20],'k--');
plot([1e-3 200],[1e-3 1e-3],'k--');
plot([200 200],[1e-3 20],'k--');

axis([1e-5 50 1e-3 1e5])



%% For the clustering

cd LD-modified
Clustering 

