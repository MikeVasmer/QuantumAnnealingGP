function [ out ] = anneal_hamiltonian( H_b, H_p, s )
    
    % Calculate mid anneal hamiltonian 
    H = kron((1-s),H_b) + kron(s,H_p);
    
    % Return mid anneal hamiltonian
    out = H;
end

