%% spMODEparam
% Generates the required parameters to run the spMODE optimization 
% algorithm.
%
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
%% Main Function
function OUT=spMODE(spMODEDat)
    %% Reading variables form spMODEDat

Generations   = spMODEDat.MAXGEN;       % Generations.
Xpop          = spMODEDat.Xpop;         % Population size.
SubXpop       = spMODEDat.SubXpop;      % SubPopulation Size.
Obj           = spMODEDat.NOBJ;         % Number of objectives.
Nvar          = spMODEDat.NVAR;         % Number of decision variables.

Limits        = spMODEDat.FieldD;       % Optimization Limits.
Initial       = spMODEDat.Initial;      % Initialization Limits.

ScalingFactor = spMODEDat.ScalingFactor;% Scaling Factor
CRrate        = spMODEDat.CRrate;       % Crossover rate
Strategy      = spMODEDat.Strategy;     % Strategy to prune

mop           = spMODEDat.mop;          % CostFunction


OUT.Ini       = datestr(now);

    %% Population initialization
    
Parent        = zeros(Xpop, Nvar);

for xpop=1:Xpop %Uniform distribution
    for nvar=1:Nvar
        Parent(xpop,nvar) = Initial(nvar,1) + ...
            (Initial(nvar,2) - Initial(nvar,1))*rand();
    end
end

[JxParent Parent] = mop(Parent,spMODEDat); %Calling CostFunction.m

FES    = Xpop;      % Function Evaluations
PFront = JxParent;  % The approximated Pareto Front
PSet   = Parent;    % The approximated Pareto Set

if size(spMODEDat.PobInitial,1) >= 1 % If we include members in the Pop.
    InitialPS = spMODEDat.PobInitial;
    InitialPF = mop(InitialPS,spMODEDat);
    FES=FES+size(spMODEDat.PobInitial,1);
    [PFront PSet spMODEDat] = ...
        Dominance([PFront;InitialPF],[PSet;InitialPS],spMODEDat);
            % Calling Dominance Filter
else
    [PFront PSet spMODEDat]=Dominance(PFront,PSet,spMODEDat);
            %Calling Dominance Filter
end

if size(PFront,1)>1
    spMODEDat.ExtremesPFront=[max(PFront);min(PFront)]; % Extremes
end

[AnchorsY, AnchorsX] = Look4Anchors(PFront,PSet);       % Anchor points
spMODEDat.AnchorsY = AnchorsY;
spMODEDat.AnchorsX = AnchorsX;


    %% Evolutionary Process

SubParent   = zeros(SubXpop,Nvar);
JxSubParent = zeros(SubXpop,Obj);

for n=1:Generations
    
        %% Selection of subpopulation
    
    revSubXpop=randperm(Xpop);
    refPFront=randperm(size(PFront,1));
    
    if strcmp(Strategy,'Push')
        Elite=0;
    else
        Elite=spMODEDat.CarElite+size(AnchorsX,1); % Anchor points are
                                                   % always used in the
                                                   % evolutionary process
    end
    
    SizeOld=0;
    
    if size(PFront,1)+size(AnchorsX,1) < Elite % If we have too few Pareto
                                               % optimal points.
        for subxpop=1:SubXpop-size(PFront,1)-size(AnchorsX,1)
            SubParent(subxpop,:)=Parent(revSubXpop(1,subxpop),:);
            JxSubParent(subxpop,:)=JxParent(revSubXpop(1,subxpop),:);
        end
        
        SubParent(SubXpop-size(PFront,1)-size(AnchorsX)+1:SubXpop,:) = ...
            [AnchorsX;PSet];
        JxSubParent(SubXpop-size(PFront,1)-size(AnchorsX)+1:SubXpop,:)= ...
            [AnchorsY;PFront];
        
        SizeOld=size(PFront,1)+size(AnchorsX,1);
        
    elseif size(PFront,1)+size(AnchorsX,1) >= Elite % If we have several
                                                    % Pareto optimal
                                                    % solutions, we select
                                                    % a few of them.
        for subxpop=1:SubXpop-Elite
            SubParent(subxpop,:)=Parent(revSubXpop(1,subxpop),:);
            JxSubParent(subxpop,:)=JxParent(revSubXpop(1,subxpop),:);
        end
        
        for subxpop=SubXpop-Elite+1:SubXpop-size(AnchorsX,1)
            SubParent(subxpop,:)=PSet(refPFront(1,subxpop-Elite),:);
            JxSubParent(subxpop,:)=PFront(refPFront(1,subxpop-Elite),:);
        end
        
        SubParent(SubXpop-size(AnchorsX,1)+1:end,:) = AnchorsX;
        JxSubParent(SubXpop-size(AnchorsX,1)+1:end,:) = AnchorsY;
        % Anchor points are always used in the optimization process!
        
    elseif Elite==0 % If spMODEDat.Strategy=='Push' (Basic MODE)
        for subxpop=1:SubXpop
            SubParent(subxpop,:)=Parent(revSubXpop(1,subxpop),:);
            JxSubParent(subxpop,:)=JxParent(revSubXpop(1,subxpop),:);
        end
    end
    
    Mutant  = zeros(SubXpop, Nvar);
    Child   = zeros(SubXpop, Nvar);
    JxChild = zeros(SubXpop,Obj);
    
        %% Differential Evolution algorithm
        
    for subxpop=1:SubXpop
        rev = randperm(SubXpop);
        Mutant(subxpop,:) = SubParent(rev(1,1),:) + ...
            ScalingFactor*(SubParent(rev(1,2),:)-SubParent(rev(1,3),:));
        
        for nvar=1:Nvar % Bounds are always preserved.
            if Mutant(subxpop,nvar) < Limits(nvar,1)
                Mutant(subxpop,nvar) = Limits(nvar,1);
            elseif Mutant(subxpop,nvar) > Limits(nvar,2)
                Mutant(subxpop,nvar) = Limits(nvar,2);
            end
        end
        
        flagCr=0; %Counter for �Child == Parent?
        if Nvar > 1
            for j=1:Nvar
                if rand() > CRrate
                    Child(subxpop,j) = SubParent(subxpop,j);
                else
                    Child(subxpop,j) = Mutant(subxpop,j);
                    flagCr=1;
                end
            end
        end
        
        if flagCr==0 % IF Child == Parent, we take at least one decision
                     % variable from the mutant.
            revCr=randperm(Nvar);
            Child(subxpop,revCr(1,1)) = Mutant(subxpop,revCr(1,1));
        end
        
        for nvar=1:Nvar % Bounds are always preserved.
            if Child(subxpop,nvar) < Limits(nvar,1)
                Child(subxpop,nvar) = Limits(nvar,1);
            elseif Child(subxpop,nvar) > Limits(nvar,2)
                Child(subxpop,nvar) = Limits(nvar,2);
            end
        end
            
    end
    
	[JxChild Child] = ...
            mop(Child,spMODEDat); %We evaluate the child
        
        FES=FES+size(JxChild,1);
	
	
	
    for subxpop=1:SubXpop % Pure dominance is used for selection process.
        if JxChild(subxpop,:) <= JxSubParent(subxpop,:)
            SubParent(subxpop,:) = Child(subxpop,:);
            JxSubParent(subxpop,:) = JxChild(subxpop,:);
        end
    end
    
    [PFront,PSet] = ... % Dominance Filter.
        Dominance([PFront; JxChild],[PSet; Child],spMODEDat);
    
    [AnchorsY, AnchorsX] = ... % Updating Anchors.
        Look4Anchors([AnchorsY;PFront],[AnchorsX;PSet]);
    
    spMODEDat.AnchorsY = AnchorsY;
    spMODEDat.AnchorsX = AnchorsX;
    
    if SizeOld>0 % Updating Population with new subpopulation
        for subxpop=1:SubXpop-SizeOld
            Parent(revSubXpop(1,subxpop),:)=SubParent(subxpop,:);
            JxParent(revSubXpop(1,subxpop),:)=JxSubParent(subxpop,:);
        end
    elseif SizeOld==0 && Elite>0
        for subxpop=1:SubXpop-Elite
            Parent(revSubXpop(1,subxpop),:)=SubParent(subxpop,:);
            JxParent(revSubXpop(1,subxpop),:)=JxSubParent(subxpop,:);
        end
    elseif Elite==0
        for subxpop=1:SubXpop
            Parent(revSubXpop(1,subxpop),:)=SubParent(subxpop,:);
            JxParent(revSubXpop(1,subxpop),:)=JxSubParent(subxpop,:);
        end
    end
    
    
    if strcmp(Strategy,'SphP') %Noting to prune in a basic MODE
        [PFront PSet spMODEDat] = SphPruning(PFront,PSet,spMODEDat);
    elseif strcmp(Strategy,'Push') % Spherical Pruning
        PFront = JxParent;
        PSet = SubParent;
    end
    
    if size(PFront,1)>spMODEDat.StopSize
        disp('Maximum number of solutions exceeded!')
        break;
    end
    
    % Updating output results
    OUT.PSet        = PSet;
    OUT.PFront      = PFront;
    OUT.SubParent   = SubParent;
    OUT.Parent      = Parent;
    OUT.JxParent    = JxParent;
    OUT.JxSubParent = JxSubParent;
    
    % Updating counter
    spMODEDat.CounterGEN = n;
    spMODEDat.CounterFES = FES;
    
    % Displaying information
    [OUT spMODEDat]=PrinterDisplay(OUT,spMODEDat);
    
    if FES>spMODEDat.MAXFUNEVALS || n>spMODEDat.MAXGEN
        disp('Finish.')
        break;
    end
    
end

if strcmp(Strategy,'Push')
    [PFront PSet spMODEDat] = Dominance(PFront,PSet,spMODEDat);
end

% Updating output results
OUT.PSet        = PSet;
OUT.PFront      = PFront;
OUT.SubParent   = SubParent;
OUT.Parent      = Parent;
OUT.JxParent    = JxParent;
OUT.JxSubParent = JxSubParent;
OUT.Param       = spMODEDat;
OUT.Fin         = datestr(now);

if strcmp(spMODEDat.SaveResults,'yes')
    save(['OUT_spMODE_' datestr(now,30)],'OUT'); %Results are saved
end

disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
if strcmp(spMODEDat.SaveResults,'yes')
    disp(['Check out OUT_' datestr(now,30) ...
          ' variable on folder for results.'])
end
disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')

%% Looking for Anchor points
function [AnchorsY, AnchorsX]=Look4Anchors(Y,X)

Xpop=size(Y,1);
Nobj=size(Y,2);
Nvar=size(X,2);

AnchorsX=zeros(Nobj,Nvar);
AnchorsY=zeros(Nobj,Nobj);

if size(Y,1)==1
    Jideal=Y;
else
    Jideal=min(Y);
end

for nobj=1:Nobj
    Habemus=0;
    for xpop=1:Xpop
        if Habemus==0
            if Y(xpop,nobj)==Jideal(1,nobj)
                AnchorsY(nobj,:)=Y(xpop,:);
                AnchorsX(nobj,:)=X(xpop,:);
                Habemus=1;
            end
        elseif Habemus==1
            if Y(xpop,nobj)==AnchorsY(nobj,nobj)
                if Y(xpop,:)<=AnchorsY(nobj,:)
                    AnchorsY(nobj,:)=Y(xpop,:);
                    AnchorsX(nobj,:)=X(xpop,:);
                end
            end
        end
    end
end

%% Dominance Filter
function [PFront PSet Dat]=Dominance(F,C,Dat)

Xpop=size(F,1);
Nobj=Dat.NOBJ;
Nvar=size(C,2);
PFront=zeros(Xpop,Nobj);
PSet=zeros(Xpop,Nvar);
k=0;

for xpop=1:Xpop
    Dominado=0; 
    
    for compare=1:Xpop
        if F(xpop,:)==F(compare,:)
            if xpop > compare
                Dominado=1;
                break;
            end
        else
            if F(xpop,:)>=F(compare,:)
                Dominado=1;
                break;
            end
        end
    end
    
    if Dominado==0
        k=k+1;
        PFront(k,:)=F(xpop,:);
        PSet(k,:)=C(xpop,:);
    end
end
PFront=PFront(1:k,:);
PSet=PSet(1:k,:);


Ordena =sortrows([PFront PSet],[Nobj+1:Nobj 1:Nobj]);
PFront = Ordena(:,1:Nobj);
PSet   = Ordena(:,Nobj+1:Nobj+Nvar);


%% Printer Display

function [OUT Dat]=PrinterDisplay(OUT,Dat)

if strcmp(Dat.SeeProgress,'yes')
    disp('------------------------------------------------')
    disp(['Generation: ' num2str(Dat.CounterGEN)]);
    disp(['Evaluations: ' num2str(Dat.CounterFES)]);
    disp(['Front size: ' mat2str(size(OUT.PFront,1))]);
    disp(['Minimum values: ' num2str(min(Dat.AnchorsY))]);
    disp('------------------------------------------------')
end
%save('OUT','OUT');

if strcmp(Dat.Plotter,'yes')
    F=[OUT.PFront;Dat.AnchorsY];
    if Dat.NOBJ==2
        plot(OUT.PFront(:,1),OUT.PFront(:,2),'dr'); grid on;
        pause(0.01)
    elseif Dat.NOBJ==3
        plot3(F(:,1),F(:,2),F(:,3),'dr'); grid on;
        pause(0.01)
    end
end
%%
%% Release and bug report:
%
% November 2012: Initial release