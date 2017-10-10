# iterate over lambda values and
# and run the experiment

lambdas=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1)
Is=(0 1)
for i in ${Is[*]};
do
    echo "Started Sarsa instance {$i}"
    for l in ${lambdas[*]}; 
    do
        echo "Started Lambda = ${l} "
        bash startexperiment.sh sarsa 50 500 ${i} 0.9 0.5 ${l} accum
        echo "Ended Lambda = ${l} "
    done
    echo "Ended Sarsa instance {$i}"

    
    echo "Started Q-Learning instance {$i}"
    bash startexperiment.sh ql 50 500 ${i} 0.95 0.9
    echo "Ended Q-Learning instance {$i}"

done


# call the python script here to generate graphs after you write it
