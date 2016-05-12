function [ E ] = evaluate_energy( spins, H )
%EVALUATE_ENERGY Evaluates energy of a spin configuration for some
%hamiltonian H

spin_config = spins(:);

% Transform 1,-1 to 0,1
spin_config = -spin_config;
spin_config = spin_config + 1;
spin_config = spin_config / 2;
spin_config = flipud(spin_config);

% Quantum state corresponding to classical state is all zeros, with a 1
% only in place represented by binary number encoded by spin_config above
state_index = b2d(spin_config) + 1; % add 1 due to matlab indexing
config_vector = zeros([2^(length(spin_config)), 1]);
config_vector(state_index) = 1;

% Calculate energy
E = config_vector' * H * config_vector;

end

