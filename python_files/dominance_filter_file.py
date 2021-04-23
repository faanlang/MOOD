# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 16:41:41 2021

@author: swlon
"""

import numpy as np

a = [[1,2],[1,5],[2,4],[3,3],[4,1],[2,1]]
b = [[1,2],[1,5],[2,4],[3,3],[4,1],[2,1]]

class vb:
    NOBJ = 2
    NVAR = 2

#


def dominance_filter(j_front, x_set,config):
    Nobj = config.NOBJ
    Nvar = config.NVAR
    population_size = len(j_front)
    PFront = np.zeros((population_size,Nobj))
    PSet = np.zeros((population_size,Nvar))
    k = 0
    
    
    for j in range(0,population_size):
        dominated = True
        
        for compare in range(0,population_size):
            if j !=  compare:
                for objective in range(0,Nobj):
                    if j_front[j][objective] > j_front[compare][objective]:
                        break
                    if objective == Nobj -1:
                        dominated = False
                            #print(j_front[j],j_front[compare])
                            #print('dominated')
        
        if dominated == False:
            
            
            
            PFront[k] = j_front[j]
            PSet[k] = x_set[j]
            k = k+1
                    
    PFront = PFront[:k]
    PSet = PSet[:k]
                
    
    return(PFront,PSet)

print(dominance_filter(a,b,vb))

