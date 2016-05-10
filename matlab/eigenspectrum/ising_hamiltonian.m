function [ out ] = ising_hamiltonian( h, Jzz, Jxx, Jzzz, Jxxx )

    % Check that each dimension of all J's equal length(h)
    jzz_dim  = size(Jzz);
    jxx_dim  = size(Jxx);
    jzzz_dim = size(Jzzz);
    jxxx_dim = size(Jxxx);
    if  ( length(Jzz)>1  && ( length(h) ~= jzz_dim(1)  || length(h) ~= jzz_dim(2) ) ) || ...
        ( length(Jxx)>1  && ( length(h) ~= jxx_dim(1)  || length(h) ~= jxx_dim(2) ) ) || ...
        ( length(Jzzz)>1 && ( length(h) ~= jzzz_dim(1) || length(h) ~= jzzz_dim(2) || length(h) ~= jzzz_dim(3) ) ) || ...
        ( length(Jxxx)>1 && ( length(h) ~= jxxx_dim(1) || length(h) ~= jxxx_dim(2) || length(h) ~= jzzz_dim(3) ) )
        error('Require: each dimension of J must equal length(h), unless that J is turned off (=0)');
    end

    % Pauli matrices
    sigmaX = [[0, 1] ;[ 1, 0]];
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    % Number of qubits
    n = length(h);
    
    % Sum up local field terms, h
    h_term = 0;
    for i=1:n
        h_term = h_term + h(i)*recursive_kron( n, i, sigmaZ );
    end
    
    % Sum up Jzz coupling terms
    jzz_term = 0;
    if length(Jzz) > 1
        for i=1:n
            for k=1:n
                % skip if i==k
                if i ~= k
                    jzz_term = jzz_term + Jzz(i,k)*recursive_kron_double( n, i, sigmaZ, k, sigmaZ );
                end 
            end
        end
    end
    
    % Sum up Jxx coupling terms
    jxx_term = 0;
    if length(Jxx) > 1
        for i=1:n
            for k=1:n
                % skip if i==k
                if i ~= k
                    jxx_term = jxx_term + Jxx(i,k)*recursive_kron_double( n, i, sigmaX, k, sigmaX );
                end 
            end
        end
    end
    
    % Sum up Jzzz coupling terms
    jzzz_term = 0;
    if length(Jzzz) > 1
        for i=1:n
            for k=1:n
                for h=1:n
                    % skip if i==k or i==h or k==h
                    if (i ~= k) && (i ~= h) && (k ~= h)
                        jzzz_term = jzzz_term + Jzzz(i,k,h)*recursive_kron_triple( n, i, sigmaZ, k, sigmaZ, h, sigmaZ );
                    end
                end 
            end
        end
    end
    
    % Sum up Jxxx coupling terms
    jxxx_term = 0;
    if length(Jxxx) > 1
        for i=1:n
            for k=1:n
                for h=1:n
                    % skip if i==k or i==h or k==h
                    if (i ~= k) && (i ~= h) && (k ~= h)
                        jxxx_term = jxxx_term + Jxxx(i,k,h)*recursive_kron_triple( n, i, sigmaX, k, sigmaX, h, sigmaX );
                    end
                end 
            end
        end
    end

    % combine local and coupling components
    out = h_term + jzz_term + jxx_term + jzzz_term + jxxx_term;
end

