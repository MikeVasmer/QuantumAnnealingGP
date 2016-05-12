function [ out ] = ising_hamiltonian( h, Jzz, Jxx, Jzzz, Jxxx )

    % Pauli matrices
    sigmaX = [[0, 1] ;[ 1, 0]];
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    % Number of qubits
    n = max([length(h),length(Jzz),length(Jxx),length(Jzzz),length(Jxxx)]);
    
    % Sum up all the required terms
    h_term = 0;
    jzz_term = 0;
    jxx_term = 0;
    jzzz_term = 0;
    jxxx_term = 0;
    % Loop though dimension 1
    for i=1:n
        if length(h) > 1
            h_term = h_term + h(i)*recursive_kron( n, [i], [sigmaZ] );
        end
        % Loop though dimension 2
        for k=i+1:n
            if length(Jzz) > 1
                jzz_term = jzz_term + Jzz(i,k)*recursive_kron( n, [i,k], [sigmaZ,sigmaZ] );
            end
            if length(Jxx) > 1
                jxx_term = jxx_term + Jxx(i,k)*recursive_kron( n, [i,k], [sigmaX,sigmaX] );
            end
            % Loop though dimension 3
            for l=k+1:n
                if length(Jzzz) > 1
                    jzzz_term = jzzz_term + Jzzz(i,k,l)*recursive_kron( n, [i,k,l], [sigmaZ,sigmaZ,sigmaZ] );
                end
                if length(Jxxx) > 1
                    jxxx_term = jxxx_term + Jxxx(i,k,l)*recursive_kron( n, [i,k,l], [sigmaX,sigmaX,sigmaX] );
                end
            end 
        end
    end

    % combine local and coupling components
    out = h_term + jzz_term + jxx_term + jzzz_term + jxxx_term;
end

