function [ solution ] = HSimulation( Hparams, n_qubits, disorder, beta, timesteps, Monty )
%RANDOMHSIMULATION Finds the q value between 2 parallel runs of the
%simulation of a given
%Hamiltonian



%% Generate two different spin configurations with same disorder
sameConfig = 0;

while sameConfig == 0
    
    spins1 = generate_spins(n_qubits, disorder);
    spins2 = generate_spins(n_qubits, disorder);
    
    sameConfig = ~isequal(spins1, spins2);

end

switch Monty
    case 'Metropolis'
        solution = Metropolis(spins, Hparams, beta, timesteps, num_flips, Gamma);
    case 'HeatBath'
        solution = HeatBath(spins, Hparams, beta, timesteps, Gamma);
    otherwise
        disp('Enter valid Monte Carlo Algorithm')
end

