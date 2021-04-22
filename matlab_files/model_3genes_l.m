% 3 genes model for adaptation
function [dxdt] = model_3genes(t,x,Ncell,param)


% Volume of cells
Vcell=1e-15; % Ecoli volume
Ncells = 2.4e8*0.18; % Number of cells in OD = 0.3 -> 2.4e8 /mL
Vculture=180e-6; %Volume 180 microliters. 
    
 %basal de B
 a0 = 0; 
 %Basales de C
 %gC . RNAp (es la basal normal que tiene un activador, hay expresion aunque no haya presencia del transcription factor aque Activa)
 a1 = 0; 

 %gC B . RNAp ( Esa es la normal de un represor, hay expresion aunque este presente el TF represor, mas comunmente llamano leakines del promotor)
 b1 = 0.05;  %b1 = 0.0005;
 
 %gC B (AI)2 . RNAp (Esta sale del hibrido activador y represor y es cuando igual hay expresion aunque el represor este presente, pero cuanto tambien esta el activador ya unido al gC).
 b2 =  0.05;   %b2 = 0.0005;


for k = 1:Ncell
    m = 9*(k-1)+1;      % for loop from dx1 to dx8

%x1 = mRNA_A
dxdt(m,1) = param.KmACgA(k) - param.dmA(k).*x(m); 

%x2 = A
c1 = param.dAI(k) + param.k_2(k);
c2 = c1^2 + 8*param.k3(k)*(param.k2(k).*x(m+1).*x(m+2) + 2*param.k_3(k)*x(m+3));
c3 = 4*param.k3(k);
Vaux = (1/c3)*(-c1 + sqrt(c2));      % This is A.I
dxdt(m+1,1) = param.kpA(k).*x(m) - param.k2(k).*x(m+1).*x(m+2) + param.k_2(k).*Vaux  - param.dA(k).*x(m+1); 

%x3 = I
dxdt(m+2,1) = -param.k2(k).*x(m+1).*x(m+2) + param.k_2(k).*Vaux + param.kd(k).*x(m+8) - x(m+2)*(param.k_d(k) + param.dI(k));

%x4 = (AI)2
dxdt(m+3,1) = param.k3(k)*Vaux^2 - param.k_3(k).*x(m+3) - param.dAI2(k).*x(m+3);

%x5 = mRNA_B
%Basal de B, a0
dxdt(m+4,1) = param.KmBCgB(k).* ((x(m+3) + a0.*param.theta1(k))./(param.theta1(k) + x(m+3)))- param.dmB(k).*x(m+4);

%x6 = B
dxdt(m+5,1) = param.kpB(k).*x(m+4) - param.dB(k).*x(m+5);

%x7 = mRNA_C
c4 = param.theta2(k) + param.theta3(k)*x(m+3) + param.theta4(k)*x(m+5) + param.theta5(k)*x(m+3)*x(m+5);
%%% Basal de C (los a1, b1 y b2)
dxdt(m+6,1) = param.KmCCgC(k).*(( x(m+3) + a1.*param.theta2(k) + b1.*param.theta4(k)*x(m+5) + b2.*param.theta5(k)*x(m+3)*x(m+5)  )/c4 ) - param.dmC(k).*x(m+6);

%x8 = C
dxdt(m+7,1) = param.kpC(k).*x(m+6) - param.dC(k).*x(m+7) - param.K1.*x(m+7).*x(m+11) + param.K2.*x(m+12);

%x9 = Ie
dxdt(m+8,1) = - (Vcell*Ncells/Vculture).*param.kd(k).*x(m+8) + (Vcell*Ncells/Vculture).*param.k_d(k).*x(m+2) - param.dIe(k).*x(m+8);


%x10 is used to calculate J1 (protein C)
dxdt(m+9,1) = abs(param.kpC(k).*x(m+6) - param.dC(k).*x(m+7) - param.K1.*x(m+7).*x(m+11) + param.K2.*x(m+12));
%x10 is used to calculate P (protein B)
dxdt(m+10,1) = abs(param.kpB(k).*x(m+4) - param.dB(k).*x(m+5));


% Load
dxdt(m+11,1) = -param.K1.*x(m+7).*x(m+11)+param.K2.*x(m+12);

% C.Load
dxdt(m+12,1) = param.K1.*x(m+7).*x(m+11)-param.K2.*x(m+12);

end

% Diffusion will be here
end

