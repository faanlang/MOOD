# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 16:41:41 2021

@author: swlon
"""
#KNOWN BUG: FILTERS OUT 2 OF THE SAME NON-DOMINATED SOLUTIONS
import numpy as np

# a = [[2,2],[1,5],[2,4],[4,1],[2,1],[3,3],[2,2]]
# b = [[55,2],[1,5],[2,4],[3,3],[4,1],[2,1],[1,1],[0,0],[2,2]]

class vb:
    NOBJ = 2
    NVAR = 2

#   1


def dominance_filter(j_front, x_set,config):
    Nobj = config.NOBJ
    Nvar = config.NVAR
    population_size = len(j_front)
    PFront = np.zeros((population_size,Nobj))
    PSet = np.zeros((population_size,Nvar))
    k = 0
    
    
    for j in range(0,population_size):
        dominated = False
        
        for compare in range(0,population_size):
            tracker = 0    
            tracker2 = 0
            if j !=  compare:
                
                for objective in range(0,Nobj):
                    
                    if j_front[compare][objective] <= j_front[j][objective]:
                        tracker = tracker + 1
                    if j_front[compare][objective] == j_front[j][objective]:
                        tracker2 = tracker2 + 1
                    
                    if tracker == Nobj:
                        dominated = True
                        if tracker2 ==Nobj:
                            print('potential error')
                            break
                
                
        if dominated == False:
            PFront[k] = j_front[j]
            PSet[k] = x_set[j]
            k = k+1
                    
    PFront = PFront[:k]
    PSet = PSet[:k]
    
            
    
    return(PFront,PSet)

#print(dominance_filter(a,b,vb))

