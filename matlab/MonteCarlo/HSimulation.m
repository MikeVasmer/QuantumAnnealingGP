function [ q ] = HSimulation( H, n_qubits, disorder, T, timesteps )
%RANDOMHSIMULATION Finds the q value between 2 parallel runs of the
%simulation of a given
%Hamiltonian

%% Generate two different spin configurations with same disorder
sameConfig = 0;

while sameConfig == 0
    
    spins1 = generate_spins(n_qubits, disorder);
    spins2 = generate_spins(n_qubits, disorder);
    
    sameConfig = isequal(spins1, spins2);

end

q = Metropolis(spins1, spins2, H, T, timesteps);

end

