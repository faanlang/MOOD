# -*- coding: utf-8 -*-
"""
Created on Mon Apr 19 16:25:54 2021

@author: swlon
"""


from costfunctionfile import costfunction
import autograd.numpy as anp

#costfunction([1,1])

from pymoo.algorithms.nsga2 import NSGA2
from pymoo.factory import get_problem, get_sampling, get_crossover, get_mutation
from pymoo.optimize import minimize
from pymoo.visualization.scatter import Scatter
from pymoo.model.problem import Problem


class IFFL(Problem):

    def __init__(self):
        super().__init__(n_var=2, n_obj=2, n_constr=0, 
                         xl=anp.array([1,1]), 
                         xu=anp.array([200,100]))

    def _evaluate(self, x, out, *args, **kwargs):
        
        f = costfunction([x[:,0],x[:,1]])
        out["F"] =anp.column_stack(f)
        






algorithm = NSGA2(pop_size=40)

res = minimize(IFFL(),
               algorithm,
               ('n_gen', 40),
               seed=1,
               verbose=True)

plot = Scatter()
plot.add(problem.pareto_front(), plot_type="line", color="black", alpha=0.7)
plot.add(res.F, color="red")
plot.show()