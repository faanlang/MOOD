%% spMODEparam
% Generates the required parameters to run the spMODE optimization 
% algorithm.
%%
%% Beta version 
% Copyright 2006 - 2012 - CPOH  
%
% Predictive Control and Heuristic Optimization Research Group
%      http://cpoh.upv.es
%
% ai2 Institute
%      http://www.ai2.upv.es
%
% Universitat Polit�cnica de Val�ncia - Spain.
%      http://www.upv.es
%
%%
%% Author
% Gilberto Reynoso-Meza
% gilreyme@upv.es
% http://cpoh.upv.es/en/gilberto-reynoso-meza.html
% http://www.mathworks.es/matlabcentral/fileexchange/authors/289050
%%
%% For new releases and bug fixing of this Tool Set please visit:
% 1) http://cpoh.upv.es/en/research/software.html
% 2) Matlab Central File Exchange
%%
%% Overall Description
% This code implements a version of the multi-objective differential
% evolution algorithm with spherical pruning described in:
%
% Gilberto Reynoso-Meza, Javier Sanchis, Xavier Blasco, Miguel Mart�nez.
% Design of Continuous Controllers Using a Multiobjective Differential
% Evolution Algorithm with Spherical Pruning. Applications of Evolutionary 
% Computation. LNCS Volume 6024, 2010, pp 532-541.
% 
%%
%% Variables regarding the multi-objective problem

spMODEDat.NOBJ = 2;                  % Number of objectives

spMODEDat.NVAR = 10;                 % Number of decision variables

spMODEDat.mop  =...
    str2func('CostFunction');        % Cost Function

spMODEDat.CostProblem  = 'modelo3genes';    % Problem Instance
%spMODEDat.FieldD  = ...
%   [ x1_low x1_high; x2_low x2_high; ...
 
spMODEDat.FieldD  = ...
     [1 200; 1 200; ...            % KmACgC = KmACgC, KmBCgB
      0.01 0.3; 0.01 0.3;...       % dB, dC
      50 200; ...                 % theta1 = theta0_JP / theta1_JP
      0.0001 0.5; ...              % theta3
      0.0005 5; ...                % theta4
      1 100; ...                   % theta5  % Optimization bounds
      1 100; 1 100];               % kpB, kpC


spMODEDat.Initial = spMODEDat.FieldD;% Initialization bounds
%
%%
%% Variables regarding the optimization algorithm (Differential Evolution)

spMODEDat.Xpop = 4*spMODEDat.NVAR;   % Population size

spMODEDat.SubXpop=2*spMODEDat.NVAR;  % SubPopulation size

spMODEDat.ScalingFactor = 0.5;       % Scaling factor

spMODEDat.CRrate= 0.9;               % Croosover Probability
%
%%
%% Variables regarding spreading (spherical pruning)

spMODEDat.Strategy='SphP';           % 'Push' for a basic Dominance-based 
                                     % selection; 'SphP' for the spherical
                                     % pruning;
                                     
spMODEDat.Alphas=50;                 % Number of Arcs (Strategy='SphP').

spMODEDat.Norma='manhattan';         % Norm to be used in Strategy='SphP';
                                     % It could be 'eucliden', 'manhattan',
                                     % 'infinite'.
                                     
spMODEDat.StopSize=1500; %15000            % Maximum Pareto optimal solutions
                                     % required.
%
%%
%% Variables regarding convergence improving (elitism)

spMODEDat.CarElite = ...             % Solutions from the Approximated
    spMODEDat.SubXpop/2 - ...        % Pareto front in a generation
    spMODEDat.NOBJ;                  % to be merged with the population
                                     % in the evolution process.
%               
%%
%% Variables regarding basic pertinency (Bounds on objectives)
%
     %spMODEDat.Pertinency=[ 1 20000; 1e-4 20000]; 
     spMODEDat.Pertinency=[ 1e-3 200; 1e-4 20];             % Boundsfor two objectives Sensitivity and Precision
                                     % in the CostFunction. A row for each
                                     % objective, minimum and maximum
                                     % values desired. If empty, the
                                     % Pareto front approximated will be
                                     % unbounded. Please, refer to:
% G. Reynoso-Meza, J. Sanchis, X. Blasco, J.M. Herrero. Multiobjective
% evolutionary algorithms for multivariable PI controller design. Expert 
% Systems with Applications Volume 39, Issue 9, July 2012, Pages 7895�7907.
%
%%
%% Regarding Constraint Handling (different for objectives bound)
%
% Constraints could be defined as additional objectives. For an example
% please refer to:
%
% G. Reynoso-Meza, X. Blasco, J. Sanchis, M. Mart�nez. Multiobjective 
% optimization algorithm for solving constrained single objective problems.
% Evolutionary Computation (CEC), 2010 IEEE Congress on. 18-23 July 2010
%
% In such case, we encourage to define a pertinency vector (above).
%
%%
%% Execution Variables

     spMODEDat.MAXGEN = 0.7e3; %%1.0e3;              % Generation bound %0.7e3 (100 y 100 anda bien)

     spMODEDat.MAXFUNEVALS = 1.5e4; %3.0e4;        % Function evaluations bound %1.5e4

spMODEDat.PobInitial=[];            % Initial population (if any)

spMODEDat.SaveResults='yes';        % Write 'yes' if you want to 
                                    % save your results after the
                                    % optimization process;
                                    % otherwise, write 'no';

spMODEDat.Plotter='yes';            % 'yes' if you want to see some
                                    % a graph at each generation.

spMODEDat.SeeProgress='yes';         % 'yes' if you want to see some
                                    % information at each generation.
%
%%
%% Initialization (don't modify)

spMODEDat.CounterGEN=0;             % Counter for generations.

spMODEDat.CounterFES=0;             % Counter for function evaluations.
%
%%
%% Put here the variables required by your code (if any).

%matlabpool
%
%
%% Release and bug report:
%
% November 2012: Initial release

