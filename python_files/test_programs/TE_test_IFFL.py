# -*- coding: utf-8 -*-
"""
Created on Thu Apr 15 13:05:33 2021

@author: Faan Langelaan

Tellurium implementation of Incoherent type 1 feed-forward loop (I1-FFL)
Based on matlab implementation bescribed in Boada (2016)

Plots concentration of protein C for different values of "tuning knob" kpC
Values for "optimization parameters" used are the low-end values of "cluster 1"

comments on parameters are by Boada
"""


import tellurium as te
from tellurium import ParameterScan

r = te.loada("""
             

// Initial Values of variables  
           
x1 = KmACgA/dmA             // mRNA_gA (mA)
x2 = KmACgA*kpA/(dmA*dA)    // A protein (A)
x3 = 0                      // Inducer (I)
x4 = 0                      // (A.I)_2 dimer (A.I)_2
x5 = 0                      // mRNA_gB (mB)
x6 = 0                      // B protein (B)
x7 = 0                      // mRNA_gC (mC)
x8 = 0                      // C protein (C)
x9 = 50                    // External I (I_e)


// Reactions




x1'=KmACgA - dmA*x1
x2'=kpA*x1-dA*x2-k2*x2*x3+k_2*(-(dAI+k_2)/(2*k3) + (1/(2*k3))*sqrt((dAI+k_2)^2+4*k3*(k2*x2*x3+2*k_3*x4)))
x3'= - k2*x2*x3+k_2*(-(dAI+k_2)/(2*k3) + (1/(2*k3))*sqrt((dAI+k_2)^2+4*k3*(k2*x2*x3+2*k_3*x4)))+kd*x9-k_d*x3-dI*x3
x4'=k3*(-(dAI+k_2)/(2*k3) + (1/(2*k3))*sqrt((dAI+k_2)^2+4*k3*(k2*x2*x3+2*k_3*x4)))^2-2*k_3*x4-dAI2*x4
x5'=KmBCgB*x4/(theta1+x4) - dmB*x5
x6'=kpB*x5-dB*x6
x7'=KmCCgC*(x4+beta1*x6+beta2*x4*x6)/(theta2+theta3*x4+theta4*x6+theta5*x4*x6) - dmC*x7
x8'=kpC*x7-dC*x8
x9'=- Vfactor*kd*x9+Vfactor*kd*x3-dIe*x9

x8 -> x8; 1                 //dummy reaction, so that Parameterscan can find x8
x9 -> x9; 1

//M is not used, but directly written in above ODE's (Tellurium doesnt update time-dependent algebraic rules)
//M = -(dAI+k_2)/(2*k3) + (1/(2*k3))*sqrt((dAI+k_2)^2+4*k3*(k2*x2*x3+2*k_3*x4)) // A.I monomer (A.I)

// Parameter Values

KmACgA = 1                 // transcription rate with (kmA.k1.RNApf)/(k_1 + kma) [1/min][nM] times plasmid concentration (4 to 70 plasmids. Remember 1.66 is to change from plasmid copy number to nM)
KmBCgB = 1                  // transcription rate with kmB/(1+(k_7+kmB)/(k7.RNApf)) [1/min][nM] 
KmCCgC = 1                  // transcription rate of genC [1/min]


kd = 0.06                   // diffusion rate [0.01 - 0.1] of Ie inside cell [1/min]
k_d = 0.06                  // diffusion rate [0.01 - 0.1] of I through cell membrane [1/min]
dA = 0.035                  // degradation rate of protein A [1/min]
dB = 0.01                   // degradation rate of protein B [1/min]
dC = 0.27                    // degradation rate of protein C [1/min]

theta1 = 78.93
theta2 = 0.02               // I fix this one, as is a non indentifiable thing. Entonces le doy valor uno
theta3 = 0.0001            // y saco fctor comun theta2, entonces los falosres con los rangos anteriores
theta4 = 0.0005           // pero los parametros nuevos quedan asi. (para no cambiar los randos anteriores)
theta5 = 1

kpA = 80                    // Translation rate of genA [proteins/(mRNA.min)]
kpB = 1                    // Translation rate of genB [proteins/(mRNA.min)]
kpC = 15                    // Translation rate of genC [proteins/(mRNA.min)]

k_2 = 20                    // dissociation rate AI [1/min]
k_3 = 1                     // dissociation rate (AI)2 [1/min]
kd2 = 200                   // dissociation constant of A to I [nM]
kd3 = 10                    //dissociation constant of (AI)2 to promoter [nM]
k2 = k_2/kd2
k3 = k_3/kd3

dmA = 0.3624                // degradation rate of genA mRNA [1/min]
dmB = 0.3624                // degradation rate of genB mRNA [1/min]
dmC = 0.3624                // degradation rate of genC mRNA [1/min]

dI = 0.0164                 // degradation rate of inducer [1/min]
dIe = 0.0164             // degradation rate of external inducer [1/min]
dAI = 0.035                 // degradation rate of (AI) [1/min]
dAI2 = 0.035                // degradation rate of (AI)2 [1/min]

b1 = 0.05
b2 = 0.05

beta1 = b1*theta4
beta2=b2*theta5

Vcell=1e-15                 // Ecoli volume
Ncells = 2.4e8*0.18        // Number of cells in OD = 0.3 -> 2.4e8 /mL
Vculture=180e-6            //Volume 180 microliters. 

Vfactor = (Vcell*Ncells/Vculture)


""")
r.kpC = 15
#r.reset()

# p = ParameterScan(r)

# p.endTime = 300
# p.numberOfPoints = 100
# p.polyNumber = 5
# p.startValue = 1
# p.endValue = 15
# p.value = 'kpC'
# p.selection = ['x8']
# p.xlabel = 'Time'
# p.ylabel = 'Concentration Protein C'

# p.plotGraduatedArray()



result = r.simulate(0, 100, 100,['time', 'x2','x3','x8','x9'])
# #print(result)
r.plot(result)