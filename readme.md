FILA Assignment 3

Note

1.  To generate results or reproduce using the startexperiment.sh please follow the below guidelines

    SARSA
        
        bash startexperiment.sh sarsa   50   500   0   0.9   0.5   0.9   accum
        ------------------------ algo---N-----NE---I---GAMMA-ALPHA-LAMBDA-TRACE
        where
            N = Number of times you want to run the experiment
            NE = Number of episodes in each experiment
            I = instance of problem

        The bash file provides default values for hyper paramenters giving best performance 
        so you only need to change algo,  N, NE, I

    Q Learning


        bash startexperiment.sh  ql  50   500   0   0.95   0.9
        ------------------------algo-N-----NE---I-----GAMMA---ALPHA
        where
            N = Number of times you want to run the experiment
            NE = Number of episodes in each experiment
            I = instance of problem

        The bash file provides default values for hyper paramenters giving best performance 
        so you only need to change algo,  N, NE, I


2. To reproduce the results of experimenting vith varying lambda and comparing Q Learning
    and SARSA you can directly run experiment1.sh bash file

    bash experiment1.sh

    (Please first empty the results folder to use generateGraphs.ipynb) 
    rm results/sarsa/* 
    rm results/ql/*

3. The code to plot the graph is in the jupyter-notebook "generateGraph.ipynb"
    
