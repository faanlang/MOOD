# -*- coding: utf-8 -*-
"""
Created on Tue Apr 20 14:57:34 2021

@author: swlon
"""


from platypus import NSGAII, Problem, Real
from costfunctionfile import cost_function
import matplotlib.pyplot as plt


problem = Problem(2, 2)
problem.types[:] = [Real(1, 200),Real(1, 15)]
problem.function = cost_function

algorithm = NSGAII(problem)
algorithm.run(5000)

plt.scatter([s.objectives[0] for s in algorithm.result],
            [s.objectives[1] for s in algorithm.result])
#plt.xlim([0, 1.1])
#plt.ylim([0, 1.1])
plt.xlabel("$J1$")
plt.ylabel("$J2$")
plt.show()