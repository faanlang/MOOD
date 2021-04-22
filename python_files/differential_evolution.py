# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 13:55:41 2021

@author: swlon
"""
import numpy as np 
from numpy import random
from classconfig_file import config
#from dominance_filter_file import dominance_filter
x = config

def differential_evolution(config):
    Nobj = config.NOBJ
    Nvar = config.NVAR
    Xpop = config.Xpop
    initial_bounds = config.initial_bounds
    def evaluation(f):
        return config.cost_function(f)
    
    
    
     #Population initialization
    
    parent        = np.zeros((Xpop, Nvar))
    J_parent = np.zeros((Xpop, Nobj))

    for xpop in range(0,Xpop): #Uniform distribution
        for variable in range(0,Nvar):
            parent[xpop,variable] = initial_bounds[variable][0] +\
            (initial_bounds[variable][1] - initial_bounds[variable][0])*random.rand()
   
    
    for xpop in range(0,Xpop): #Uniform distribution
        J_parent[xpop] = evaluation(parent[xpop])
    
    
 
    

    FES    = Xpop      # Function Evaluations
    PFront = J_parent # The approximated Pareto Front
    PSet   = parent    # The approximated Pareto Set
    
    print(PFront)
    print(PFront[0])

# if size(spMODEDat.PobInitial,1) >= 1 % If we include members in the Pop.
#     InitialPS = spMODEDat.PobInitial;
#     InitialPF = mop(InitialPS,spMODEDat);
#     FES=FES+size(spMODEDat.PobInitial,1);
#     [PFront PSet spMODEDat] = ...
#         Dominance([PFront;InitialPF],[PSet;InitialPS],spMODEDat);
#             % Calling Dominance Filter
# else
#     [PFront PSet spMODEDat]=Dominance(PFront,PSet,spMODEDat);
#             %Calling Dominance Filter
# end

# if size(PFront,1)>1
#     spMODEDat.ExtremesPFront=[max(PFront);min(PFront)]; % Extremes
# end

# [AnchorsY, AnchorsX] = Look4Anchors(PFront,PSet);       % Anchor points
# spMODEDat.AnchorsY = AnchorsY;
# spMODEDat.AnchorsX = AnchorsX;
    
    
    
    
    
    
    
    
    
    
    print(parent)
    print(Nobj)
    
differential_evolution(x)