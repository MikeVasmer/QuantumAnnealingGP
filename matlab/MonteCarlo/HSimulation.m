function [ q ] = HSimulation( H, Hparams, n_qubits, disorder, beta, timesteps, Monty )
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
        q = Metropolis(spins1, spins2, H, beta, timesteps);
    case 'HeatBath'
        [{h}, Jzz, Jxx, Jzzz, Jxxx] = deal(Hparams{:});
        q = HeatBath(spins1, spins2, H, h, Jzzz, beta, timesteps);
    otherwise
        disp('Enter valid Monte Carlo Algorithm')
end

