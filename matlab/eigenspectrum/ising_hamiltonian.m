function [ out ] = ising_hamiltonian( h, Jzz, Jxx, Jzzz, Jxxx )

    % Pauli matrices
    sigmaX = [[0, 1] ;[ 1, 0]];
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    % Number of qubits
    n = max([length(h),length(Jzz),length(Jxx),length(Jzzz),length(Jxxx)]);
    
    % Sum up local field terms, h
    h_term = 0;
    if length(h) > 1
        for i=1:n
            h_term = h_term + h(i)*recursive_kron( n, [i], [sigmaZ] );
        end
    end
    
    % Sum up Jzz coupling terms
    jzz_term = 0;
    if length(Jzz) > 1
        for i=1:n
            for k=i:n
                % skip if i==k
                if i ~= k
                    jzz_term = jzz_term + Jzz(i,k)*recursive_kron( n, [i,k], [sigmaZ,sigmaZ] );
                end 
            end
        end
    end
    
    % Sum up Jxx coupling terms
    jxx_term = 0;
    if length(Jxx) > 1
        for i=1:n
            for k=i:n
                % skip if i==k
                if i ~= k
                    jxx_term = jxx_term + Jxx(i,k)*recursive_kron( n, [i,k], [sigmaX,sigmaX] );
                end 
            end
        end
    end
    
    % Sum up Jzzz coupling terms
    jzzz_term = 0;
    if length(Jzzz) > 1
        for i=1:n
            for k=i:n
                for h=k:n
                    % skip if i==k or i==h or k==h
                    if (i ~= k) && (i ~= h) && (k ~= h)
                        jzzz_term = jzzz_term + Jzzz(i,k,h)*recursive_kron( n, [i,k,h], [sigmaZ,sigmaZ,sigmaZ] );
                    end
                end 
            end
        end
    end
    
    % Sum up Jxxx coupling terms
    jxxx_term = 0;
    if length(Jxxx) > 1
        for i=1:n
            for k=i:n
                for h=k:n
                    % skip if i==k or i==h or k==h
                    if (i ~= k) && (i ~= h) && (k ~= h)
                        jxxx_term = jxxx_term + Jxxx(i,k,h)*recursive_kron( n, [i,k,h], [sigmaX,sigmaX,sigmaX] );
                    end
                end 
            end
        end
    end

    % combine local and coupling components
    out = h_term + jzz_term + jxx_term + jzzz_term + jxxx_term;
end

