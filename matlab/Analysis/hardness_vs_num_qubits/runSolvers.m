
reps = zeros(20,1);

for i = 1:20
    
    solution = findGroundState('2016_5_31_14_46_44.873715_numqubits_95_numloops_190_TTS_0.020059.mat', 'SimulatedAnnealing', 100, 0, 0.99, 0);
    reps(i) = solution{1};
end


reps

% getSolverTimes('/Users/wisedavid/Google Drive/UCL/Group_Project/QuantumAnnealingGP/matlab/Analysis/hardness_vs_num_qubits/files/2local-slightly-harder', 100, 10, 0.99);