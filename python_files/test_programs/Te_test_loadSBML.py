# -*- coding: utf-8 -*-
"""
Created on Thu Apr 15 11:32:26 2021

@author: swlon
"""


import tellurium as te

# Load model from biomodels (may not work with https).
r = te.loadSBMLModel("BIOMD0000000696_url.xml")
result = r.simulate(0, 300, 1000)
r.plot(result)