function [ solution ] = Metropolis( spins1, spins2, H, Hparams, beta, timesteps )
%METROPOLIS Does Metropolis algorithm for two spin configurations in
%parallel and returns their overlap q

spin_config_1 = spins1;
spin_config_2 = spins2;

num_flips = 1; % Flips in each MonteCarlo step
Gamma = 1; % Base transition probability

for time = 1:timesteps

    newspin1 = flip_spin(spin_config_1, num_flips);
    newspin2 = flip_spin(spin_config_2, num_flips);
    
    p_1 = transition_probability(spin_config_1, newspin1, H, Hparams, beta, Gamma, 'Metropolis');
    p_2 = transition_probability(spin_config_2, newspin2, H, Hparams, beta, Gamma, 'Metropolis');
    
    x_1 = rand;
    x_2 = rand;
    
    if p_1 > x_1
        spin_config_1 = newspin1;
    end
    
    if p_2 > x_2
        spin_config_2 = newspin2;
    end
end

q = order_parameter(spin_config_1, spin_config_2);

if evaluate_energy(spin_config_1, H) < evaluate_energy(spin_config_2, H)
    optimal = spin_config_1;
else
    optimal = spin_config_2;
end

solution = {q, optimal};

end

