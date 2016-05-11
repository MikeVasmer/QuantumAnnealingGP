function [ out ] = transverse_hamiltonian( n )

    % Pauli matrices
    sigmaX = [[0, 1] ;[ 1, 0]];
    iden   = [[1, 0] ;[ 0, 1]];
    % Single qubit transverse field
    H_b_single = 0.5*iden - 0.5*sigmaX;
    
    % Loops over all qubits
    for i=1:n
        if i==1
            out = recursive_kron( n, [i], [H_b_single] );
        else
            out = out + recursive_kron( n, [i], [H_b_single] );
        end
    end
    
end

