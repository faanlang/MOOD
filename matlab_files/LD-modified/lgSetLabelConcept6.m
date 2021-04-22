% Function for customizing X-Y labels on Concepts Diagrams
% ii: the objective number
%
% Beta version 
% (c) 2012 - CPOH  
% Grupo de Control Predictivo y Optimización Heurística.
% Universitat Politècnica de València - Spain.
% http://cpoh.upv.es


function lgSetLabelConcept6(ii)

if ii==-1
    xlabel(['\bf J_1 (\theta) :',sprintf('\n'),' Robust performance '],'fontname','Arial','fontsize',14);
    ylabel('$Q(J^i(\theta^i),J^*_{Pj})$','fontname','Arial','fontsize',16,'Interpreter','latex');
else %Default
    eval(['xlabel(''\bf J' num2str(ii) ' (J' num2str(ii) ' units) '')']);
    ylabel('$Q(J^i(\theta^i),J^*_{Pj})$','fontname','Arial','fontsize',16,'Interpreter','latex');
end

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release