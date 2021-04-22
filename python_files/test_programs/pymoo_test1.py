# -*- coding: utf-8 -*-
"""
Created on Mon Apr 19 17:40:54 2021

@author: swlon
"""


from pymoo.algorithms.nsga2 import NSGA2
from pymoo.factory import get_problem
from pymoo.optimize import minimize
from pymoo.visualization.scatter import Scatter
from pymoo.model.problem import Problem


class SphereWithConstraint(Problem):

    def __init__(self):
        super().__init__(n_var=10, n_obj=1, n_constr=1, xl=0, xu=1)

    def _evaluate(self, x, out, *args, **kwargs):
        out["F"] = np.sum((x - 0.5) ** 2, axis=1)
        out["G"] = 0.1 - out["F"]


problem = get_problem("SphereWithConstraint")



algorithm = NSGA2(pop_size=100)

res = minimize(problem,
               algorithm,
               ('n_gen', 200),
               seed=1,
               verbose=False)

plot = Scatter()
plot.add(problem.pareto_front(), plot_type="line", color="black", alpha=0.7)
plot.add(res.F, color="red")
plot.show()