%% Sampling to compare with the spMODE results V.2015.July
clc;
close all;

%decisiion variables
X_random_lims = ...
     [1 200; 1 200; ...            % KmACgC = KmACgC, KmBCgB
      0.01 0.3; 0.01 0.3;...       % dB, dC
      200 500; ...                 % theta1 = theta0_JP / theta1_JP
      0.0001 0.5; ...              % theta3
      0.0005 5; ...                % theta4
      1 100; ...                   % theta5  % Optimization bounds
      1 100; 1 100];               % kpB, kpC

%Npoints = 13860;           % points of spMODE Pareto front 
Npoints = 2772;           % points of spMODE Pareto front dividido en 5 ejecuciones
Nvar = size(X_random_lims,1); 
Set = zeros(round(Npoints/100),Nvar);
J = zeros(Npoints,3); 
matlabpool;
 
%% Parameters of the model
tic
parfor j = 1: Npoints 

X_random = rand(10,1);
X = X_random_lims(:,1) + (X_random_lims(:,2)-X_random_lims(:,1)).*X_random;
%Set(j,:) = [X];  

% Our model
[j1, j2,b] = objective_func(X,'opt','r');
J(j,:)=[j1 j2 b];       % j1= sensitivity^-1, j2= precision  y max B

end
elapsed_time = toc 

eval(['save ''Sampling' datestr(now,'YYYYmmdd_HHMM') '.mat'' J elapsed_time']);


