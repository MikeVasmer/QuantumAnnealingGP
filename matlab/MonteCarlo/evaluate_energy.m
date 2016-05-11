function [ E ] = evaluate_energy( spins, H )
%EVALUATE_ENERGY Evaluates energy of a spin configuration for some
%hamiltonian H

spin_config = spins(:);

% Cell array of state vectors corresponding to spins, (1,0) for up, (0,1) for down
state_vectors = cell(size(spin_config));
for i = 1:length(spin_config)
    
    if spin_config(i) == 1
        state_vector = [1;0];
    else
        state_vector = [0;1];
    end
    
    state_vectors{i} = state_vector;
end

% make kronecker product of spin states
config_vector = 1;
for i = 1:length(state_vectors)
    state_vector = state_vectors{i};
    config_vector = kron(state_vector, config_vector);
end

% Calculate energy
E = config_vector' * H * config_vector;

end

