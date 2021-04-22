# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 16:41:41 2021

@author: swlon
"""

import numpy as np


def dominance_filter(j_front, x_set,config):
    Nobj = config.NOBJ
    Nvar = config.NVAR
    population_size = len(j_front)
    
    
    for j in range(0,population_size):
        dominated = False
        
        
        for compare in range(0,population_size):
            for objective in range(0,Nobj):
                if j_front[j][objective] > j_front[compare][objective]:
                    
                
    
    return(Xpop)
    

