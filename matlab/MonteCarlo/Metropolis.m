function [ solution ] = Metropolis( spins, Hparams, beta, timesteps, num_flips, Gamma )
%METROPOLIS Does Metropolis algorithm 
spin_config = spins;

for time = 1:timesteps
    newspins = spin_config;
    indices_to_flip = randperm(length(spin_config), num_flips).';
    for i = 1:length(indices_to_flip)
        flip_index = indices_to_flip(i);
        newspins(flip_index) = - spin_config(flip_index);
    end

    p = transition_probability(indices_to_flip, newspins, Hparams, beta, Gamma, 'Metropolis');
    
    x = rand;
       
    if p > x
        spin_config = newspins;
    end

end

solution = spin_config;

end

