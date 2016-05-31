#!/bin/bash

for i in {010..100}
    do        
    if (( $i % 5 == 0 ))           # no need for brackets
    then
        myNAME='_Qubits'
        myNAME=$i$myNAME
        mkdir $myNAME         
    fi
done

