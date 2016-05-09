function [ out ] = ising_hamiltonian( h, J )

    % Check that each dimension of J must equal length(h)
    j_dim = size(J);
    if length(h) ~= j_dim(1) || length(h) ~= j_dim(2)
        error('Require: each dimension of J must equal length(h)');
    end

    % Pauli matrices
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    % Number of qubits
    n = length(h);
    
    % Sum up local field terms
    for i=1:n
        if i==1
            h_term = h(i)*recursive_kron( n, i, sigmaZ );
        else
            h_term = h_term + h(i)*recursive_kron( n, i, sigmaZ );
        end
    end
    
    % Boolean flag such that j_term can be initialised
    first_set = 1;
    % Sum up coupling terms
    for i=1:n
        for k=1:n
            % initialise j_term
            if first_set == 1
                % skip if i==k
                if i ~= k
                    first_set = 0;
                    j_term = J(i,k)*recursive_kron_double( n, i, sigmaZ, k, sigmaZ );
                end  
            else
                % skip if i==k
                if i ~= k
                    j_term = j_term + J(i,k)*recursive_kron_double( n, i, sigmaZ, k, sigmaZ );
                end 
            end
        end
    end
    
    % combine local and coupling components
    out = h_term + j_term;
end

