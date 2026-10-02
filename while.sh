n=1
while [ $n -le 5 ]; do
    echo "Iteration number $n"
    ((n+=1))
done


# retry.sh

#!/bin/bash

n=0
command=$1
while ! $command && [ $n -le 5 ]; do
        sleep $n
        ((n+=1))
        echo "Retry !$n"
done;
