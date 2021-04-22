# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 11:43:29 2021

@author: swlon
"""

from IFFL_file import IFFL

class config:
    NOBJ = 2
    NVAR = 2
    MAXGEN = 700
    
    #optimization_bounds = [(1, 200), (1, 15)]
    optimization_bounds = [[1, 200], [1, 15]]
    initial_bounds = optimization_bounds
    def cost_function(f):
        return IFFL(f)
    
    
    
    
    Xpop = 4*NVAR
    subXpop = 2*NVAR
    scaling_factor = 0.5
    CR_rate = 0.9
    
    stop_size = 1500
    

#print(config.optimization_bounds[1][1])
#print(config.cost_function([1,1])[1])