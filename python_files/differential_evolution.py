# -*- coding: utf-8 -*-
"""
Created on Wed Apr 21 13:55:41 2021

@author: swlon
"""
import math
import numpy as np 
import matplotlib.pyplot as plt
import matplotlib.ticker
from numpy import random
from numpy.random import default_rng
from classconfig_file import config
from dominance_filter_file import dominance_filter

x = config
rng = default_rng()

def differential_evolution(config):
    Nobj = config.NOBJ
    Nvar = config.NVAR
    pop_size = config.Xpop
    sub_pop_size = config.subXpop
    generations = config.MAXGEN
    initial_bounds = config.initial_bounds
    pertinency_bounds = config.pertinency_bounds
    
    scaling_factor = config.scaling_factor
    crossover_rate = config.CR_rate
    
    DEstratpopnumber  = 4
    
    def evaluation(f):
        return config.cost_function(f)
    
    proper_running = True
    while proper_running == True:
        print('START ALGORITHM')
    
         #Population initialization
        
        parent   = np.zeros((pop_size, Nvar))
        j_parent = np.zeros((pop_size, Nobj))
    
        for pop_member in range(0,pop_size): 
            for variable in range(0,Nvar):
                parent[pop_member,variable] = initial_bounds[variable][0] +\
                (initial_bounds[variable][1] - initial_bounds[variable][0])*random.rand()
       
        
        for pop_member in range(0,pop_size): 
            j_parent[pop_member] = evaluation(parent[pop_member])
        
        
        
        PFront = j_parent # The approximated Pareto Front
        PSet   = parent    # The approximated Pareto Set
        
        #print(PFront)
       
        #plt.scatter(PFront[:,0],PFront[:,1],linewidth=0.2,marker = "o", facecolor = 'none',edgecolor = 'darkorange',  label = 'A -')
        PFront, PSet = dominance_filter(PFront,PSet,x)
        #print(len(PFront))
        #plt.scatter(PFront[:,0],PFront[:,1])
        
                
        sub_pop_large_enough = True
        for n in range(0,generations):
            
            #create subpopulation
            sub_pop_size = config.subXpop
            #making sure the size of the subpopulation is not greater then the current PSet
            if len(PSet)<= sub_pop_size:
                
                #piece of code to make sure there always atleast 4 members in sub_pop
                #this numberis needed for the differential evolution strategy we use
                #if this isn't the case, restart the DE algorithm
                if len(PSet) < DEstratpopnumber:
                    sub_pop_large_enough = False
                    print('PSet is at: '+str(len(PSet))+' and hence not large enough' \
                        +' at generation: '+str(n))
                    break
                
                    
                sub_pop_size = len(PSet)
                sub_parent = PSet
                j_sub_parent = PFront
                
                
                    
                    
            # if this is not the case, take a rdm subset of the PSet
            else:
                
                sub_parent = np.zeros((sub_pop_size,Nvar))
                j_sub_parent = np.zeros((sub_pop_size,Nobj))
                print(len(PSet),sub_pop_size)
                
                numbers = rng.choice(len(PSet), size=sub_pop_size, replace=False)
                for c in range(0,sub_pop_size):
                    sub_parent[c] = PSet[numbers[c]]
                    j_sub_parent[c] = PFront[numbers[c]]
        

    
            print(sub_pop_size)
            mutant   = np.zeros((sub_pop_size, Nvar))
            child = np.zeros((sub_pop_size, Nvar))
            j_child = np.zeros((sub_pop_size, Nobj))
            
            for sub_member in range(0,sub_pop_size):
                #find 3 indexes not the same as target vector
                idxs = [idx for idx in range(sub_pop_size) if idx != sub_member] # (j = 0) 
                selected = np.random.choice(idxs, 3, replace=False)
                a,b,c = sub_parent[selected]
                #make mutant based of 3 other vectors
                mutant[sub_member] = a + scaling_factor*(b-c)
                
                
                #making sure the mutant does not exceed variable bounds
                for m_variable in range (0,Nvar):
                    if mutant[sub_member,m_variable]< initial_bounds[m_variable][0]:
                        mutant[sub_member,m_variable]= initial_bounds[m_variable][0]
                    elif mutant[sub_member,m_variable]> initial_bounds[m_variable][1]:
                        mutant[sub_member,m_variable]= initial_bounds[m_variable][1]
                
                #make the child based on parent and mutant
                cross_points = np.random.rand(Nvar) < crossover_rate
                #make sure there is at least one mutation
                if not np.any(cross_points):
                    cross_points[np.random.randint(0, Nvar)] = True
                    
                child[sub_member] = np.where(cross_points, mutant[sub_member], sub_parent[sub_member])
                
                j_child[sub_member] = evaluation(child[sub_member])
                
              
                    
            #add the children to the population
            big_front = np.concatenate((PFront, j_child))
            big_set = np.concatenate((PSet, child))
            
            
            #apply a pertinency filter
            #any J ouside the pertinency bounds for that objective, get penalised
            
            if pertinency_bounds.size !=0:
                print("pertinency")
                pen_up = 0
                pen_down = 0
                for jpop in range(0,len(big_front)):
                    for n_obj in range(0,Nobj):
                        pen_up = pen_up + max((big_front[jpop,n_obj]-pertinency_bounds[n_obj,1]),0)\
                                /pertinency_bounds[n_obj,1]
                        pen_down = pen_down + max((-pertinency_bounds[n_obj,0]-big_front[jpop,n_obj]),0)\
                                /pertinency_bounds[n_obj,1]
                    
                    if pen_up + pen_down >0:
                        penalty = max(pertinency_bounds[:,1])+pen_up+pen_down
                        big_front[jpop,:] = np.full((1,Nobj),penalty)
                
           
        
        #update PFront, Pset by applying a dominance filter to PFront
        #in this step parent should be rejected if child is better, and vice verca
            PFront, PSet = dominance_filter(big_front,big_set,x)
        
        
        #if the sub population wasn't large enough, return to start of algorithm
        if sub_pop_large_enough == False:
            continue
        
        
        
        # Level Diagnostics
        # plot per objective 
        norm = np.zeros((len(PFront)))
        min_pf = np.amin(PFront, axis=0)
        max_pf = np.amax(PFront, axis=0)
        
        for solution in range(0,len(PFront)):
            quadratic = 0
            for objective in range(0,Nobj):
                normalised_distance = (PFront[solution,objective]-min_pf[objective])\
                                        /(max_pf[objective]-min_pf[objective])
                quadratic = quadratic + (normalised_distance)**2
            norm[solution] = math.sqrt(quadratic)
        
        idx_min_norm = np.argmin(norm)
        #cluster_threshold = np.zeros((Nobj))
        
        #the cluster threshold is the objective value of the solution
        #closest to the ideal solution
        cluster_objective = 0
        cluster_threshold = PFront[idx_min_norm,cluster_objective]
        
        #set up 2 clusters
        cluster_2= np.zeros(len(PFront))
        cluster_1= np.zeros(len(PFront))
        
        k = 0
        m = 0
        #write down which indices of PFront (and PSet) belong to which cluster
        for solution_index in range(0,len(PFront)):
            if PFront[solution_index,cluster_objective] > cluster_threshold:
                cluster_2[k]= solution_index #bad first objective value so goes to cluster 2
                k = k+1
            else:
                cluster_1[m] = solution_index
                m = m+1
        
        cluster_2 = cluster_2[:k]
        cluster_1 = cluster_1[:m]
        
        print(cluster_2)
        print(cluster_1)
        
        values_cluster_2 = PFront[cluster_2.astype(int)]
        values_cluster_1 = PFront[cluster_1.astype(int)]
        norm_cluster_2 = norm[cluster_2.astype(int)]
        norm_cluster_1 = norm[cluster_1.astype(int)]
        
        
        parameters_cluster_2 = PSet[cluster_2.astype(int)]
        parameters_cluster_1 = PSet[cluster_1.astype(int)]
        
        array1 = np.full(len(cluster_1),1)
        array2 = np.full(len(cluster_2),2)
        
        for plotted_objective in range(0,Nobj):
            plt.figure()
            plt.scatter(values_cluster_2[:,plotted_objective], norm_cluster_2)
            plt.scatter(values_cluster_1[:,plotted_objective], norm_cluster_1, color = 'red')
            plt.xlabel(r'$J_{}$'.format(plotted_objective+1)+r'$(\theta$)')
            plt.ylabel(r'$||\hat{J}(\theta)||$')
            plt.savefig('Level_diagram_J'+str(plotted_objective+1)+ '.pdf')    
            plt.show()
            
        for plotted_parameter in range(0,Nvar):
            plt.figure()
            plt.scatter(parameters_cluster_2[:,plotted_parameter], array2)
            plt.scatter(parameters_cluster_1[:,plotted_parameter], array1, color = 'red')
            plt.xlabel(r'$P_{}$'.format(plotted_parameter))
            plt.ylabel('cluster')
            plt.savefig('Level_diagram_P'+str(plotted_parameter)+ '.pdf')    
            plt.show()
            
       
        
        
        fig, ax = plt.subplots()
        ax.loglog()
        ax.scatter(PFront[:,0],PFront[:,1])
        ax.set_ylim(0.001,1000)
        ax.set_xlim(0.0001,100)
        
        
        
        #plt.yscale('log')
        #ax.set_xticks([0,0.0001,0.001,0.01,0.1,1])
        #ax.get_xaxis().set_major_formatter(matplotlib.ticker.ScalarFormatter())
        #plt.yticks([0,1,10,100,1000,10000])
        #plt.set_major_locator
        
        
        ax.set_xlabel(r'$J_{1}(\theta)$')
        ax.set_ylabel(r'$J_{2}(\theta)$')
        fig.savefig('Pareto_Front'+str(generations)+ '.pdf')    
        plt.show()
        print(len(PFront))
        
        proper_running = False
    
    
    #print(parent)
    #print(Nobj)  
    

differential_evolution(x)
