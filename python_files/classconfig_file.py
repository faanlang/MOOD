# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 11:43:29 2021

@author: swlon
"""

from IFFL_file import IFFL
import numpy as np 

class config:
    NOBJ = 2
    NVAR = 11
    MAXGEN = 300
    
    #optimization_bounds = [(1, 200), (1, 15)]
    optimization_bounds = [[1, 200],[1, 200],[1, 200], [1, 100],[1, 100],\
                           [0.01,0.3],[0.01,0.3],[50,200],[0.0001,0.5],[0.0005,5],[1,100]]
    initial_bounds = optimization_bounds
    def cost_function(f):
        return IFFL(f)
    
    
    
    
    Xpop = 30*NVAR
    subXpop = 2*NVAR
    scaling_factor = 0.5
    CR_rate = 0.9
    
    stop_size = 1500
    
    pertinency_bounds =np.array([[0, 2000],[0, 200]])
    #pertinency_bounds =np.array([])
    
    

#print(config.optimization_bounds[1][1])
#print(config.cost_function([1,1])[1])