function [ solution ] = HeatBath( spins, Hparams, beta, timesteps, Gamma )
%HEATBATH Implements Heat Bath Algorithm

spin_config = spins;


for time = 1:timesteps

    spin_to_flip = randi(length(spin_config));
    
    newspin = spin_config;
    
    newspin(spin_to_flip) = - newspin(spin_to_flip);
    
    p = transition_probability(spin_to_flip, spin_config, Hparams, beta, Gamma, 'HeatBath');
    
    x = rand;
    
    if p > x
        spin_config = newspin;
    end
    
end

solution = spin_config;

end

