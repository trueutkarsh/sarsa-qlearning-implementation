# demonstrates how to call the server and the client
# modify according to your needs


# first argument algo
# secondargument numepisode
# third argument instance of enviornment
# fourth argument of gamma
# fifth argument learning rate 
# sixth argument lambda





if [ ! -d "./results/"  ]; then
    mkdir results
fi


if [ "$1" == "sarsa" ]; then

    if [ ! -d "./results/sarsa"  ]; then
        mkdir "./results/sarsa"
    fi

    if [ -z "$2" ]; then
        N=10
    else 
        N=$2
    fi
    
    if [ -z "$3" ]; then
        NE=1000
    else 
        NE=$3
    fi
    
    
    if [ -z "$4" ]; then
        INSTANCE=0
    else 
        INSTANCE=$4
    fi
    
    
    
    if [ -z "$5" ]; then
        GAMMA=0.9
    else 
        GAMMA=$5
    fi
    
    
    
    if [ -z "$6" ]; then
        ALPHA=0.5
    else 
        ALPHA=$6
    fi
    
    
    
    if [ -z "$7" ]; then
        LAMBDA=0.9
    else 
        LAMBDA=$7
    fi
    
    
    
    if [ -z "$8" ]; then
        TRACE="accum"
    else 
        TRACE=$8
    fi

	for((n=0;n<$N;n++))
	do
	    echo "----------------    SARSA $SARSA $n    ------------------"
	    python3 ./server/server.py -port $((5000+$n)) -i $INSTANCE -rs $n -ne $NE -q | tee "results/sarsa/instance_${INSTANCE}_${TRACE}_lambda_${LAMBDA}_rs_${n}.txt" &
	    sleep 1
	    python3 ./client/client.py -port $((5000+$n)) -rs $n -gamma $GAMMA -algo sarsa -lambda $LAMBDA -trace $TRACE -a $ALPHA
	done
#	for((n=0;n<10;n++))
#	do
#	    echo "----------------    SARSA \0.2 $n    ------------------"
#	    python3 ./server/server.py -port $((6000+$n)) -i $INSTANCE -rs $n -ne $NE -q | tee "results/sarsa_accum_lambda0.2_rs$n.txt" &
#	    sleep 1
#	    python3 ./client/client.py -port $((6000+$n)) -rs $n -gamma $GAMMA -algo sarsa -lambda $LAMBDA -trace $TRACE 
#	done


elif [ "$1" == "ql" ]; then
   
   
    if [ ! -d "./results/ql"  ]; then
        mkdir "./results/ql"
    fi

    
    if [ -z "$2" ]; then
        N=10
    else 
        N=$2
    fi


    if [ -z "$3" ]; then
        NE=1600
    else 
        NE=$3
    fi
    
    
    if [ -z "$4" ]; then
        INSTANCE=0
    else 
        INSTANCE=$4
    fi
    
    
    
    if [ -z "$5" ]; then
        GAMMA=0.95
    else 
        GAMMA=$5
    fi
    
    
    if [ -z "$6" ]; then
        ALPHA=0.9
    else 
        ALPHA=$6
    fi
    
    
	for((n=0;n<$N;n++))
	do
	    echo "----------------    Q Learning $n    ------------------"
	    python3 ./server/server.py -port $((7010+$n)) -i $INSTANCE -rs $n -ne $NE -q | tee "results/ql/instance_${INSTANCE}_gamma_${GAMMA}_rs_${n}.txt" &

	    sleep 1
	    python3 ./client/client.py -port $((7010+$n)) -rs $n -gamma $GAMMA -algo ql -a $ALPHA
	done

elif [ "$1" == "random" ]; then


    if [ ! -d "./results/random"  ]; then
        mkdir "./results/random"
    fi


	for((n=0;n<10;n++))
	do
	    echo "----------------    Random $n    ------------------"
	    python3 ./server/server.py -port $((4200+$n)) -i $INSTANCE -rs $n -ne $NE -q | tee "results/random/instance_${INSTANCE}_rs_${n}.txt" &
	    sleep 1
	    python3 ./client/client.py -port $((4200+$n)) -rs $n -gamma $GAMMA -algo random -a $ALPHA
	done



else
    echo "Invalid Algo"
    
fi

