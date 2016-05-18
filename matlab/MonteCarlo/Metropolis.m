function [ solution ] = Metropolis( spins, Hparams, beta, timesteps, num_flips, Gamma )
%METROPOLIS Does Metropolis algorithm 
spin_config = spins;

for time = 1:timesteps

    newspins = flip_spin(spin_config, num_flips);

    p = transition_probability(spin_config, newspins, Hparams, beta, Gamma, 'Metropolis');
    
    x = rand;
       
    if p > x
        spin_config = newspins;
    end
    
end

solution = spin_config;

end

