function [ out ] = eigvec_indices_to_config( num_qubits, eigvec_indices )
    
    % Empty spin config array
    spin_config_array = zeros(numel(eigvec_indices), num_qubits);
    % For all indices
    for i = 1:numel(eigvec_indices)
        % Binary representation of spin config
        spin_config_bin = dec2bin(eigvec_indices(i) - 1);
        % Convert binary string to array
        spin_config = str2num(reshape(spin_config_bin',[],1))';
         % If length spin_config < num_qubits, then pad it
        if length(spin_config < num_qubits)
            spin_config = [zeros(1, (num_qubits-length(spin_config)) ),spin_config];
        end
        spin_config_array(i,:) = spin_config;
    end
    
    % Return spin configurations
    out = spin_config_array;
end