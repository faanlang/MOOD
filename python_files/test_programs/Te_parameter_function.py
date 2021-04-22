# -*- coding: utf-8 -*-
"""
Created on Fri Apr 16 16:32:30 2021

@author: swlon
"""

import tellurium as te
from tellurium import ParameterScan


def costfunction(variables):
    
    
    model = te.loada("""
    R'= alpha*R - beta*R*F
    F'= delta*R*F -gammx*F

    R = 500
    F = 150
    alpha = 0.04
    beta = 0.0005
    delta = 0.00005
    gammx = 0.2


        """)
  
    model.alpha = variables[0]
    model.beta = variables[1]
    
    model.simulate(0,500,1000,['time', 'R', 'F'])
    model.plot()
    
    return()

costfunction([0.4,0.0005])