function  [J1, J2] = objective_func_l(X,mode,colorr)
%objective_func Summary of this function goes here
%   This function evaluates the objective functions J1 and J2 by simulating
%   the ODEs in model_3genes.
%   Parameters
%   X:      is the vector containing the desicion variables.
%   mode:   is the mode of execution: - 'opt' is for optimization
%                                  - 'plot' is for visualization of time
%                                           course plots.
%   colorr: is the color of the plots, as [1 0 0] in RGB.

tic;

%Random parameters 
%YES = 1;        % On random function
NO = 0;         % Off random function

% Number of cells
Ncell = 1;      

% Set parameters 
KmACgA = X(1);              % transcription rate with (kmA.k1.RNApf)/(k_1 + kma) [1/min][nM] times plasmid concentration (4 to 70 plasmids. Remember 1.66 is to change from plasmid copy number to nM)
KmBCgB = X(2);              % transcription rate with kmB/(1+(k_7+kmB)/(k7.RNApf)) [1/min][nM] 
KmCCgC = X(1);              % transcription rate of genC [1/min]
kd = 0.06;                   % diffusion rate [0.01 - 0.1] of Ie inside cell [1/min]
k_d = 0.06; %kd;                   % diffusion rate [0.01 - 0.1] of I through cell membrane [1/min]
dA = 0.035;                  % degradation rate of protein A [1/min]
dB = X(3);                  % degradation rate of protein B [1/min]
dC = X(4);                  % degradation rate of protein C [1/min]

theta1 = X(5);
theta2 = 0.02;              %I fix this one, as is a non indentifiable thing. Entonces le doy valor uno
theta3 = X(6);        % y saco fctor comun theta2, entonces los falosres con los rangos anteriores
theta4 = X(7);        % pero los parametros nuevos quedan asi. (para no cambiar los randos anteriores)
theta5 = X(8);

kpA = 80;                   % Translation rate of genA [proteins/(mRNA.min)]
kpB = X(9);                   % Translation rate of genB [proteins/(mRNA.min)]
kpC = X(10);                   % Translation rate of genC [proteins/(mRNA.min)]

k_2 = 20;                   % dissociation rate AI [1/min]
k_3 = 1;                   % dissociation rate (AI)2 [1/min]
kd2 = 200;                   % dissociation constant of A to I [nM]
kd3 = 10;                   % dissociation constant of (AI)2 to promoter [nM]
k2 = k_2/kd2;
k3 = k_3/kd3;
 
dmA = 0.3624;                % degradation rate of genA mRNA [1/min]
dmB = 0.3624;                % degradation rate of genB mRNA [1/min]
dmC = 0.3624;                % degradation rate of genC mRNA [1/min]

dI = 0.0164;                % degradation rate of inducer [1/min]
dIe = 0.000282;               % degradation rate of external inducer [1/min]
dAI = 0.035;               % degradation rate of (AI) [1/min]
dAI2 = 0.035;              % degradation rate of (AI)2 [1/min]

% % Variables Initialization
% x1 = [];        % mRNA_A
% x2 = [];        % A protein
% x3 = [];        % I (inducer)
% x4 = [];        % (A.I)2
% x5 = [];        % mRNA_B
% x6 = [];        % B protein
% x7 = [];        % mRNA_C
% x8 = [];        % C protein
% x9 = [];        % Ie (external inducer)
% x10 = [];    % \abs{\dot{x_8}} for calculation of J1
% x11 = [];    % \abs{\dot{x_6}} for calculation of P

% %% Creating structure and model
RANDOM = NO;
k = 0.05;                % 20% from nominal value
% 
for i=1:Ncell
    param.KmACgA(i) = KmACgA*(1 + k*randn(1)*RANDOM);
    param.KmBCgB(i) = KmBCgB*(1 + k*randn(1)*RANDOM);
    param.KmCCgC(i) = KmCCgC*(1 + k*randn(1)*RANDOM);
    param.kpA(i) = kpA*(1 + k*randn(1)*RANDOM);
    param.kpB(i) = kpB*(1 + k*randn(1)*RANDOM);
    param.kpC(i) = kpC*(1 + k*randn(1)*RANDOM);
    param.k_2(i) = k_2*(1 + k*randn(1)*RANDOM);
    param.k_3(i) = k_3*(1 + k*randn(1)*RANDOM);
    param.kd2(i) = kd2*(1 + k*randn(1)*RANDOM);
    param.kd3(i) = kd3*(1 + k*randn(1)*RANDOM);
    param.k2(i) = k2*(1 + k*randn(1)*RANDOM);
    param.k3(i) = k3*(1 + k*randn(1)*RANDOM);
    param.kd(i) = kd*(1 + k*randn(1)*RANDOM);
    param.k_d(i) = k_d*(1 + k*randn(1)*RANDOM);
    param.dmA(i) = dmA*(1 + k*randn(1)*RANDOM);
    param.dmB(i) = dmB*(1 + k*randn(1)*RANDOM);
    param.dmC(i) = dmC*(1 + k*randn(1)*RANDOM);
    param.dA(i) = dA*(1 + k*randn(1)*RANDOM);
    param.dB(i) = dB*(1 + k*randn(1)*RANDOM);
    param.dC(i) = dC*(1 + k*randn(1)*RANDOM);
    param.dAI(i) = dAI*(1 + k*randn(1)*RANDOM);
    param.dAI2(i) = dAI2*(1 + k*randn(1)*RANDOM);
    param.dI(i) = dI*(1 + k*randn(1)*RANDOM);
    param.dIe(i) = dIe*(1 + k*randn(1)*RANDOM);
    param.theta1(i) = theta1*(1 + k*randn(1)*RANDOM);
    param.theta2(i) = theta2*(1 + k*randn(1)*RANDOM);
    param.theta3(i) = theta3*(1 + k*randn(1)*RANDOM);
    param.theta4(i) = theta4*(1 + k*randn(1)*RANDOM);
    param.theta5(i) = theta5*(1 + k*randn(1)*RANDOM);
end

if strcmp(mode,'opt')

    %Simulation parameters
    Tspan= [0 150 300];
    options = odeset('AbsTol',1e-6,'RelTol',1e-4);
elseif strcmp(mode,'plot')

    %Simulation parameters
    Tspan= [0 300];
    options = odeset('AbsTol',1e-5,'RelTol',1e-3); 
end

%% Input step (shot of AHL in nM)
input_step = 50;
DESTI = 800;                     % free load
% Variables Initial Conditions
InitC = zeros(13,1);
InitC((1:13:13*Ncell), 1) = KmACgA/dmA;
InitC((2:13:13*Ncell), 1) = KmACgA*kpA/(dmA*dA);
InitC((9:13:13*Ncell), 1) =  input_step;
InitC((12:13:13*Ncell), 1) = DESTI;
InitC((13:13:13*Ncell), 1) = 0;
param.K1 = 40;
param.K2 = 20;


%Model
[T,Y] = ode23s(@(t,x) model_3genes_l(t,x,Ncell,param),Tspan,InitC,options);

%Outputs
x1 = Y(:,1:13:13*Ncell)';
x2 = Y(:,2:13:13*Ncell)';
x3 = Y(:,3:13:13*Ncell)';
x4 = Y(:,4:13:13*Ncell)';
x5 = Y(:,5:13:13*Ncell)';
x6 = Y(:,6:13:13*Ncell)';
x7 = Y(:,7:13:13*Ncell)';
x8 = Y(:,8:13:13*Ncell)';
x9 = Y(:,9:13:13*Ncell)';
x10 = Y(:,10:13:13*Ncell)';
x11 = Y(:,11:13:13*Ncell)';
x12 = Y(:,12:13:13*Ncell)';
x13 = Y(:,13:13:13*Ncell)';


%% Output
if strcmp(mode,'opt')
    J1 = 2*input_step/(x10(end) - x10(1));
       
    J2 = (x8(end)-x8(1))/input_step;
                                 % B protein peak value: restriction
    MaxB = x11(end) - x11(1);

     % Penalty for B protein
    if MaxB > 10000
        J1 = J1 + 1000; 
        J2 = J2 + 1000; 
    elseif MaxB <= 1
        J1 = J1 + 1000; 
        J2 = J2 + 1000; 
    end
elseif strcmp(mode,'plot')
    J1 = 0;
    
    J2 = 0;
    
    plot(T,x8,'Color',colorr,'LineWidth',2);
end

tiempo = toc;
end
