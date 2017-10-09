
# iterate over lambda values and
# and run the experiment


lambdas=(0.7)
Is=(0 1)

for i in ${Is[*]};
do
    echo "Started instance ${i}" 
    for l in ${lambdas[*]}; 
    do
        echo "Started Lambda = ${l} "
        bash startexperiment.sh sarsa 50 500 ${i} 0.95 0.9 ${l} accum 
        echo "Ended Lambda = ${l} "
    done
    echo "Ended instance ${i}" 
done
