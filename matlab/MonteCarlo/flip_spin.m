function [ spins ] = flip_spin( spin_config, num_flips )
%FLIP_SPIN Flips some number of spins in array

% Check number of flips less than or equal to number of qubits
if num_flips > length(spin_config)
    msgID = 'flip_spin:HighFlips';
    msg = 'Number of flips larger than number of qubits.';
    baseException = MException(msgID,msg);
    throw(baseException)
end

indices_to_flip = randperm(length(spin_config), num_flips).';
spins = spin_config;

for i = 1:length(indices_to_flip)
    
    flip_index = indices_to_flip(i);
    spins(flip_index) = - spins(flip_index);

end

end

