function [ out ] = eig_info( vec, val, excited_level, eigvec_indices_specified )
    % Given eigenvectors and eigenvalues, print them along with spin
    % configuarations
    
    % Number of qubits
    num_qubits = log2(length(diag(val)));
    
    % Loop over all specified levels
    for level = excited_level
        
        if nargin == 4
            % Use specified indices
            eigvec_indices = eigvec_indices_specified;
        else
            % Use non-zero indicies
            eigvec_indices = find(vec(:,level));
        end
        
        % Get configurations of non-zero states in eigenvector
        eigvec_configs = eigvec_indices_to_config( num_qubits, eigvec_indices );

        % Display eigenvalue
        disp(sprintf(strcat( ...
            'Eigenvalue:\t', num2str( val(level,level) ) ...
        )));

        % Display configurations and weights
        for i = 1:numel(eigvec_indices)
            disp(sprintf(strcat( ...
                'Config:\t', num2str( eigvec_configs(i,:) ), ...
                '\tWeigth:\t' , num2str( abs(vec(eigvec_indices(i),level)) ) ...
            )));
        end
    end
    
end

