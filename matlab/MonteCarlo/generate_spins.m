function [ spins ] = generate_spins( n_qubits, disorder )
%GENERATE_SPINS makes vector of 1's and -1's of given disorder 

% Check disorder (number of 1's) less than or equal to number of qubits
if disorder > n_qubits
    msgID = 'generate_spins:HighDisorder';
    msg = 'Disorder larger than number of qubits.';
    baseException = MException(msgID,msg);
    throw(baseException)
end

my_ones = ones(disorder, 1);
my_minus_ones=  - ones(n_qubits - disorder, 1);

spins = [my_ones; my_minus_ones];
spins = transpose(spins);

% shuffle randomly
spins = spins(randperm(numel(spins)));

end

