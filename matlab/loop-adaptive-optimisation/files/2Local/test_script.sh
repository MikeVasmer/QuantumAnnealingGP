echo "Bash Version ${BASH_VERSION}..."
#for i in 10 20 30 40 50 60 70 80 90 100 125 150 175 200 225 250 275 300 325 350 375 400 425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800 825 850 875 900 925 950 975 1000
for i in 10 20 30 
do
   #mkdir "QuantumAnnealingGP/matlab/loop-adaptive-optimisation/files_Mike/2Local/30Qubits${i}Loops"
   mv -v *numqubits_30_numloops_${i}_* 30Qubits${i}Loops/             
done
