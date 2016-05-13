function [ solution ] = HeatBath( spins1, spins2, H, Hparams, beta, timesteps )
%HEATBATH Implements Heat Bath Algorithm onto two replicas and returns q

spin_config_1 = spins1;
spin_config_2 = spins2;

Gamma = 1; % Base transition probability

for time = 1:timesteps

    spin_to_flip_1 = randi(length(spin_config_1));
    spin_to_flip_2 = randi(length(spin_config_2));
    
    newspin1 = spin_config_1;
    newspin2 = spin_config_2;
    
    newspin1(spin_to_flip_1) = - newspin1(spin_to_flip_1);
    newspin2(spin_to_flip_2) = - newspin2(spin_to_flip_2);
    
    p_1 = transition_probability(spin_to_flip_1, spin_config_1, H, Hparams, beta, Gamma, 'HeatBath');
    p_2 = transition_probability(spin_to_flip_2, spin_config_2, H, Hparams, beta, Gamma, 'HeatBath');
    
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
