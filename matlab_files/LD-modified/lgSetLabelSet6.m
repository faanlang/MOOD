% Function for customizing X-Y labels on Pareto Set Diagrams
% ii: the decision variable number
%
% Beta version
% (c) 2012 - CPOH
% Grupo de Control Predictivo y Optimizaci�n Heur�stica.
% Universitat Polit�cnica de Val�ncia - Spain.
% http://cpoh.upv.es
function lgSetLabelSet6(ii)



varNames = {'Km_CCgC','Km_BCgB','d_B','d_C','\gamma_1','\gamma_3','\gamma_4','\gamma_5', 'kp_B','kp_C'};
N = length(varNames);
Resort = [2 3 9 5 6 7 8 1 4 10]; 
varNames = varNames(Resort);

xlabel(['$' varNames{ii} '$'], 'fontname','Arial','fontsize',16,'Interpreter','latex');
ylabel('$\| \hat{J}(\theta)\|_2$','fontname','Arial','fontsize',16,'Interpreter','latex');

    
    % 
% if ii==1
%     xlabel('$Km_ACgA$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==2
%     xlabel('$Km_BCgB$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==3
%     xlabel('$Km_CCgC$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==4
%     xlabel('$k_d$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==5
%     xlabel('$d_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==6
%     xlabel('$d_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==7
%     xlabel('$d_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% % elseif ii==8
% %     xlabel('$Cg_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
% %     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% % elseif ii==9
% %     xlabel('$Cg_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
% %     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% % elseif ii==10
% %     xlabel('$Cg_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
% %     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==8
%     xlabel('$\theta_1$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==9
%     xlabel('$\theta_2$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==10
%     xlabel('$\theta_3$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==11
%     xlabel('$\theta_4$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==12
%     xlabel('$\theta_5$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==13
%     xlabel('$kp_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');   
% elseif ii==14
%     xlabel('$kp_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==15
%     xlabel('$kp_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==16
%     xlabel('$k_{-2}$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==17
%     xlabel('$k_{-3}$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==18
%     xlabel('$kd_2$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==19
%     xlabel('$kd_3$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==20
%     xlabel('$dm_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==21
%     xlabel('$dm_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex'); 
% elseif ii==22
%     xlabel('$dm_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');  
% elseif ii==23
%     xlabel('$d_I$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==24
%     xlabel('$dI_e$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex'); 
% elseif ii==25
%     xlabel('$d_{AI}$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex'); 
% elseif ii==26
%     xlabel('$d_{AI2}$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');  
% else %Default
%     eval(['xlabel(''\bf \theta' num2str(ii) ' (\theta' num2str(ii) ' units) '')']);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% end

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release



%%For 15 variables
% function lgSetLabelSet6(ii)
% 
% if ii==1
%     xlabel('$Km_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==2
%     xlabel('$Km_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==3
%     xlabel('$Km_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==4
%     xlabel('$k_d$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==5
%     xlabel('$d_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==6
%     xlabel('$d_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==7
%     xlabel('$d_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==8
%     xlabel('$Cg_A$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==9
%     xlabel('$Cg_B$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==10
%     xlabel('$Cg_C$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==11
%     xlabel('$\theta_1$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==12
%     xlabel('$\theta_2$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==13
%     xlabel('$\theta_3$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==14
%     xlabel('$\theta_4$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==15
%     xlabel('$\theta_5$', 'fontname','Arial','fontsize',16,'Interpreter','latex');
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% else %Default
%     eval(['xlabel(''\bf \theta' num2str(ii) ' (\theta' num2str(ii) ' units) '')']);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% end