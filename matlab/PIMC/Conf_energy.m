function [ out ] = Conf_energy(spinConfig, HParams)
  
    % Unpack parameters
    [h, Jzz, Jxx, Jzzz, Jxxx] = deal(HParams{:});
    
    % Number of spins
    num_spins = length(spinConfig);
    
    % Initialise terms to 0
    h_term = 0;
    Jzz_term = 0;
    Jxx_term = 0;
    Jzzz_term = 0;
    Jxxx_term = 0;
    
    % H term
    if length(h) > 1 
        h_term = spinConfig .* h;
    end
    
    % Jzz term
    if length(Jzz) > 1
        % If not symmetrised, then symmetrise
        if ~isequal(Jzz, Jzz')
            Jzz = Jzz + Jzz';
        end
        % Make 2D matrix out of copies of the 1D spin configuration
        spinConfig_2d = spinConfig'*spinConfig;
        % Intermediate step matrix
        sj_mat = spinConfig_2d.*Jzz;
        % Calculate final Jzz term
        Jzz_term = sum(sum( sj_mat ))/2;
    end
    
    % Jxx term
    if length(Jxx) > 1
        % If not symmetrised, then symmetrise
        if ~isequal(Jxx, Jxx')
            Jxx = Jxx + Jxx';
        end
        % Make 2D matrix out of copies of the 1D spin configuration
        spinConfig_2d = spinConfig'*spinConfig;
        % Intermediate step matrix
        sj_mat = spinConfig_2d.*Jxx;
        % Calculate final Jxx term
        Jxx_term = sum(sum( sj_mat ))/2;
    end
    
    % Jzzz term
    if length(Jzzz) > 1
        % If not symmetrised, then symmetrise
        if isequal( Jzzz, permute(Jzzz, [3,2,1]) )
            Jzzz = symmetrize3local(Jzzz);
        end

        % Spins 1 and 2 array
        spinConfig_1_2_spin = repmat(spinConfig'*spinConfig,1,1,num_spins);
        % Spins 3 array
        spinConfig_3_spin = permute( repmat(spinConfig,num_spins,1,num_spins) ,[3,1,2]);
        % Intermediate step matrix
        sj_mat = (spinConfig_1_2_spin.*spinConfig_3_spin).*Jzzz;
        % Calculate final Jzzz term
        Jzzz_term = sum(sum(sum( sj_mat )))/6;
    end
    
        
    % Jxxx term
    if length(Jxxx) > 1
        % If not symmetrised, then symmetrise
        if isequal( Jxxx, permute(Jxxx, [3,2,1]) )
            Jxxx = symmetrize3local(Jxxx);
        end

        % Spins 1 and 2 array
        spinConfig_1_2_spin = repmat(spinConfig'*spinConfig,1,1,num_spins);
        % Spins 3 array
        spinConfig_3_spin = permute( repmat(spinConfig,num_spins,1,num_spins) ,[3,1,2]);
        % Intermediate step matrix
        sj_mat = (spinConfig_1_2_spin.*spinConfig_3_spin).*Jxxx;
        % Calculate final Jxxx term
        Jxxx_term = sum(sum(sum( sj_mat )))/6;
    end
    
    % Sum up terms
    out = h_term + Jzz_term + Jxx_term + Jzzz_term + Jxxx_term;
end
        
        
        
    
    
