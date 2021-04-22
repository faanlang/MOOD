% Function for customizing X-Y labels on Pareto Front Diagrams
% ii: the objective number
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimizaci�n Heur�stica.
% Universitat Polit�cnica de Val�ncia - Spain.
% http://cpoh.upv.es

function lgSetLabelFront6(ii)

if ii==1
    xlabel(['\bf J_1 (\theta) :',sprintf('\n'),' Sensitivity (peak heigth inverse)'],'fontname','Arial','fontsize',14);
    ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
elseif ii==2
    xlabel(['\bf J_2 (\theta) :',sprintf('\n'),' Absolute error '],'fontname','Arial','fontsize',14);
    ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
elseif ii==3
    xlabel(['\bf J_3 (\theta) :',sprintf('\n'),' Inverse Total Variation B protein '],'fontname','Arial','fontsize',14);
    ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
    
else %Default
    eval(['xlabel(''\bf J' num2str(ii) ' (J' num2str(ii) ' units) '')']);
    ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
end

% For 4 J
% if ii==1
%     xlabel(['\bf J_1 (\theta) :',sprintf('\n'),' Exist Maximum '],'fontname','Arial','fontsize',14);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==2
%     xlabel(['\bf J_2 (\theta) :',sprintf('\n'),' ITAE '],'fontname','Arial','fontsize',14);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==3
%     xlabel(['\bf J_3 (\theta) :',sprintf('\n'),' Total Variation '],'fontname','Arial','fontsize',14);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% elseif ii==4
%     xlabel(['\bf J_4 (\theta) :',sprintf('\n'),' Integral derivative (back to 0) '],'fontname','Arial','fontsize',14);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% else %Default
%     eval(['xlabel(''\bf J' num2str(ii) ' (J' num2str(ii) ' units) '')']);
%     ylabel('$\| \hat{J}(\theta)\|_i$','fontname','Arial','fontsize',16,'Interpreter','latex');
% end

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release